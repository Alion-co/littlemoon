import '../../core/utils/day_utils.dart';

enum FlowLevel { none, spotting, light, medium, heavy }

enum Mood { happy, calm, sensitive, sad, irritable, anxious }

/// شناسه‌ی علائم قابل ثبت (ترجمه‌شون در لایه‌ی UI انجام می‌شه).
abstract final class SymptomIds {
  static const cramps = 'cramps';
  static const headache = 'headache';
  static const backPain = 'backPain';
  static const bloating = 'bloating';
  static const breastTenderness = 'breastTenderness';
  static const acne = 'acne';
  static const nausea = 'nausea';
  static const fatigue = 'fatigue';
  static const cravings = 'cravings';
  static const insomnia = 'insomnia';
  static const dizziness = 'dizziness';
  static const discharge = 'discharge';

  static const all = [
    cramps,
    headache,
    backPain,
    bloating,
    breastTenderness,
    acne,
    nausea,
    fatigue,
    cravings,
    insomnia,
    dizziness,
    discharge,
  ];
}

T? _enumByName<T extends Enum>(List<T> values, Object? name) {
  if (name is! String) return null;
  for (final value in values) {
    if (value.name == name) return value;
  }
  return null;
}

int? _asInt(Object? value) => value is num ? value.toInt() : null;

double? _asDouble(Object? value) => value is num ? value.toDouble() : null;

/// همه‌ی چیزهایی که کاربر برای یک روز ثبت کرده.
class DailyLog {
  final DateTime date;
  final FlowLevel? flow;
  final Mood? mood;

  /// ۰ = بدون درد، ۱ = خفیف، ۲ = متوسط، ۳ = شدید
  final int? pain;

  /// ۱ = کم، ۲ = متوسط، ۳ = زیاد
  final int? energy;
  final int? sleepMinutes;
  final Set<String> symptoms;
  final String note;
  final double? weightKg;
  final double? temperatureC;
  final int? waterGlasses;

  DailyLog({
    required DateTime date,
    this.flow,
    this.mood,
    this.pain,
    this.energy,
    this.sleepMinutes,
    Set<String>? symptoms,
    this.note = '',
    this.weightKg,
    this.temperatureC,
    this.waterGlasses,
  })  : date = dayOnly(date),
        symptoms = symptoms ?? const <String>{};

  /// روز پریود حساب می‌شه اگه خونریزی واقعی ثبت شده باشه
  /// (لکه‌بینی شروع پریود حساب نمی‌شه).
  bool get isPeriodDay =>
      flow == FlowLevel.light ||
      flow == FlowLevel.medium ||
      flow == FlowLevel.heavy;

  bool get isEmpty =>
      flow == null &&
      mood == null &&
      pain == null &&
      energy == null &&
      sleepMinutes == null &&
      symptoms.isEmpty &&
      note.trim().isEmpty &&
      weightKg == null &&
      temperatureC == null &&
      (waterGlasses == null || waterGlasses == 0);

  DailyLog withFlow(FlowLevel? value) => _copy(flow: value, setFlow: true);

  DailyLog withWater(int? value) => _copy(water: value, setWater: true);

  DailyLog withWeight(double? value) => _copy(weight: value, setWeight: true);

  DailyLog withTemperature(double? value) =>
      _copy(temperature: value, setTemperature: true);

  DailyLog _copy({
    FlowLevel? flow,
    bool setFlow = false,
    int? water,
    bool setWater = false,
    double? weight,
    bool setWeight = false,
    double? temperature,
    bool setTemperature = false,
  }) {
    return DailyLog(
      date: date,
      flow: setFlow ? flow : this.flow,
      mood: mood,
      pain: pain,
      energy: energy,
      sleepMinutes: sleepMinutes,
      symptoms: symptoms,
      note: note,
      weightKg: setWeight ? weight : weightKg,
      temperatureC: setTemperature ? temperature : temperatureC,
      waterGlasses: setWater ? water : waterGlasses,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (flow != null) map['flow'] = flow!.name;
    if (mood != null) map['mood'] = mood!.name;
    if (pain != null) map['pain'] = pain;
    if (energy != null) map['energy'] = energy;
    if (sleepMinutes != null) map['sleep'] = sleepMinutes;
    if (symptoms.isNotEmpty) map['symptoms'] = symptoms.toList();
    if (note.trim().isNotEmpty) map['note'] = note.trim();
    if (weightKg != null) map['weight'] = weightKg;
    if (temperatureC != null) map['temp'] = temperatureC;
    if (waterGlasses != null) map['water'] = waterGlasses;
    return map;
  }

  factory DailyLog.fromJson(DateTime date, Map<String, dynamic> json) {
    final rawSymptoms = json['symptoms'];
    final rawNote = json['note'];
    return DailyLog(
      date: date,
      flow: _enumByName(FlowLevel.values, json['flow']),
      mood: _enumByName(Mood.values, json['mood']),
      pain: _asInt(json['pain']),
      energy: _asInt(json['energy']),
      sleepMinutes: _asInt(json['sleep']),
      symptoms: rawSymptoms is List
          ? rawSymptoms.whereType<String>().toSet()
          : <String>{},
      note: rawNote is String ? rawNote : '',
      weightKg: _asDouble(json['weight']),
      temperatureC: _asDouble(json['temp']),
      waterGlasses: _asInt(json['water']),
    );
  }
}
