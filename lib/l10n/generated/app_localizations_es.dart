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
  String get onboardingHello => '¡Hola!';

  @override
  String get onboardingWelcomeLine => 'Te damos la bienvenida a Little Moon';

  @override
  String get onboardingTagline =>
      'Tu compañera de siempre para gestionar tu ciclo y sentirte mejor';

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
  String get dedication => 'Dedicado a mi pequeña luna';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get chooseAvatar => 'Elige tu avatar';

  @override
  String get aboutDeveloper => 'Acerca de Little Moon';

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

  @override
  String get appTitle => 'Little Moon';

  @override
  String dateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get privacySection => 'Privacidad';

  @override
  String get appLock => 'Bloqueo de la app';

  @override
  String get appLockHint => 'Protege la app con un PIN o tu huella.';

  @override
  String get appLockOn => 'El bloqueo está activado.';

  @override
  String get useBiometric => 'Desbloquear con huella';

  @override
  String get changePin => 'Cambiar PIN';

  @override
  String get pinChanged => 'PIN cambiado.';

  @override
  String get enterPin => 'Introduce tu PIN';

  @override
  String get newPin => 'Elige un PIN de 4 dígitos';

  @override
  String get confirmPin => 'Vuelve a introducir el PIN';

  @override
  String get pinMismatch => 'Los PIN no coinciden. Inténtalo de nuevo.';

  @override
  String get wrongPin => 'PIN incorrecto';

  @override
  String tooManyAttempts(int seconds) {
    return 'Demasiados intentos. Espera $seconds segundos.';
  }

  @override
  String get unlockReason => 'Desbloquear Little Moon';

  @override
  String get forgotPin => 'Olvidé mi PIN';

  @override
  String get forgotPinBody =>
      'El PIN no se puede recuperar porque tus datos nunca salen del teléfono. Puedes borrar todo y empezar de nuevo; si guardaste una copia de seguridad, podrás restaurarla después.';

  @override
  String get resetApp => 'Borrar y empezar de nuevo';

  @override
  String get discreetNotifications => 'Notificaciones discretas';

  @override
  String get discreetNotificationsHint =>
      'Los recordatorios y el widget usan un texto neutro que no revela nada de tu ciclo y no se muestran en la pantalla de bloqueo.';

  @override
  String get discreetTitle => 'Recordatorio';

  @override
  String get discreetCycleBody => 'Tienes un recordatorio nuevo.';

  @override
  String get discreetLogBody => 'Tu nota de hoy te espera.';

  @override
  String get discreetPillBody => 'Es la hora de tu recordatorio diario.';

  @override
  String get pillReminder => 'Recordatorio de la píldora';

  @override
  String get pillReminderTime => 'Hora del recordatorio';

  @override
  String get reminderPill => 'Es hora de tomar tu píldora.';

  @override
  String get widgetTitle => 'Widget de inicio';

  @override
  String get widgetHint =>
      'Mantén pulsado un espacio vacío de la pantalla de inicio, toca Widgets y añade Little Moon. Con las notificaciones discretas, el widget solo muestra el número del día.';

  @override
  String get doctorReport => 'Informe para tu médico';

  @override
  String get doctorReportHint =>
      'Un resumen en PDF de tus ciclos, síntomas y estado de ánimo, creado en este teléfono.';

  @override
  String get reportTitle => 'Informe del ciclo menstrual';

  @override
  String reportGenerated(String date) {
    return 'Preparado el $date';
  }

  @override
  String reportWindow(int days, int logged) {
    return 'Las estadísticas cubren los últimos $days días ($logged días registrados)';
  }

  @override
  String get reportSummary => 'Resumen';

  @override
  String get reportCycleRange => 'Ciclo más corto y más largo';

  @override
  String reportMinMax(int min, int max) {
    return 'de $min a $max días';
  }

  @override
  String get reportLastPeriod => 'Inicio del último periodo';

  @override
  String get reportStart => 'Fecha de inicio';

  @override
  String get reportInProgress => 'Actual';

  @override
  String get reportUnitsNote =>
      'Todos los valores están en días. * indica que probablemente no se registró un periodo en ese ciclo y no cuenta en los promedios.';

  @override
  String reportTimes(int count) {
    return '$count veces';
  }

  @override
  String get reportPainDays => 'Días con dolor moderado o intenso';

  @override
  String get reportFooter =>
      'Hecho con Little Moon a partir de los datos registrados por la usuaria';

  @override
  String get reportFailed => 'No se pudo crear el informe. Inténtalo de nuevo.';

  @override
  String get year => 'Año';

  @override
  String get quickLog => 'Registro rápido';

  @override
  String get quickLogHint => 'Se guarda con un toque';

  @override
  String get detailedLog => 'Registro detallado';

  @override
  String get saveBackupFile => 'Guardar copia en un archivo';

  @override
  String get restoreBackupFile => 'Restaurar desde un archivo';

  @override
  String get backupFileSaved => 'Copia de seguridad guardada.';

  @override
  String get backupFileFailed =>
      'No se pudo guardar el archivo; el texto de la copia se copió al portapapeles.';

  @override
  String reminderLate(int days) {
    return 'Tu periodo lleva $days días de retraso. Si ya empezó, regístralo para mantener las predicciones.';
  }

  @override
  String get lateReminderSetting => 'Retraso del periodo';

  @override
  String get autoNightTheme => 'Tema nocturno automático';

  @override
  String get autoNightThemeHint =>
      'Usa un tema nocturno cuando el teléfono está en modo oscuro.';

  @override
  String get patternsTitle => 'Tus patrones';

  @override
  String get patternsSubtitle => 'Lo que se repite en tus ciclos';

  @override
  String get patternsEmpty =>
      'Aún no hay patrones. Cuantos más ciclos registres con síntomas y estado de ánimo, más patrones aparecerán aquí.';

  @override
  String get patternsNote =>
      'Se calcula en este teléfono solo con tus registros. No es un diagnóstico médico.';

  @override
  String get patternPain => 'Dolor moderado o intenso';

  @override
  String get patternDayBefore => 'Normalmente el día antes del periodo';

  @override
  String patternDaysBefore(int days) {
    return 'Normalmente unos $days días antes del periodo';
  }

  @override
  String patternDuring(int day) {
    return 'Normalmente el día $day del periodo';
  }

  @override
  String patternSeen(int cycles) {
    return 'en $cycles ciclos';
  }

  @override
  String get charts => 'Gráficos';

  @override
  String get chartsHint =>
      'Toca o desliza sobre un gráfico para ver el valor de cada día.';

  @override
  String get chartNotEnoughData =>
      'Este gráfico necesita al menos dos registros.';

  @override
  String get chartCycleSubtitle =>
      'Últimos 12 ciclos; la línea discontinua es el promedio';

  @override
  String chartLastDays(int days) {
    return 'Últimos $days días';
  }

  @override
  String chartSleepSubtitle(int days) {
    return 'Horas de sueño en los últimos $days días';
  }

  @override
  String get aboutTagline => 'Tu compañera amable del ciclo';

  @override
  String get aboutMeta => 'Gratis y de código abierto · Sin conexión';

  @override
  String get rateOnMyket => 'Valorar en Myket';

  @override
  String get rateOnBazaar => 'Valorar en Bazaar';

  @override
  String get developerRole => 'Creador de esta app';

  @override
  String get contactCall => 'Llamar';

  @override
  String get settingsAppearance => 'Apariencia e idioma';

  @override
  String remindersOnCount(int count) {
    return '$count recordatorios activos';
  }

  @override
  String get appLockStatusOn => 'Bloqueo activado';

  @override
  String get appLockStatusOff => 'Bloqueo desactivado';

  @override
  String get settingsDataSubtitle => 'Copia, restauración y borrado';

  @override
  String get cycleRemindersGroup => 'Ciclo';

  @override
  String get dailyRemindersGroup => 'Diario';

  @override
  String get notificationsCaption => 'Notificaciones';

  @override
  String get backupFileCaption => 'Archivo de copia';

  @override
  String get backupTextCaption => 'Transferir como texto';

  @override
  String get dataLocalNote =>
      'Todos tus datos y archivos solo están en tu dispositivo y nunca se envían a ningún servidor.';

  @override
  String get widgetDayLabel => 'día del ciclo';

  @override
  String get widgetSizeWide => 'Fino · 5×1';

  @override
  String get widgetSizeSquare => 'Pequeño · 2×2';

  @override
  String get widgetSizeMedium => 'Mediano · 3×2';

  @override
  String get addWidget => 'Añadir';

  @override
  String get widgetPinFailed =>
      'No se pudo añadir el widget. Añádelo desde los widgets de la pantalla de inicio.';

  @override
  String get careMenstrual =>
      'Descansa un poco; tu cuerpo está haciendo un gran trabajo 🌙|Una infusión caliente te sentará bien ☕|Hoy sé más amable contigo 💗|Bebe agua y duerme un poco más 💧|Una compresa tibia alivia los cólicos 🌸';

  @override
  String get careFollicular =>
      'Tu energía vuelve; es momento de empezar algo nuevo ✨|Un gran día para moverte y hacer ejercicio 🏃‍♀️|Apunta tus ideas; tu mente está lúcida 📝|Como la luna, cada día brillas más 🌒';

  @override
  String get careOvulation =>
      'Hoy brillas más que nunca ✨|Celebra tu seguridad 💫|Buen momento para ver a tus amigas 🌸|Tu energía está en su punto más alto; disfrútala ☀️';

  @override
  String get careLuteal =>
      'Sentirte un poco baja es totalmente normal 🌙|Reduce la sal y la cafeína; tu cuerpo te lo agradecerá 🍵|Un paseo tranquilo te subirá el ánimo 🍃|Dormir bien es el mejor regalo para ti 😴';

  @override
  String get careDiscreet =>
      'Sé amable contigo hoy 💗|Bebe un vaso de agua 💧|Respira hondo 🍃|Eres maravillosa ✨';

  @override
  String get widgetChooseHint => 'Elige uno y añádelo a tu pantalla de inicio.';

  @override
  String addWidgetToHome(String name) {
    return 'Añadir widget $name';
  }

  @override
  String get widgetPinNotShown =>
      '¿No apareció la ventana para añadir el widget?';

  @override
  String get widgetHelp => 'Ayuda';

  @override
  String get widgetHelpTitle => '¿No se añade el widget?';

  @override
  String get widgetHelpBody =>
      'Algunos teléfonos, como Xiaomi y Poco, solo añaden widgets si lo permites:\n\n1. Mantén pulsado el icono de Little Moon y toca Información de la app.\n2. Abre Otros permisos.\n3. Permite Accesos directos en la pantalla de inicio.\n4. Vuelve y toca de nuevo el botón para añadir.\n\nTambién puedes mantener pulsado un espacio vacío de la pantalla de inicio, tocar Widgets y buscar Little Moon.';

  @override
  String get widgetSizeLarge => 'Grande · 5×4';

  @override
  String get careGeneral =>
      'Cada día es una nueva oportunidad para tratarte con más cariño.|Escucha a tu cuerpo; te habla cada día.|No tienes que ser fuerte cada día; basta con ser sincera contigo misma.|Descansar también forma parte de tu crecimiento.|Eres valiosa en cada fase de tu ciclo.|Trátate hoy como tratarías a tu mejor amiga.|No tienes que resolverlo todo hoy.|Tu cuerpo merece cuidado, no críticas.|Date permiso para ir más despacio.|No tienes que brillar cada día; tu presencia es suficiente.|Una respiración profunda, un momento de calma, un nuevo comienzo.|Tus emociones no son tus enemigas; escúchalas con cariño.|Eres mucho más que lo que logras hoy.|Cada pequeño paso que das por ti importa.|Colabora con tu cuerpo en lugar de luchar contra él.|Hoy no tienes que ser tu versión perfecta.|Tienes derecho a sentir esperanza y cansancio a la vez.|Cada ciclo es una oportunidad para conocerte mejor.|La amabilidad contigo misma es un hábito poderoso.|Siéntete orgullosa de tu progreso, aunque sea lento.|Si hoy necesitas descansar, escúchate.|Una comida tranquila y nutritiva también es una forma de amor propio.|Bebe agua y regálate unos minutos.|Un poco de estiramiento suave puede invitarte a relajarte.|Dormir lo suficiente es un regalo para tu yo del mañana.|No necesitas una gran razón para regalarte un momento de calma.|Una ducha tibia puede ser un momento solo para ti.|Si hoy tu cuerpo va más despacio, trátalo con cariño.|Poner límites también es una forma de cuidarte.|Date permiso para pedir ayuda.|Haz hoy algo pequeño que te dé paz.|Tu cuerpo tiene necesidades reales; respétalas.|Cuidarte no tiene que ser complicado ni costoso.|Pregúntate hoy: ¿Qué necesito de verdad?|Unos minutos sin pantallas son un regalo para tu mente.|Prométete juzgarte un poco menos hoy.|Cuando estás cansada, no tienes que justificar tu descanso.|En lugar de buscar la perfección, elige ser auténtica.|Hoy también mereces amor y respeto.|Agradece a tu cuerpo todo lo que hace por ti.|No tienes que cambiar cada emoción de inmediato.|Reserva un poco de espacio para ti hoy.|Puedes ser fuerte y necesitar apoyo al mismo tiempo.|Tu cuerpo no es un proyecto que debas arreglar, sino un compañero al que cuidar.|No tienes que luchar contra tu cuerpo para merecer amor.|Cada mes es una nueva oportunidad para conocerte, no para juzgarte.|Tu cuerpo no tiene que parecerse al de nadie más.|Tu valor no se mide con números del calendario ni de la báscula.|Conoce tu cuerpo con curiosidad en lugar de culparlo.|No todos los días tienen que ser iguales al anterior.|Tu cuerpo merece tu paciencia.|Los cambios en tu energía forman parte de la experiencia humana; acompáñate tal como eres.|No tienes que aprovechar al máximo cada día.|Puedes adaptar tus planes a tus necesidades.|Confía en ti; nadie conoce tu experiencia mejor que tú.|Cada emoción que sientes merece atención.|No tienes que disculparte por necesitar descansar.|Tu cuerpo no es enemigo de tus planes; tiene información para ti.|El autoconocimiento empieza al prestar atención a los pequeños detalles.|Sigue tu propio camino en lugar de compararte.|No tienes que sentirte igual todos los días.|Tu cuerpo merece respeto, incluso en los días difíciles.|Háblate con más ternura; tus palabras interiores importan.|No necesitas tener todas las respuestas hoy.|Date tiempo para crecer, cambiar y volver a empezar.|Mereces la paz que procuras a los demás.|A veces, lo mejor es hacer menos.|Cada vez que escuchas una necesidad tuya, te acercas más a ti.|Tu cuerpo trabaja contigo; agradéceselo.|No tienes que restarle importancia a tu dolor ni a tu cansancio.|Cuidarte significa tomar en serio tus propias necesidades.|Puedes empezar de nuevo, aunque sea con un pequeño paso.|Descansar no significa que hayas fracasado.|Permite que tu cuerpo tenga su propio ritmo.|Tu tranquilidad también forma parte de tu éxito.|Un límite saludable puede proteger tu energía hoy.|No tienes que estar disponible para todo el mundo todo el tiempo.|Un momento de silencio también puede ser autocuidado.|Apóyate hoy en lugar de exigirte más.|Puedes sentir orgullo de ti aunque nadie lo note.|Un día no tiene que ser productivo para tener valor.|En vez de castigarte, pregúntate qué podría ayudarte.|Tu cuerpo merece la atención que dedicas a tus tareas.|En vez de preguntarte por qué no eres como siempre, pregúntate qué necesitas ahora.|Un día difícil no cuenta toda tu historia.|Date espacio para sentir sin juzgarte.|No tienes que demostrar tu sufrimiento para merecer apoyo.|Recuérdate que tener necesidades es parte de ser humana.|Avanzar más despacio también es avanzar.|Puedes comprometerte con tus metas y dar prioridad al descanso.|Agradece a tu cuerpo por acompañarte cada día.|No tienes que actuar ante cada emoción; a veces basta con reconocerla.|Escucharte te ayuda a tomar decisiones más conscientes.|Ofrécete apoyo en lugar de culparte.|Puedes reorganizar tu día; no tienes que seguir el plan al pie de la letra.|Cada ciclo tiene su propia historia; obsérvalo con curiosidad.|Registra tus cambios para comprender mejor tus propios patrones.|Tu ciclo no tiene que ser igual al de nadie más.|Cuanto mejor te conozcas, mejor podrás elegir cómo cuidarte.|Tu cuerpo no sigue un calendario idéntico para todas; conoce tus propios patrones.|Si cambia el patrón de tu ciclo, obsérvalo con curiosidad y sin culparte.|Registrar tu ciclo sirve para conocerte, no para limitarte.|Tu cuerpo puede tener distintas necesidades a lo largo del mes.|Observar sin juzgar es el comienzo de un mejor cuidado.|Presta atención a las señales de tu cuerpo en lugar de confiar en predicciones absolutas.|Cada mes es una oportunidad para aprender algo nuevo sobre ti.|Recuerda que la experiencia del ciclo puede ser distinta para cada persona.|Anota las señales de tu cuerpo; comprenderlas puede darte tranquilidad.|Tu ciclo forma parte de tu experiencia, no de toda tu identidad.|Cada día es una oportunidad para volver a empezar.|No todo tiene que ser perfecto para que tengas un buen día.|Eres más fuerte de lo que te hacen sentir tus días difíciles.|Confía en tu camino, incluso cuando el siguiente paso no esté claro.|Cada vez que sigues adelante, aprendes algo sobre ti.|Siéntete orgullosa de todo lo que has recorrido.|No tienes que avanzar al ritmo de nadie más.|La esperanza también puede ser tranquila y silenciosa.|Recuerda que los comienzos pequeños también importan.|Puedes cambiar tu plan y seguir siendo fiel a tu objetivo.|Cada día es una nueva oportunidad para elegir la amabilidad.|Mereces el mismo apoyo que das a los demás.|Cuando el camino se complique, ponte de tu propio lado.|No todos los cambios tienen que ocurrir de golpe.|Con pequeños pasos puedes construir una vida más amable contigo.|No todos los días necesitan un gran comienzo; a veces basta con respirar.|Date tiempo hoy para volver a encontrar la esperanza.|Puedes estar aprendiendo y avanzando al mismo tiempo.|Concéntrate en el siguiente paso en lugar de apresurarte.|No tienes que demostrar nada para tener valor.|A veces, avanzar significa descubrir qué ya no te hace bien.|Date permiso para redefinir lo que significa el éxito para ti.|Cada paso consciente te acerca más a ti misma.|Hoy, acompáñate en lugar de competir con tu yo de ayer.|Puedes hacer una pausa, respirar y volver a elegir.|Puedes tratarte con cariño incluso en los días inciertos.|Empieza el día con una intención amable hacia ti.|Mereces una relación tranquila y amable contigo misma.|Cada vez que te respetas, tus límites se vuelven más claros.|Puedes dedicarte tiempo sin sentir culpa.|Recuérdate: estoy aprendiendo, no me estoy quedando atrás.|Hoy puedes tomar una pequeña decisión a favor de tu tranquilidad.|No tienes que controlarlo todo para sentirte segura.|Cada día es una oportunidad para practicar la paciencia contigo misma.|Recuerda que tus necesidades importan.|Puedes ser amable y mantenerte firme a la vez.|Hoy quizá necesites más apoyo en lugar de esforzarte más.|Cada día es una oportunidad para elegirte sin dejar de lado a los demás.|Mereces un cuidado que te acompañe también en los días difíciles.|Conoce tu cuerpo con curiosidad, no con miedo.|Si tienes un síntoma preocupante o dolor intenso, buscar ayuda profesional es una forma de cuidarte.';

  @override
  String get careGeneralDiscreet =>
      'Cada día es una nueva oportunidad para tratarte con más cariño.|Escucha a tu cuerpo; te habla cada día.|No tienes que ser fuerte cada día; basta con ser sincera contigo misma.|Descansar también forma parte de tu crecimiento.|Trátate hoy como tratarías a tu mejor amiga.|No tienes que resolverlo todo hoy.|Tu cuerpo merece cuidado, no críticas.|Date permiso para ir más despacio.|No tienes que brillar cada día; tu presencia es suficiente.|Una respiración profunda, un momento de calma, un nuevo comienzo.|Tus emociones no son tus enemigas; escúchalas con cariño.|Eres mucho más que lo que logras hoy.|Cada pequeño paso que das por ti importa.|Colabora con tu cuerpo en lugar de luchar contra él.|Hoy no tienes que ser tu versión perfecta.|Tienes derecho a sentir esperanza y cansancio a la vez.|Siéntete orgullosa de tu progreso, aunque sea lento.|Si hoy necesitas descansar, escúchate.|Una comida tranquila y nutritiva también es una forma de amor propio.|Bebe agua y regálate unos minutos.|Un poco de estiramiento suave puede invitarte a relajarte.|Dormir lo suficiente es un regalo para tu yo del mañana.|No necesitas una gran razón para regalarte un momento de calma.|Una ducha tibia puede ser un momento solo para ti.|Si hoy tu cuerpo va más despacio, trátalo con cariño.|Poner límites también es una forma de cuidarte.|Date permiso para pedir ayuda.|Haz hoy algo pequeño que te dé paz.|Tu cuerpo tiene necesidades reales; respétalas.|Cuidarte no tiene que ser complicado ni costoso.|Pregúntate hoy: ¿Qué necesito de verdad?|Unos minutos sin pantallas son un regalo para tu mente.|Prométete juzgarte un poco menos hoy.|Cuando estás cansada, no tienes que justificar tu descanso.|En lugar de buscar la perfección, elige ser auténtica.|Hoy también mereces amor y respeto.|Agradece a tu cuerpo todo lo que hace por ti.|No tienes que cambiar cada emoción de inmediato.|Reserva un poco de espacio para ti hoy.|Puedes ser fuerte y necesitar apoyo al mismo tiempo.|No tienes que luchar contra tu cuerpo para merecer amor.|Cada mes es una nueva oportunidad para conocerte, no para juzgarte.|Tu cuerpo no tiene que parecerse al de nadie más.|Tu valor no se mide con números del calendario ni de la báscula.|Conoce tu cuerpo con curiosidad en lugar de culparlo.|No todos los días tienen que ser iguales al anterior.|Tu cuerpo merece tu paciencia.|Los cambios en tu energía forman parte de la experiencia humana; acompáñate tal como eres.|No tienes que aprovechar al máximo cada día.|Puedes adaptar tus planes a tus necesidades.|Confía en ti; nadie conoce tu experiencia mejor que tú.|Cada emoción que sientes merece atención.|No tienes que disculparte por necesitar descansar.|Tu cuerpo no es enemigo de tus planes; tiene información para ti.|El autoconocimiento empieza al prestar atención a los pequeños detalles.|Sigue tu propio camino en lugar de compararte.|No tienes que sentirte igual todos los días.|Tu cuerpo merece respeto, incluso en los días difíciles.|Háblate con más ternura; tus palabras interiores importan.|No necesitas tener todas las respuestas hoy.|Date tiempo para crecer, cambiar y volver a empezar.|Mereces la paz que procuras a los demás.|A veces, lo mejor es hacer menos.|Cada vez que escuchas una necesidad tuya, te acercas más a ti.|Tu cuerpo trabaja contigo; agradéceselo.|No tienes que restarle importancia a tu dolor ni a tu cansancio.|Cuidarte significa tomar en serio tus propias necesidades.|Puedes empezar de nuevo, aunque sea con un pequeño paso.|Descansar no significa que hayas fracasado.|Permite que tu cuerpo tenga su propio ritmo.|Tu tranquilidad también forma parte de tu éxito.|Un límite saludable puede proteger tu energía hoy.|No tienes que estar disponible para todo el mundo todo el tiempo.|Un momento de silencio también puede ser autocuidado.|Apóyate hoy en lugar de exigirte más.|Puedes sentir orgullo de ti aunque nadie lo note.|Un día no tiene que ser productivo para tener valor.|En vez de castigarte, pregúntate qué podría ayudarte.|Tu cuerpo merece la atención que dedicas a tus tareas.|Un día difícil no cuenta toda tu historia.|Date espacio para sentir sin juzgarte.|No tienes que demostrar tu sufrimiento para merecer apoyo.|Recuérdate que tener necesidades es parte de ser humana.|Avanzar más despacio también es avanzar.|Puedes comprometerte con tus metas y dar prioridad al descanso.|Agradece a tu cuerpo por acompañarte cada día.|No tienes que actuar ante cada emoción; a veces basta con reconocerla.|Escucharte te ayuda a tomar decisiones más conscientes.|Ofrécete apoyo en lugar de culparte.|Puedes reorganizar tu día; no tienes que seguir el plan al pie de la letra.|Registra tus cambios para comprender mejor tus propios patrones.|Cuanto mejor te conozcas, mejor podrás elegir cómo cuidarte.|Tu cuerpo no sigue un calendario idéntico para todas; conoce tus propios patrones.|Tu cuerpo puede tener distintas necesidades a lo largo del mes.|Observar sin juzgar es el comienzo de un mejor cuidado.|Presta atención a las señales de tu cuerpo en lugar de confiar en predicciones absolutas.|Cada mes es una oportunidad para aprender algo nuevo sobre ti.|Anota las señales de tu cuerpo; comprenderlas puede darte tranquilidad.|Cada día es una oportunidad para volver a empezar.|No todo tiene que ser perfecto para que tengas un buen día.|Eres más fuerte de lo que te hacen sentir tus días difíciles.|Confía en tu camino, incluso cuando el siguiente paso no esté claro.|Cada vez que sigues adelante, aprendes algo sobre ti.|Siéntete orgullosa de todo lo que has recorrido.|No tienes que avanzar al ritmo de nadie más.|La esperanza también puede ser tranquila y silenciosa.|Recuerda que los comienzos pequeños también importan.|Puedes cambiar tu plan y seguir siendo fiel a tu objetivo.|Cada día es una nueva oportunidad para elegir la amabilidad.|Mereces el mismo apoyo que das a los demás.|Cuando el camino se complique, ponte de tu propio lado.|No todos los cambios tienen que ocurrir de golpe.|Con pequeños pasos puedes construir una vida más amable contigo.|No todos los días necesitan un gran comienzo; a veces basta con respirar.|Date tiempo hoy para volver a encontrar la esperanza.|Puedes estar aprendiendo y avanzando al mismo tiempo.|Concéntrate en el siguiente paso en lugar de apresurarte.|No tienes que demostrar nada para tener valor.|A veces, avanzar significa descubrir qué ya no te hace bien.|Date permiso para redefinir lo que significa el éxito para ti.|Cada paso consciente te acerca más a ti misma.|Hoy, acompáñate en lugar de competir con tu yo de ayer.|Puedes hacer una pausa, respirar y volver a elegir.|Puedes tratarte con cariño incluso en los días inciertos.|Empieza el día con una intención amable hacia ti.|Mereces una relación tranquila y amable contigo misma.|Cada vez que te respetas, tus límites se vuelven más claros.|Puedes dedicarte tiempo sin sentir culpa.|Recuérdate: estoy aprendiendo, no me estoy quedando atrás.|Hoy puedes tomar una pequeña decisión a favor de tu tranquilidad.|No tienes que controlarlo todo para sentirte segura.|Cada día es una oportunidad para practicar la paciencia contigo misma.|Recuerda que tus necesidades importan.|Puedes ser amable y mantenerte firme a la vez.|Hoy quizá necesites más apoyo en lugar de esforzarte más.|Cada día es una oportunidad para elegirte sin dejar de lado a los demás.|Mereces un cuidado que te acompañe también en los días difíciles.|Conoce tu cuerpo con curiosidad, no con miedo.|Si tienes un síntoma preocupante o dolor intenso, buscar ayuda profesional es una forma de cuidarte.';

  @override
  String get cycleLateWithinRangeNote =>
      'Tu regla se ha retrasado un poco, pero sigue dentro de la variación normal de tus ciclos.';

  @override
  String get cycleLateMildNote =>
      'Tu regla llega más tarde de lo habitual. El estrés, los viajes, la enfermedad o dormir poco pueden desplazar un ciclo. Si el retraso continúa, considera hacerte una prueba de embarazo o consultar a un médico.';

  @override
  String get cycleShortNote =>
      'Tus ciclos suelen durar menos de 21 días. Si esto es nuevo para ti, conviene comentarlo con un médico.';

  @override
  String get cycleLongNote =>
      'Tus ciclos suelen durar más de 35 días. Si esto es nuevo para ti, conviene comentarlo con un médico.';

  @override
  String get cycleMissedLogNote =>
      'Uno de tus ciclos parece muy largo; quizá se te olvidó registrar una regla. Añadirla hará que las predicciones sean más precisas.';

  @override
  String get predictionConfidenceLow =>
      'Confianza de la predicción: baja. Registra unos ciclos más para mejorarla.';

  @override
  String get predictionConfidenceMedium => 'Confianza de la predicción: media.';

  @override
  String get predictionConfidenceHigh =>
      'Confianza de la predicción: alta. Tus últimos ciclos son muy regulares.';

  @override
  String reminderPatternSoon(String what) {
    return 'Aviso: en esta etapa de tu ciclo sueles notar: $what. Cuídate con cariño.';
  }

  @override
  String get hapticsTitle => 'Vibración háptica';

  @override
  String get hapticsHint => 'Vibraciones suaves al tocar, guardar o registrar';

  @override
  String get dailyTipsTitle => 'Consejos de hoy';

  @override
  String get tipCategoryNutrition => 'Alimentación';

  @override
  String get tipCategoryMovement => 'Movimiento';

  @override
  String get tipCategoryRest => 'Descanso';

  @override
  String get tipsTapHint => 'Toca un consejo para ver otro.';

  @override
  String get tipNutritionMenstrual =>
      'Los alimentos ricos en hierro, como lentejas, espinacas o frijoles, ayudan a reponer lo que pierdes 🥬|Las sopas calientes y las infusiones pueden reconfortarte hoy 🍵|Ten una botella de agua cerca; hidratarte puede aliviar la hinchazón 💧';

  @override
  String get tipMovementMenstrual =>
      'Hoy basta con estiramientos suaves o un paseo tranquilo 🚶‍♀️|Un yoga suave puede aliviar la tensión de la espalda y las caderas 🧘‍♀️|Escucha a tu cuerpo: no pasa nada si te saltas un entrenamiento intenso 💗';

  @override
  String get tipRestMenstrual =>
      'Prueba a acostarte más temprano esta noche; tu cuerpo está trabajando mucho 😴|Una compresa tibia en el bajo vientre puede reconfortarte 🌸|Date permiso para ir más despacio hoy 🌙';

  @override
  String get tipNutritionFollicular =>
      'Verduras, fruta fresca y cereales integrales van bien con tu energía en aumento 🥗|Añade algo de proteína a tus comidas para sentirte saciada y estable 🍳|Prueba una receta saludable nueva; puede que tengas ganas de cocinar 🍲';

  @override
  String get tipMovementFollicular =>
      'Tu energía va en aumento: buen momento para cardio o fuerza 🏃‍♀️|Prueba algo nuevo, como una clase, una excursión o baile 💃|Calienta bien y luego puedes ir apretando poco a poco 💪';

  @override
  String get tipRestFollicular =>
      'Mantén un horario de sueño constante para conservar tu energía ⏰|Un paseo corto a la luz del día puede mejorar tu ánimo ☀️|Planifica tu semana ahora, mientras tu mente está despierta 📝';

  @override
  String get tipNutritionOvulation =>
      'Frutas y verduras de colores son una gran opción hoy 🍓|Bebe mucha agua; puede que sientas más calor de lo habitual 💧|Los alimentos con fibra, como la avena y las legumbres, favorecen la digestión 🥣';

  @override
  String get tipMovementOvulation =>
      'La energía suele estar en su punto más alto: disfruta de un entrenamiento que te guste ⚡|Buen día para actividades en grupo o un paseo al aire libre 🌿|Calienta y estira bien para cuidar tus articulaciones 🧘‍♀️';

  @override
  String get tipRestOvulation =>
      'Planea tiempo con gente que disfrutas; puede que te sientas más sociable 💬|Incluso en días de mucha energía, relájate antes de dormir 🌙|Tómate unos minutos de calma para recargar entre actividades 🍃';

  @override
  String get tipNutritionLuteal =>
      'Los carbohidratos complejos, como la avena y el boniato, pueden estabilizar tu ánimo 🍠|Reduce la sal y la cafeína si te sientes hinchada o tensa 🍵|Frutos secos, semillas y un poco de chocolate negro son un snack satisfactorio 🍫';

  @override
  String get tipMovementLuteal =>
      'Un paseo suave, yoga o natación pueden mejorar tu ánimo 🏊‍♀️|Baja la intensidad si estás cansada; moverte con suavidad también cuenta 🍃|Estirar antes de dormir puede aliviar la tensión 🧘‍♀️';

  @override
  String get tipRestLuteal =>
      'Acostarte temprano ayuda; tu cuerpo puede necesitar más sueño ahora 😴|Sé amable contigo si tu ánimo decae; es común antes de la regla 💗|Prueba unas respiraciones lentas o una ducha caliente para relajarte 🛁';

  @override
  String get unusualCycle => 'Ciclo inusual';

  @override
  String get unusualCycleHint =>
      'Si una enfermedad, un viaje, el estrés o un medicamento alteró este ciclo, márcalo para que no cuente en tus promedios ni predicciones.';

  @override
  String get unusualCycleUndoHint =>
      'Este ciclo está marcado como inusual y no se usa en las predicciones. ¿Volver a marcarlo como normal?';

  @override
  String get markUnusual => 'Marcar';

  @override
  String get unmarkUnusual => 'Desmarcar';

  @override
  String get historyTapHint => 'Toca un ciclo para marcarlo como inusual.';

  @override
  String get unusualCyclesCount => 'Ciclos inusuales';

  @override
  String get bbtLearningTitle => 'Aprendizaje con temperatura basal';

  @override
  String get lutealPersonal => 'Fase lútea personal';

  @override
  String get lutealDefault => 'Fase lútea (por defecto)';

  @override
  String get lutealLearnedHint =>
      'Aprendida de ciclos donde la ovulación se confirmó con la temperatura.';

  @override
  String get lutealNeedMore =>
      'Registra tu temperatura cada mañana antes de levantarte durante unos ciclos y la app aprenderá tu fase lútea.';

  @override
  String get bbtThisCycle => 'Ovulación por temperatura';

  @override
  String get bbtNoShift => 'Aún no hay subida de temperatura';

  @override
  String get bbtRefinedNote =>
      'Predicción de la próxima regla ajustada con la temperatura';

  @override
  String get bbtTip =>
      'Para confirmar la ovulación, registra tu temperatura cada mañana antes de levantarte.';

  @override
  String get logHeroTitle => '¿Cómo estás hoy?';

  @override
  String get logHeroSubtitle => 'Dedícate unos minutos';

  @override
  String get logSectionGeneral => 'Estado general';

  @override
  String get logSectionPhysical => 'Cuerpo';

  @override
  String get logSectionNote => 'Nota del día';
}
