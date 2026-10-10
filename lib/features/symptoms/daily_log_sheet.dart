import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/math_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/option_pill.dart';

/// بخش‌های فرم ثبت روزانه — برای پریدن مستقیم به یک بخش.
enum LogSection { flow, mood, pain, energy, sleep, symptoms }

/// فرم ثبت روزانه رو برای [date] باز می‌کنه. روزهای آینده قابل ثبت نیستن.
Future<void> showDailyLogSheet(
  BuildContext context, {
  required WidgetRef ref,
  required DateTime date,
  LogSection? focus,
}) async {
  final today = ref.read(todayProvider);
  if (dayOnly(date).isAfter(today)) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n?.futureDayNotAllowed ?? ''),
        ),
      );
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => DailyLogSheet(date: dayOnly(date), focus: focus),
  );
}

class DailyLogSheet extends ConsumerStatefulWidget {
  final DateTime date;
  final LogSection? focus;

  const DailyLogSheet({super.key, required this.date, this.focus});

  @override
  ConsumerState<DailyLogSheet> createState() => _DailyLogSheetState();
}

class _DailyLogSheetState extends ConsumerState<DailyLogSheet> {
  final _noteController = TextEditingController();
  final _sectionKeys = {
    for (final section in LogSection.values) section: GlobalKey(),
  };

  DailyLog? _existing;
  FlowLevel? _flow;
  Mood? _mood;
  int? _pain;
  int? _energy;
  int? _sleepMinutes;
  Set<String> _symptoms = <String>{};

  @override
  void initState() {
    super.initState();

    final existing = ref.read(logsProvider)[dayKey(widget.date)];
    _existing = existing;
    if (existing != null) {
      _flow = existing.flow;
      _mood = existing.mood;
      _pain = existing.pain;
      _energy = existing.energy;
      _sleepMinutes = existing.sleepMinutes;
      _symptoms = Set<String>.of(existing.symptoms);
      _noteController.text = existing.note;
    }

    final focus = widget.focus;
    if (focus != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = _sectionKeys[focus]?.currentContext;
        if (target != null) {
          Scrollable.ensureVisible(
            target,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final existing = _existing;
    final log = DailyLog(
      date: widget.date,
      flow: _flow,
      mood: _mood,
      pain: _pain,
      energy: _energy,
      sleepMinutes: _sleepMinutes,
      symptoms: _symptoms,
      note: _noteController.text,
      // مقدارهای صفحه‌ی سلامت دست‌نخورده می‌مونن
      weightKg: existing?.weightKg,
      temperatureC: existing?.temperatureC,
      waterGlasses: existing?.waterGlasses,
    );

    await ref.read(logsProvider.notifier).save(log);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    await ref.read(logsProvider.notifier).delete(widget.date);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final calendar = ref.watch(appCalendarProvider);
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;
    final mediaQuery = MediaQuery.of(context);
    final sleepMinutes = _sleepMinutes;

    Widget sectionTitle(LogSection? section, IconData icon, String title) {
      return Padding(
        key: section == null ? null : _sectionKeys[section],
        padding: const EdgeInsets.only(top: 22, bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: theme.colorScheme.primary.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.88),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.dailyCheckIn,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          calendar.weekdayDayMonth(widget.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_existing != null)
                    IconButton(
                      tooltip: l10n.delete,
                      onPressed: _delete,
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: theme.colorScheme.error,
                    ),
                  IconButton(
                    tooltip: l10n.cancel,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    color: subtitleColor,
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------- خونریزی ----------
                    sectionTitle(
                      LogSection.flow,
                      Icons.water_drop_outlined,
                      l10n.flow,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final level in FlowLevel.values)
                          OptionPill(
                            label: Labels.flow(l10n, level),
                            selected: _flow == level,
                            onTap: () => setState(
                              () => _flow = _flow == level ? null : level,
                            ),
                          ),
                      ],
                    ),

                    // ---------- خلق‌وخو ----------
                    sectionTitle(
                      LogSection.mood,
                      Icons.sentiment_satisfied_alt_outlined,
                      l10n.mood,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final mood in Mood.values)
                          OptionPill(
                            icon: Labels.moodIcon(mood),
                            label: Labels.mood(l10n, mood),
                            selected: _mood == mood,
                            onTap: () => setState(
                              () => _mood = _mood == mood ? null : mood,
                            ),
                          ),
                      ],
                    ),

                    // ---------- درد ----------
                    sectionTitle(
                      LogSection.pain,
                      Icons.bolt_outlined,
                      l10n.pain,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var level = 0; level <= 3; level++)
                          OptionPill(
                            label: Labels.pain(l10n, level),
                            selected: _pain == level,
                            onTap: () => setState(
                              () => _pain = _pain == level ? null : level,
                            ),
                          ),
                      ],
                    ),

                    // ---------- انرژی ----------
                    sectionTitle(LogSection.energy, Icons.air, l10n.energy),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var level = 1; level <= 3; level++)
                          OptionPill(
                            label: Labels.energy(l10n, level),
                            selected: _energy == level,
                            onTap: () => setState(
                              () => _energy = _energy == level ? null : level,
                            ),
                          ),
                      ],
                    ),

                    // ---------- خواب ----------
                    sectionTitle(
                      LogSection.sleep,
                      Icons.nightlight_outlined,
                      l10n.sleep,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            sleepMinutes == null
                                ? l10n.notSet
                                : context.n(Labels.sleep(l10n, sleepMinutes)),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: sleepMinutes == null
                                  ? subtitleColor
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        if (sleepMinutes != null)
                          TextButton(
                            onPressed: () =>
                                setState(() => _sleepMinutes = null),
                            child: Text(l10n.clear),
                          ),
                      ],
                    ),
                    Slider(
                      value: clampDouble((sleepMinutes ?? 0) / 30, 0, 24),
                      min: 0,
                      max: 24,
                      divisions: 24,
                      onChanged: (value) => setState(
                        () => _sleepMinutes = value.round() * 30,
                      ),
                    ),

                    // ---------- علائم ----------
                    sectionTitle(
                      LogSection.symptoms,
                      Icons.eco_outlined,
                      l10n.symptoms,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final id in SymptomIds.all)
                          OptionPill(
                            label: Labels.symptom(l10n, id),
                            selected: _symptoms.contains(id),
                            onTap: () => setState(() {
                              if (!_symptoms.remove(id)) _symptoms.add(id);
                            }),
                          ),
                      ],
                    ),

                    // ---------- یادداشت ----------
                    sectionTitle(null, Icons.edit_outlined, l10n.note),
                    TextField(
                      controller: _noteController,
                      minLines: 2,
                      maxLines: 4,
                      maxLength: 500,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: l10n.noteHint,
                        counterText: '',
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _save,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    l10n.save,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
