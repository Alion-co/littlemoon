// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get homeGreeting => 'Buenas tardes';

  @override
  String dayOfCycle(int day) {
    return 'Día $day';
  }

  @override
  String get ofYourCycle => 'de tu ciclo';

  @override
  String get follicularPhase => 'Fase folicular';

  @override
  String get lutealPhase => 'Fase lútea';

  @override
  String get menstrualPhase => 'Fase menstrual';

  @override
  String get ovulationPhase => 'Fase de ovulación';

  @override
  String daysUntilPeriod(int days) {
    return 'Faltan $days días para tu próxima regla';
  }

  @override
  String get cycleHealthy => 'Tu ciclo está dentro de tu rango habitual.';

  @override
  String get dailyCheckIn => 'Registro diario';

  @override
  String get howAreYouFeeling => '¿Cómo te sientes hoy?';

  @override
  String get flow => 'Flujo';

  @override
  String get mood => 'Ánimo';

  @override
  String get pain => 'Dolor';

  @override
  String get energy => 'Energía';

  @override
  String get sleep => 'Sueño';

  @override
  String get symptoms => 'Síntomas';

  @override
  String get todaysSummary => 'Resumen de hoy';

  @override
  String get logToday => 'Registrar\nhoy';

  @override
  String get good => 'Bien';

  @override
  String get medium => 'Medio';

  @override
  String get mild => 'Leve';

  @override
  String get yourCycleInsights => 'Datos de tu ciclo';

  @override
  String get averageCycle => 'Ciclo medio';

  @override
  String get recentPattern => 'Patrón reciente';

  @override
  String get days => 'días';

  @override
  String get home => 'Inicio';

  @override
  String get calendar => 'Calendario';

  @override
  String get insights => 'Análisis';

  @override
  String get health => 'Salud';

  @override
  String get profile => 'Perfil';

  @override
  String get month => 'Mes';

  @override
  String get week => 'Semana';

  @override
  String get period => 'Regla';

  @override
  String get fertile => 'Fértil';

  @override
  String get ovulation => 'Ovulación';

  @override
  String get periodDay => 'Día de regla';

  @override
  String get fertileWindow => 'Ventana fértil';

  @override
  String get ovulationDay => 'Día de ovulación';

  @override
  String get noDataLogged => 'Sin datos registrados';

  @override
  String get logButton => 'Registrar';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get clear => 'Borrar';

  @override
  String get ok => 'Entendido';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get undo => 'Deshacer';

  @override
  String get today => 'Hoy';

  @override
  String get notSet => 'Sin registrar';

  @override
  String get notEnoughData => 'Datos insuficientes';

  @override
  String get invalidValue => 'Ese valor no parece correcto.';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodAfternoon => 'Buenas tardes';

  @override
  String get goodNight => 'Buenas noches';

  @override
  String periodDayNumber(int day) {
    return 'Día $day de tu regla';
  }

  @override
  String periodLateBy(int days) {
    return 'Tu regla lleva $days días de retraso';
  }

  @override
  String get periodLateOneDay => 'Tu regla lleva 1 día de retraso';

  @override
  String get periodExpectedToday => 'Tu regla se espera hoy';

  @override
  String get periodExpectedTomorrow => 'Tu regla se espera mañana';

  @override
  String get cycleLateNote =>
      'Tu regla lleva más de una semana de retraso. Si continúa, considera hacerte una prueba de embarazo o consultar a un médico.';

  @override
  String get cycleIrregularNote =>
      'Tus últimos ciclos varían en duración, así que las predicciones son menos precisas.';

  @override
  String get periodStartedToday => 'Mi regla empezó hoy';

  @override
  String get periodContinuesToday => 'Hoy sigo con la regla';

  @override
  String get periodLoggedToday => 'Regla registrada para hoy';

  @override
  String get noCycleDataTitle => 'Aún no hay reglas registradas';

  @override
  String get noCycleDataBody =>
      'Registra el primer día de tu última regla para que Little Moon empiece a predecir tu ciclo.';

  @override
  String get logLastPeriod => 'Registrar mi última regla';

  @override
  String get predictionInfoTitle => '¿Cómo se calcula?';

  @override
  String get predictionInfoBody =>
      'Tu próxima regla se calcula a partir de la duración media de tus últimos ciclos registrados. La ovulación se estima unos 14 días antes de la próxima regla, y la ventana fértil va desde 5 días antes de la ovulación hasta 1 día después.\n\nCuantas más reglas registres, más precisa será. Son estimaciones: no las uses como método anticonceptivo.';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get noReminders => 'Hoy no hay nada que recordarte.';

  @override
  String reminderPeriodSoon(int days) {
    return 'Tu regla se espera en $days días.';
  }

  @override
  String get reminderPeriodTomorrow => 'Tu regla se espera mañana.';

  @override
  String get reminderPeriodToday => 'Tu regla se espera hoy.';

  @override
  String get reminderFertileSoon => 'Tu ventana fértil empieza mañana.';

  @override
  String get reminderFertileToday => 'Estás en tu ventana fértil.';

  @override
  String get reminderOvulationToday => 'Hoy es tu día estimado de ovulación.';

  @override
  String get reminderLogToday => 'Hoy todavía no has registrado nada.';

  @override
  String get remindersHint =>
      'Recibirás una notificación en el teléfono a las 9:00 para los recordatorios del ciclo y a las 21:00 para el registro diario. También aparecen en la campana de la pantalla de inicio.';

  @override
  String get reminderPeriodSetting => 'Regla próxima';

  @override
  String get reminderDaysBefore => 'Avisarme antes';

  @override
  String get reminderFertileSetting => 'Ventana fértil';

  @override
  String get reminderOvulationSetting => 'Día de ovulación';

  @override
  String get reminderLogSetting => 'Registro diario';

  @override
  String get futureDayNotAllowed => 'Solo puedes registrar hoy o días pasados.';

  @override
  String get flowNone => 'Sin flujo';

  @override
  String get flowSpotting => 'Manchado';

  @override
  String get flowLight => 'Ligero';

  @override
  String get flowMedium => 'Medio';

  @override
  String get flowHeavy => 'Abundante';

  @override
  String get moodHappy => 'Feliz';

  @override
  String get moodCalm => 'Tranquila';

  @override
  String get moodSensitive => 'Sensible';

  @override
  String get moodSad => 'Triste';

  @override
  String get moodIrritable => 'Irritable';

  @override
  String get moodAnxious => 'Ansiosa';

  @override
  String get painNone => 'Sin dolor';

  @override
  String get painSevere => 'Intenso';

  @override
  String get energyLow => 'Baja';

  @override
  String get energyHigh => 'Alta';

  @override
  String get symptomCramps => 'Cólicos';

  @override
  String get symptomHeadache => 'Dolor de cabeza';

  @override
  String get symptomBackPain => 'Dolor de espalda';

  @override
  String get symptomBloating => 'Hinchazón';

  @override
  String get symptomBreastTenderness => 'Sensibilidad en los senos';

  @override
  String get symptomAcne => 'Acné';

  @override
  String get symptomNausea => 'Náuseas';

  @override
  String get symptomFatigue => 'Cansancio';

  @override
  String get symptomCravings => 'Antojos';

  @override
  String get symptomInsomnia => 'Insomnio';

  @override
  String get symptomDizziness => 'Mareo';

  @override
  String get symptomDischarge => 'Flujo vaginal';

  @override
  String get note => 'Nota';

  @override
  String get noteHint => 'Lo que quieras recordar de hoy…';

  @override
  String sleepHours(int hours) {
    return '$hours h';
  }

  @override
  String sleepHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get predicted => 'Previsto';

  @override
  String get predictedPeriodDay => 'Regla prevista';

  @override
  String cycleDayShort(int day) {
    return 'Día $day del ciclo';
  }

  @override
  String get dataLogged => 'Registrado';

  @override
  String get insightsEmpty =>
      'Cuando registres tu primera regla, aquí aparecerán las estadísticas y predicciones de tu ciclo.';

  @override
  String get averagePeriod => 'Regla media';

  @override
  String get regularity => 'Regularidad';

  @override
  String get regular => 'Regular';

  @override
  String get irregular => 'Irregular';

  @override
  String get cyclesTracked => 'Ciclos registrados';

  @override
  String get predictions => 'Predicciones';

  @override
  String get nextPeriod => 'Próxima regla';

  @override
  String get followingPeriod => 'Regla siguiente';

  @override
  String get cycleHistory => 'Historial de ciclos';

  @override
  String get historyEmpty =>
      'La duración de tus ciclos aparecerá aquí cuando registres al menos dos reglas.';

  @override
  String get topSymptoms => 'Síntomas más frecuentes';

  @override
  String get last90Days => 'Últimos 90 días';

  @override
  String get noSymptomsLogged => 'Aún no hay síntomas registrados.';

  @override
  String get moodSummary => 'Ánimo';

  @override
  String get noMoodLogged => 'Aún no hay ánimo registrado.';

  @override
  String get medicalDisclaimer =>
      'Las predicciones son estimaciones basadas en lo que registras. No son consejo médico y no deben usarse como método anticonceptivo.';

  @override
  String get yourBody => 'Tu cuerpo';

  @override
  String get tipsForYou => 'Consejos para esta fase';

  @override
  String get todayTracking => 'Hoy';

  @override
  String get water => 'Agua';

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count de $goal vasos';
  }

  @override
  String get weight => 'Peso';

  @override
  String get weightHint => 'p. ej. 58.5';

  @override
  String get kg => 'kg';

  @override
  String get bodyTemperature => 'Temperatura corporal';

  @override
  String get temperatureHint => 'p. ej. 36.6';

  @override
  String get tapToAdd => 'Toca para añadir';

  @override
  String get averageSleep7 => 'Sueño medio (7 días)';

  @override
  String get pregnancyChanceToday => 'Probabilidad de embarazo hoy';

  @override
  String get chanceLow => 'Baja';

  @override
  String get chanceMedium => 'Media';

  @override
  String get chanceHigh => 'Alta';

  @override
  String get aboutMenstrual =>
      'La regla marca el inicio de un nuevo ciclo. El revestimiento del útero se desprende y es normal sentir menos energía durante unos días.';

  @override
  String get aboutFollicular =>
      'Después de la regla, el estrógeno sube y tu cuerpo se prepara para liberar un óvulo. La mayoría se siente con más energía y concentración en esta fase.';

  @override
  String get aboutOvulation =>
      'El óvulo se libera por estos días. Es la parte más fértil de tu ciclo.';

  @override
  String get aboutLuteal =>
      'Tras la ovulación sube la progesterona. En los días previos a la regla puedes notar síntomas premenstruales como hinchazón, senos sensibles o cambios de ánimo.';

  @override
  String get aboutNoData =>
      'Registra tu regla para ver en qué fase del ciclo estás y recibir consejos adecuados.';

  @override
  String get tipMenstrual1 =>
      'Descansa cuando lo necesites. El movimiento suave, como caminar o estirarte, puede aliviar los cólicos.';

  @override
  String get tipMenstrual2 =>
      'Una compresa tibia en el bajo vientre puede ayudar con el dolor.';

  @override
  String get tipMenstrual3 =>
      'Los alimentos ricos en hierro, como lentejas, espinacas y carne roja, junto con suficiente agua, te ayudan a recuperarte.';

  @override
  String get tipFollicular1 =>
      'La energía suele subir en esta fase, así que es buen momento para ejercicio más intenso.';

  @override
  String get tipFollicular2 =>
      'Buen momento para empezar planes nuevos o tareas que requieren concentración.';

  @override
  String get tipFollicular3 =>
      'Mantén tus comidas equilibradas con proteína y verduras frescas.';

  @override
  String get tipOvulation1 => 'Este es el momento más fértil de tu ciclo.';

  @override
  String get tipOvulation2 =>
      'Un dolor leve en un lado del bajo vientre o un flujo más transparente suele ser normal alrededor de la ovulación.';

  @override
  String get tipOvulation3 =>
      'La energía y el ánimo suelen estar en su mejor momento; disfruta de estar activa.';

  @override
  String get tipLuteal1 =>
      'Pueden aparecer síntomas premenstruales como hinchazón o cambios de ánimo. Sé amable contigo misma.';

  @override
  String get tipLuteal2 =>
      'Reducir la sal, la cafeína y el azúcar puede aliviar la hinchazón y la irritabilidad.';

  @override
  String get tipLuteal3 =>
      'Da prioridad al sueño y al ejercicio suave, como yoga o caminar.';

  @override
  String get tipGeneral1 =>
      'Registra tu regla con regularidad. Las predicciones mejoran tras unos cuantos ciclos.';

  @override
  String get tipGeneral2 =>
      'Bebe suficiente agua y mantén un horario de sueño estable.';

  @override
  String get tipGeneral3 =>
      'Consulta a un médico si tus ciclos suelen durar menos de 21 o más de 35 días, o si el dolor es intenso.';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get nameHint => '¿Cómo te llamamos?';

  @override
  String get noName => 'Querida amiga';

  @override
  String trackingSince(String date) {
    return 'Registrando desde $date';
  }

  @override
  String get daysLogged => 'Días registrados';

  @override
  String get periodsLogged => 'Reglas registradas';

  @override
  String get cycleSettings => 'Ajustes del ciclo';

  @override
  String get cycleSettingsHint =>
      'Se usan para las predicciones hasta que registres algunos ciclos.';

  @override
  String get cycleLength => 'Duración del ciclo';

  @override
  String get cycleLengthHint =>
      'Desde el primer día de una regla hasta el primer día de la siguiente. Normalmente de 21 a 35 días.';

  @override
  String get periodLength => 'Duración de la regla';

  @override
  String get periodLengthHint =>
      'Cuántos días suele durar tu sangrado. Normalmente de 3 a 7 días.';

  @override
  String get lutealLength => 'Duración de la fase lútea';

  @override
  String get lutealLengthHint =>
      'Días entre la ovulación y tu próxima regla. Déjalo en 14 si no conoces el tuyo.';

  @override
  String get privacyNote =>
      'Todo se queda en este dispositivo. Little Moon funciona totalmente sin conexión y nunca envía tus datos a ningún sitio.';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get calendarType => 'Calendario';

  @override
  String get calendarJalali => 'Persa (solar)';

  @override
  String get calendarGregorian => 'Gregoriano';

  @override
  String get theme => 'Tema';

  @override
  String get themeMoon => 'Luna';

  @override
  String get themeSakura => 'Sakura';

  @override
  String get themeLavender => 'Lavanda';

  @override
  String get themeOcean => 'Océano';

  @override
  String get themeMint => 'Menta';

  @override
  String get themeSunset => 'Atardecer';

  @override
  String get themeMidnight => 'Medianoche';

  @override
  String get themeNightRose => 'Rosa nocturna';

  @override
  String get dataAndBackup => 'Datos y copia de seguridad';

  @override
  String get backupHint =>
      'Tu copia es texto sin formato que puedes guardar donde quieras.';

  @override
  String get copyBackup => 'Copiar la copia al portapapeles';

  @override
  String get backupCopied => 'Copia copiada. Pégala en un lugar seguro.';

  @override
  String get restoreBackup => 'Restaurar desde una copia';

  @override
  String get restoreHint => 'Pega aquí el texto de tu copia';

  @override
  String get restoreInvalid => 'Esto no es una copia válida de Little Moon.';

  @override
  String get restoreConfirm =>
      'Esto reemplaza todo lo que hay ahora en la app por la copia. ¿Continuar?';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoreDone => 'Copia restaurada.';

  @override
  String get deleteAllData => 'Eliminar todos los datos';

  @override
  String get deleteAllConfirm =>
      'Todos tus registros, tu perfil y tus ajustes se eliminarán de forma permanente. No se puede deshacer.';

  @override
  String get onboardingWelcomeTitle => 'Te damos la bienvenida';

  @override
  String get onboardingWelcomeBody =>
      'Little Moon te ayuda a registrar tu regla y saber qué viene después. Unas preguntas rápidas para empezar.';

  @override
  String get lastPeriodQuestion => '¿Cuándo empezó tu última regla?';

  @override
  String get lastPeriodHint =>
      'Elige el primer día de sangrado. Puedes cambiarlo después.';

  @override
  String get dontRemember => 'No lo recuerdo';

  @override
  String get periodLengthQuestion => '¿Cuánto suele durar tu regla?';

  @override
  String get cycleLengthQuestion => '¿Cuánto suele durar tu ciclo?';

  @override
  String get getStarted => 'Empezar';

  @override
  String get insightsTitle => 'Análisis del ciclo';

  @override
  String get dedication => 'Esta app está dedicada a mi pequeña luna';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get chooseAvatar => 'Elige tu avatar';

  @override
  String get aboutDeveloper => 'Acerca del desarrollador';

  @override
  String get aboutAppBody =>
      'Little Moon es una plataforma privada, gratuita y sin conexión para que niñas y mujeres registren su menstruación. Predice tu ciclo mensual a partir de la información que tú misma registras y te lo muestra. Todos tus datos se guardan únicamente en tu propio teléfono.';

  @override
  String appVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get developer => 'Creado por';

  @override
  String get email => 'Correo';

  @override
  String get website => 'Sitio web';

  @override
  String get telegram => 'Telegram';

  @override
  String get instagram => 'Instagram';

  @override
  String get copied => 'Copiado';

  @override
  String get madeWithLove => 'Creado por ALION';
}
