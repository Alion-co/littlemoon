import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'sections/choice_wrap.dart';
import 'sections/log_block.dart';
import 'sections/log_card.dart';
import 'sections/log_sheet_chrome.dart';
import 'sections/note_field.dart';
import 'sections/sleep_section.dart';
import 'sections/symptoms_section.dart';

/// بخش‌های فرم ثبت روزانه — برای پریدن مستقیم به یک بخش.
enum LogSection { flow, mood, pain, energy, sleep, symptoms }

/// کارت‌های جمع‌شونده‌ی فرم.
enum _Card { general, physical, note }

/// هر بخش داخل کدوم کارته (برای باز کردن کارت موقع پریدن به یک بخش).
_Card _cardOf(LogSection section) => switch (section) {
  LogSection.mood || LogSection.energy || LogSection.sleep => _Card.general,
  LogSection.flow || LogSection.pain || LogSection.symptoms => _Card.physical,
};

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
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
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

  /// کارت‌های بازِ فعلی. یادداشت از اول بازه تا کادرش دیده بشه.
  final Set<_Card> _open = {_Card.note};

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
      _open.add(_cardOf(focus));
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
    Haptics.success();
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    await ref.read(logsProvider.notifier).delete(widget.date);
    if (mounted) Navigator.of(context).pop();
  }

  void _toggle(_Card card) => setState(() {
    if (!_open.remove(card)) _open.add(card);
  });

  /// «سردرد، نفخ» یا «سردرد، نفخ…»؛ جداکننده بر اساس زبان.
  String _symptomsSummary(AppLocalizations l10n) {
    if (_symptoms.isEmpty) return '';
    final separator = (l10n.localeName == 'fa' || l10n.localeName == 'ar')
        ? '، '
        : ', ';
    return [
      for (final id in SymptomIds.all)
        if (_symptoms.contains(id)) Labels.symptom(l10n, id),
    ].join(separator);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final calendar = ref.watch(appCalendarProvider);
    final mediaQuery = MediaQuery.of(context);
    final background = context.theme.scaffoldBackgroundColor;

    final sleep = _sleepMinutes;
    final showHero =
        !_open.contains(_Card.general) && !_open.contains(_Card.physical);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.92),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [context.tintA, background],
              stops: const [0, 0.5],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LogSheetHeader(
                calendar: calendar,
                date: widget.date,
                onDelete: _existing != null ? _delete : null,
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: showHero
                            ? const LogHero()
                            : const SizedBox(width: double.infinity),
                      ),
                      LogCard(
                        icon: Icons.sentiment_satisfied_alt_outlined,
                        title: l10n.logSectionGeneral,
                        expanded: _open.contains(_Card.general),
                        onToggle: () => _toggle(_Card.general),
                        summary: [
                          LogSummaryItem(
                            l10n.mood,
                            _mood == null ? null : Labels.mood(l10n, _mood!),
                          ),
                          LogSummaryItem(
                            l10n.energy,
                            _energy == null
                                ? null
                                : Labels.energy(l10n, _energy!),
                          ),
                          LogSummaryItem(
                            l10n.sleep,
                            sleep == null
                                ? null
                                : context.n(Labels.sleep(l10n, sleep)),
                          ),
                        ],
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LogBlock(
                              first: true,
                              anchorKey: _sectionKeys[LogSection.mood],
                              icon: Icons.sentiment_satisfied_alt_outlined,
                              title: l10n.mood,
                              child: MoodGrid<Mood>(
                                values: Mood.values,
                                selected: _mood,
                                onChanged: (v) => setState(() => _mood = v),
                                labelOf: (mood) => Labels.mood(l10n, mood),
                                iconOf: Labels.moodIcon,
                              ),
                            ),
                            LogBlock(
                              anchorKey: _sectionKeys[LogSection.energy],
                              icon: Icons.bolt_outlined,
                              title: l10n.energy,
                              child: ChoiceWrap<int>(
                                values: const [1, 2, 3],
                                selected: _energy,
                                onChanged: (v) => setState(() => _energy = v),
                                labelOf: (level) => Labels.energy(l10n, level),
                              ),
                            ),
                            LogBlock(
                              anchorKey: _sectionKeys[LogSection.sleep],
                              icon: Icons.nightlight_outlined,
                              title: l10n.sleep,
                              trailing: SleepValueLabel(
                                minutes: _sleepMinutes,
                                onClear: () =>
                                    setState(() => _sleepMinutes = null),
                              ),
                              child: SleepControl(
                                minutes: _sleepMinutes,
                                onChanged: (v) =>
                                    setState(() => _sleepMinutes = v),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      LogCard(
                        icon: Icons.water_drop_outlined,
                        title: l10n.logSectionPhysical,
                        expanded: _open.contains(_Card.physical),
                        onToggle: () => _toggle(_Card.physical),
                        summary: [
                          LogSummaryItem(
                            l10n.flow,
                            _flow == null ? null : Labels.flow(l10n, _flow!),
                          ),
                          LogSummaryItem(
                            l10n.pain,
                            _pain == null ? null : Labels.pain(l10n, _pain!),
                          ),
                          LogSummaryItem(
                            l10n.symptoms,
                            _symptomsSummary(l10n),
                          ),
                        ],
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LogBlock(
                              first: true,
                              anchorKey: _sectionKeys[LogSection.flow],
                              icon: Icons.water_drop_outlined,
                              title: l10n.flow,
                              child: ChoiceWrap<FlowLevel>(
                                values: FlowLevel.values,
                                selected: _flow,
                                onChanged: (v) => setState(() => _flow = v),
                                labelOf: (level) => Labels.flow(l10n, level),
                              ),
                            ),
                            LogBlock(
                              anchorKey: _sectionKeys[LogSection.pain],
                              icon: Icons.bolt_outlined,
                              title: l10n.pain,
                              child: ChoiceWrap<int>(
                                values: const [0, 1, 2, 3],
                                selected: _pain,
                                onChanged: (v) => setState(() => _pain = v),
                                labelOf: (level) => Labels.pain(l10n, level),
                              ),
                            ),
                            LogBlock(
                              anchorKey: _sectionKeys[LogSection.symptoms],
                              icon: Icons.eco_outlined,
                              title: l10n.symptoms,
                              child: SymptomsWrap(
                                selected: _symptoms,
                                onToggle: (id) => setState(() {
                                  if (!_symptoms.remove(id)) _symptoms.add(id);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      LogCard(
                        icon: Icons.edit_outlined,
                        title: l10n.logSectionNote,
                        expanded: _open.contains(_Card.note),
                        onToggle: () => _toggle(_Card.note),
                        body: NoteField(controller: _noteController),
                      ),
                    ],
                  ),
                ),
              ),
              LogSaveButton(onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
