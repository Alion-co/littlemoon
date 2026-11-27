// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get homeGreeting => 'İyi akşamlar';

  @override
  String dayOfCycle(int day) {
    return '$day. gün';
  }

  @override
  String get ofYourCycle => 'döngünde';

  @override
  String get follicularPhase => 'Foliküler evre';

  @override
  String get lutealPhase => 'Luteal evre';

  @override
  String get menstrualPhase => 'Adet evresi';

  @override
  String get ovulationPhase => 'Yumurtlama evresi';

  @override
  String daysUntilPeriod(int days) {
    return 'Sonraki adete $days gün';
  }

  @override
  String get cycleHealthy => 'Döngün şu an her zamanki aralığında.';

  @override
  String get dailyCheckIn => 'Günlük kayıt';

  @override
  String get howAreYouFeeling => 'Bugün nasıl hissediyorsun?';

  @override
  String get flow => 'Kanama';

  @override
  String get mood => 'Ruh hali';

  @override
  String get pain => 'Ağrı';

  @override
  String get energy => 'Enerji';

  @override
  String get sleep => 'Uyku';

  @override
  String get symptoms => 'Belirtiler';

  @override
  String get todaysSummary => 'Bugünün özeti';

  @override
  String get logToday => 'Bugünü\nkaydet';

  @override
  String get good => 'İyi';

  @override
  String get medium => 'Orta';

  @override
  String get mild => 'Hafif';

  @override
  String get yourCycleInsights => 'Döngü analizlerin';

  @override
  String get averageCycle => 'Ortalama döngü';

  @override
  String get recentPattern => 'Son düzen';

  @override
  String get days => 'gün';

  @override
  String get home => 'Ana sayfa';

  @override
  String get calendar => 'Takvim';

  @override
  String get insights => 'Analizler';

  @override
  String get health => 'Sağlık';

  @override
  String get profile => 'Profil';

  @override
  String get month => 'Ay';

  @override
  String get week => 'Hafta';

  @override
  String get period => 'Adet';

  @override
  String get fertile => 'Doğurgan';

  @override
  String get ovulation => 'Yumurtlama';

  @override
  String get periodDay => 'Adet günü';

  @override
  String get fertileWindow => 'Doğurganlık dönemi';

  @override
  String get ovulationDay => 'Yumurtlama günü';

  @override
  String get noDataLogged => 'Kayıt yok';

  @override
  String get logButton => 'Kaydet';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get clear => 'Temizle';

  @override
  String get ok => 'Anladım';

  @override
  String get back => 'Geri';

  @override
  String get next => 'İleri';

  @override
  String get undo => 'Geri al';

  @override
  String get today => 'Bugün';

  @override
  String get notSet => 'Girilmedi';

  @override
  String get notEnoughData => 'Yeterli veri yok';

  @override
  String get invalidValue => 'Bu değer doğru görünmüyor.';

  @override
  String get goodMorning => 'Günaydın';

  @override
  String get goodAfternoon => 'İyi günler';

  @override
  String get goodNight => 'İyi geceler';

  @override
  String periodDayNumber(int day) {
    return 'Adetin $day. günü';
  }

  @override
  String periodLateBy(int days) {
    return 'Adet $days gün gecikti';
  }

  @override
  String get periodLateOneDay => 'Adet 1 gün gecikti';

  @override
  String get periodExpectedToday => 'Adetin bugün bekleniyor';

  @override
  String get periodExpectedTomorrow => 'Adetin yarın bekleniyor';

  @override
  String get cycleLateNote =>
      'Adetin bir haftadan fazla gecikti. Böyle devam ederse gebelik testi yapmayı veya bir doktora danışmayı düşün.';

  @override
  String get cycleIrregularNote =>
      'Son döngülerinin uzunluğu değişiyor, bu yüzden tahminler daha az kesin.';

  @override
  String get periodStartedToday => 'Adetim bugün başladı';

  @override
  String get periodContinuesToday => 'Bugün de adetliyim';

  @override
  String get periodLoggedToday => 'Bugün için adet kaydedildi';

  @override
  String get noCycleDataTitle => 'Henüz adet kaydı yok';

  @override
  String get noCycleDataBody =>
      'Little Moon\'un döngünü tahmin etmeye başlaması için son adetinin ilk gününü kaydet.';

  @override
  String get logLastPeriod => 'Son adetimi kaydet';

  @override
  String get predictionInfoTitle => 'Bu nasıl hesaplanıyor?';

  @override
  String get predictionInfoBody =>
      'Sonraki adetin, kaydettiğin son döngülerin ortalama uzunluğuna göre tahmin edilir. Yumurtlama, sonraki adetten yaklaşık 14 gün önce kabul edilir; doğurganlık dönemi ise yumurtlamadan 5 gün önce başlar ve 1 gün sonra biter.\n\nNe kadar çok adet kaydedersen tahmin o kadar doğru olur. Bunlar tahmindir — doğum kontrol yöntemi olarak kullanma.';

  @override
  String get reminders => 'Hatırlatmalar';

  @override
  String get noReminders => 'Bugün hatırlatılacak bir şey yok.';

  @override
  String reminderPeriodSoon(int days) {
    return 'Adetin $days gün sonra bekleniyor.';
  }

  @override
  String get reminderPeriodTomorrow => 'Adetin yarın bekleniyor.';

  @override
  String get reminderPeriodToday => 'Adetin bugün bekleniyor.';

  @override
  String get reminderFertileSoon => 'Doğurganlık dönemin yarın başlıyor.';

  @override
  String get reminderFertileToday => 'Şu an doğurganlık dönemindesin.';

  @override
  String get reminderOvulationToday => 'Bugün tahmini yumurtlama günün.';

  @override
  String get reminderLogToday => 'Bugün henüz bir şey kaydetmedin.';

  @override
  String get remindersHint =>
      'Döngü hatırlatmaları 09:00\'da, günlük kayıt hatırlatması 21:00\'de telefon bildirimi olarak gelir. Ana sayfadaki zilde de görünür.';

  @override
  String get reminderPeriodSetting => 'Yaklaşan adet';

  @override
  String get reminderDaysBefore => 'Kaç gün önce hatırlat';

  @override
  String get reminderFertileSetting => 'Doğurganlık dönemi';

  @override
  String get reminderOvulationSetting => 'Yumurtlama günü';

  @override
  String get reminderLogSetting => 'Günlük kayıt';

  @override
  String get futureDayNotAllowed =>
      'Yalnızca bugünü veya geçmiş günleri kaydedebilirsin.';

  @override
  String get flowNone => 'Yok';

  @override
  String get flowSpotting => 'Lekelenme';

  @override
  String get flowLight => 'Hafif';

  @override
  String get flowMedium => 'Orta';

  @override
  String get flowHeavy => 'Yoğun';

  @override
  String get moodHappy => 'Mutlu';

  @override
  String get moodCalm => 'Sakin';

  @override
  String get moodSensitive => 'Hassas';

  @override
  String get moodSad => 'Üzgün';

  @override
  String get moodIrritable => 'Sinirli';

  @override
  String get moodAnxious => 'Kaygılı';

  @override
  String get painNone => 'Ağrı yok';

  @override
  String get painSevere => 'Şiddetli';

  @override
  String get energyLow => 'Düşük';

  @override
  String get energyHigh => 'Yüksek';

  @override
  String get symptomCramps => 'Kramp';

  @override
  String get symptomHeadache => 'Baş ağrısı';

  @override
  String get symptomBackPain => 'Bel ağrısı';

  @override
  String get symptomBloating => 'Şişkinlik';

  @override
  String get symptomBreastTenderness => 'Göğüs hassasiyeti';

  @override
  String get symptomAcne => 'Sivilce';

  @override
  String get symptomNausea => 'Bulantı';

  @override
  String get symptomFatigue => 'Yorgunluk';

  @override
  String get symptomCravings => 'Aşerme';

  @override
  String get symptomInsomnia => 'Uykusuzluk';

  @override
  String get symptomDizziness => 'Baş dönmesi';

  @override
  String get symptomDischarge => 'Akıntı';

  @override
  String get note => 'Not';

  @override
  String get noteHint => 'Bugünle ilgili hatırlamak istediğin her şey…';

  @override
  String sleepHours(int hours) {
    return '$hours sa';
  }

  @override
  String sleepHoursMinutes(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }

  @override
  String get predicted => 'Tahmini';

  @override
  String get predictedPeriodDay => 'Tahmini adet';

  @override
  String cycleDayShort(int day) {
    return 'Döngünün $day. günü';
  }

  @override
  String get dataLogged => 'Kaydedildi';

  @override
  String get insightsEmpty =>
      'İlk adetini kaydettiğinde döngü istatistiklerin ve tahminlerin burada görünecek.';

  @override
  String get averagePeriod => 'Ortalama adet';

  @override
  String get regularity => 'Düzen';

  @override
  String get regular => 'Düzenli';

  @override
  String get irregular => 'Düzensiz';

  @override
  String get cyclesTracked => 'Kaydedilen döngü';

  @override
  String get predictions => 'Tahminler';

  @override
  String get nextPeriod => 'Sonraki adet';

  @override
  String get followingPeriod => 'Ondan sonraki adet';

  @override
  String get cycleHistory => 'Döngü geçmişi';

  @override
  String get historyEmpty =>
      'En az iki adet kaydettikten sonra döngü uzunlukların burada görünecek.';

  @override
  String get topSymptoms => 'En sık belirtiler';

  @override
  String get last90Days => 'Son 90 gün';

  @override
  String get noSymptomsLogged => 'Henüz belirti kaydedilmedi.';

  @override
  String get moodSummary => 'Ruh hali';

  @override
  String get noMoodLogged => 'Henüz ruh hali kaydedilmedi.';

  @override
  String get medicalDisclaimer =>
      'Tahminler, kaydettiklerine dayanan yaklaşık değerlerdir. Tıbbi tavsiye değildir ve doğum kontrol yöntemi olarak kullanılmamalıdır.';

  @override
  String get yourBody => 'Vücudun';

  @override
  String get tipsForYou => 'Bu evre için öneriler';

  @override
  String get todayTracking => 'Bugün';

  @override
  String get water => 'Su';

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count / $goal bardak';
  }

  @override
  String get weight => 'Kilo';

  @override
  String get weightHint => 'örn. 58.5';

  @override
  String get kg => 'kg';

  @override
  String get bodyTemperature => 'Vücut ısısı';

  @override
  String get temperatureHint => 'örn. 36.6';

  @override
  String get tapToAdd => 'Eklemek için dokun';

  @override
  String get averageSleep7 => 'Ortalama uyku (7 gün)';

  @override
  String get pregnancyChanceToday => 'Bugün gebelik olasılığı';

  @override
  String get chanceLow => 'Düşük';

  @override
  String get chanceMedium => 'Orta';

  @override
  String get chanceHigh => 'Yüksek';

  @override
  String get aboutMenstrual =>
      'Adet, yeni bir döngünün başlangıcıdır. Rahim iç tabakası dökülür ve birkaç gün enerjinin düşük olması normaldir.';

  @override
  String get aboutFollicular =>
      'Adetten sonra östrojen yükselir ve vücut yumurta bırakmaya hazırlanır. Çoğu kişi bu evrede kendini daha enerjik ve odaklı hisseder.';

  @override
  String get aboutOvulation =>
      'Yumurta bu günlerde bırakılır. Döngünün en doğurgan zamanıdır.';

  @override
  String get aboutLuteal =>
      'Yumurtlamadan sonra progesteron yükselir. Adetten önceki günlerde şişkinlik, göğüs hassasiyeti veya ruh hali değişimi gibi adet öncesi belirtiler görebilirsin.';

  @override
  String get aboutNoData =>
      'Döngünün hangi evresinde olduğunu görmek ve uygun öneriler almak için adetini kaydet.';

  @override
  String get tipMenstrual1 =>
      'İhtiyaç duyduğunda dinlen. Yürüyüş veya esneme gibi hafif hareketler krampları azaltabilir.';

  @override
  String get tipMenstrual2 =>
      'Karnın alt kısmına sıcak kompres ağrıyı hafifletebilir.';

  @override
  String get tipMenstrual3 =>
      'Mercimek, ıspanak ve kırmızı et gibi demir açısından zengin besinler ve yeterli su toparlanmana yardımcı olur.';

  @override
  String get tipFollicular1 =>
      'Bu evrede enerji genellikle artar; daha yoğun egzersiz için iyi bir zaman.';

  @override
  String get tipFollicular2 =>
      'Yeni planlara veya odak gerektiren işlere başlamak için iyi bir zaman.';

  @override
  String get tipFollicular3 =>
      'Öğünlerini protein ve taze sebzeyle dengeli tut.';

  @override
  String get tipOvulation1 => 'Döngünün en doğurgan zamanı.';

  @override
  String get tipOvulation2 =>
      'Yumurtlama döneminde karnın alt kısmında tek taraflı hafif ağrı veya daha şeffaf akıntı genellikle normaldir.';

  @override
  String get tipOvulation3 =>
      'Enerji ve ruh hali çoğunlukla en iyi seviyededir; hareketli olmanın tadını çıkar.';

  @override
  String get tipLuteal1 =>
      'Şişkinlik veya ruh hali değişimi gibi adet öncesi belirtiler ortaya çıkabilir. Kendine nazik davran.';

  @override
  String get tipLuteal2 =>
      'Tuzu, kafeini ve şekeri azaltmak şişkinliği ve sinirliliği hafifletebilir.';

  @override
  String get tipLuteal3 =>
      'Uykuya ve yoga ya da yürüyüş gibi hafif egzersizlere öncelik ver.';

  @override
  String get tipGeneral1 =>
      'Adetini düzenli kaydet. Birkaç döngüden sonra tahminler daha doğru olur.';

  @override
  String get tipGeneral2 => 'Yeterli su iç ve uyku saatlerini düzenli tut.';

  @override
  String get tipGeneral3 =>
      'Döngülerin sık sık 21 günden kısa veya 35 günden uzunsa ya da ağrın şiddetliyse bir doktora başvur.';

  @override
  String get yourName => 'Adın';

  @override
  String get nameHint => 'Sana nasıl hitap edelim?';

  @override
  String get noName => 'Sevgili dostum';

  @override
  String trackingSince(String date) {
    return '$date tarihinden beri takipte';
  }

  @override
  String get daysLogged => 'Kaydedilen gün';

  @override
  String get periodsLogged => 'Kaydedilen adet';

  @override
  String get cycleSettings => 'Döngü ayarları';

  @override
  String get cycleSettingsHint =>
      'Birkaç döngü kaydedene kadar tahminlerde bunlar kullanılır.';

  @override
  String get cycleLength => 'Döngü uzunluğu';

  @override
  String get cycleLengthHint =>
      'Bir adetin ilk gününden sonrakinin ilk gününe kadar. Genellikle 21–35 gün.';

  @override
  String get periodLength => 'Adet süresi';

  @override
  String get periodLengthHint =>
      'Kanamanın genellikle kaç gün sürdüğü. Çoğunlukla 3–7 gün.';

  @override
  String get lutealLength => 'Luteal evre uzunluğu';

  @override
  String get lutealLengthHint =>
      'Yumurtlama ile sonraki adet arasındaki gün sayısı. Kendi değerini bilmiyorsan 14 olarak bırak.';

  @override
  String get privacyNote =>
      'Her şey bu cihazda kalır. Little Moon tamamen çevrimdışı çalışır ve verilerini hiçbir yere göndermez.';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get calendarType => 'Takvim';

  @override
  String get calendarJalali => 'Hicri-Şemsi';

  @override
  String get calendarGregorian => 'Miladi';

  @override
  String get theme => 'Tema';

  @override
  String get themeMoon => 'Ay';

  @override
  String get themeSakura => 'Sakura';

  @override
  String get themeLavender => 'Lavanta';

  @override
  String get themeOcean => 'Okyanus';

  @override
  String get themeMint => 'Nane';

  @override
  String get themeSunset => 'Gün batımı';

  @override
  String get themeMidnight => 'Gece yarısı';

  @override
  String get themeNightRose => 'Gece gülü';

  @override
  String get dataAndBackup => 'Veri ve yedekleme';

  @override
  String get backupHint =>
      'Yedeğin, istediğin yerde saklayabileceğin düz bir metindir.';

  @override
  String get copyBackup => 'Yedeği panoya kopyala';

  @override
  String get backupCopied => 'Yedek kopyalandı. Güvenli bir yere yapıştır.';

  @override
  String get restoreBackup => 'Yedekten geri yükle';

  @override
  String get restoreHint => 'Yedek metnini buraya yapıştır';

  @override
  String get restoreInvalid => 'Bu geçerli bir Little Moon yedeği değil.';

  @override
  String get restoreConfirm =>
      'Uygulamadaki her şey yedekle değiştirilecek. Devam edilsin mi?';

  @override
  String get restore => 'Geri yükle';

  @override
  String get restoreDone => 'Yedek geri yüklendi.';

  @override
  String get deleteAllData => 'Tüm verileri sil';

  @override
  String get deleteAllConfirm =>
      'Tüm kayıtların, profilin ve ayarların kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get onboardingWelcomeTitle => 'Hoş geldin';

  @override
  String get onboardingWelcomeBody =>
      'Little Moon adetini takip etmene ve sırada ne olduğunu bilmene yardımcı olur. Başlamak için birkaç kısa soru.';

  @override
  String get onboardingHello => 'Merhaba!';

  @override
  String get onboardingWelcomeLine => 'Little Moon’a hoş geldin';

  @override
  String get onboardingTagline =>
      'Döngünü yönetmek ve kendini daha iyi hissetmek için her zaman yanında';

  @override
  String get lastPeriodQuestion => 'Son adetin ne zaman başladı?';

  @override
  String get lastPeriodHint =>
      'Kanamanın ilk gününü seç. Sonra değiştirebilirsin.';

  @override
  String get dontRemember => 'Hatırlamıyorum';

  @override
  String get periodLengthQuestion => 'Adetin genellikle kaç gün sürer?';

  @override
  String get cycleLengthQuestion => 'Döngün genellikle kaç gün sürer?';

  @override
  String get getStarted => 'Başla';

  @override
  String get insightsTitle => 'Döngü analizi';

  @override
  String get dedication => 'Küçük ayıma ithafen';

  @override
  String get editProfile => 'Profili düzenle';

  @override
  String get chooseAvatar => 'Avatarını seç';

  @override
  String get aboutDeveloper => 'Little Moon hakkında';

  @override
  String get aboutAppBody =>
      'Little Moon, genç kızlar ve kadınlar için adet takibi yapan özel, ücretsiz ve çevrimdışı bir platformdur. Aylık döngünü kendi kaydettiğin bilgilerden tahmin eder ve sana gösterir. Tüm verilerin yalnızca kendi telefonunda saklanır.';

  @override
  String appVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String get developer => 'Geliştiren';

  @override
  String get email => 'E-posta';

  @override
  String get website => 'Web sitesi';

  @override
  String get telegram => 'Telegram';

  @override
  String get instagram => 'Instagram';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get madeWithLove => 'ALION tarafından geliştirildi';

  @override
  String get appTitle => 'Little Moon';

  @override
  String dateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get privacySection => 'Gizlilik';

  @override
  String get appLock => 'Uygulama kilidi';

  @override
  String get appLockHint => 'Uygulamayı PIN veya parmak izinle koru.';

  @override
  String get appLockOn => 'Uygulama kilidi açık.';

  @override
  String get useBiometric => 'Parmak iziyle aç';

  @override
  String get changePin => 'PIN\'i değiştir';

  @override
  String get pinChanged => 'PIN değiştirildi.';

  @override
  String get enterPin => 'PIN\'ini gir';

  @override
  String get newPin => '4 haneli bir PIN seç';

  @override
  String get confirmPin => 'PIN\'i tekrar gir';

  @override
  String get pinMismatch => 'PIN\'ler eşleşmedi. Tekrar dene.';

  @override
  String get wrongPin => 'Yanlış PIN';

  @override
  String tooManyAttempts(int seconds) {
    return 'Çok fazla deneme. $seconds saniye bekle.';
  }

  @override
  String get unlockReason => 'Little Moon\'u aç';

  @override
  String get forgotPin => 'PIN\'imi unuttum';

  @override
  String get forgotPinBody =>
      'Veriler telefonundan hiç çıkmadığı için PIN kurtarılamaz. Tüm verileri silip baştan başlayabilirsin; yedeğin varsa sonra geri yükleyebilirsin.';

  @override
  String get resetApp => 'Sil ve baştan başla';

  @override
  String get discreetNotifications => 'Gizli bildirimler';

  @override
  String get discreetNotificationsHint =>
      'Hatırlatıcılar ve widget döngün hakkında hiçbir şey söylemeyen nötr bir metin kullanır ve kilit ekranında görünmez.';

  @override
  String get discreetTitle => 'Hatırlatma';

  @override
  String get discreetCycleBody => 'Yeni bir hatırlatman var.';

  @override
  String get discreetLogBody => 'Bugünkü notun seni bekliyor.';

  @override
  String get discreetPillBody => 'Günlük hatırlatma zamanın geldi.';

  @override
  String get pillReminder => 'Hap hatırlatıcısı';

  @override
  String get pillReminderTime => 'Hatırlatma saati';

  @override
  String get reminderPill => 'Hapını alma zamanı.';

  @override
  String get widgetTitle => 'Ana ekran widget\'ı';

  @override
  String get widgetHint =>
      'Ana ekranda boş bir yere basılı tut, Widget\'lar\'a dokun ve Little Moon\'u ekle. Gizli bildirimler açıkken widget yalnızca gün numarasını gösterir.';

  @override
  String get doctorReport => 'Doktorun için rapor';

  @override
  String get doctorReportHint =>
      'Döngülerinin, belirtilerinin ve ruh halinin bu telefonda hazırlanan PDF özeti.';

  @override
  String get reportTitle => 'Adet döngüsü raporu';

  @override
  String reportGenerated(String date) {
    return 'Hazırlanma tarihi: $date';
  }

  @override
  String reportWindow(int days, int logged) {
    return 'Belirti istatistikleri son $days günü kapsar ($logged gün kayıtlı)';
  }

  @override
  String get reportSummary => 'Özet';

  @override
  String get reportCycleRange => 'En kısa ve en uzun döngü';

  @override
  String reportMinMax(int min, int max) {
    return '$min – $max gün';
  }

  @override
  String get reportLastPeriod => 'Son adet başlangıcı';

  @override
  String get reportStart => 'Başlangıç';

  @override
  String get reportInProgress => 'Mevcut';

  @override
  String get reportUnitsNote =>
      'Tüm değerler gün cinsindendir. * bu döngüde bir adetin büyük olasılıkla kaydedilmediğini ve ortalamaya katılmadığını gösterir.';

  @override
  String reportTimes(int count) {
    return '$count kez';
  }

  @override
  String get reportPainDays => 'Orta veya şiddetli ağrılı günler';

  @override
  String get reportFooter =>
      'Little Moon ile, kullanıcının kaydettiği verilere göre hazırlandı';

  @override
  String get reportFailed => 'Rapor oluşturulamadı. Lütfen tekrar dene.';

  @override
  String get year => 'Yıl';

  @override
  String get quickLog => 'Hızlı kayıt';

  @override
  String get quickLogHint => 'Tek dokunuşla kaydedilir';

  @override
  String get detailedLog => 'Ayrıntılı kayıt';

  @override
  String get saveBackupFile => 'Yedeği dosyaya kaydet';

  @override
  String get restoreBackupFile => 'Yedek dosyasından geri yükle';

  @override
  String get backupFileSaved => 'Yedek dosyası kaydedildi.';

  @override
  String get backupFileFailed =>
      'Dosya kaydedilemedi; yedek metni panoya kopyalandı.';

  @override
  String reminderLate(int days) {
    return 'Adetin $days gün gecikti. Başladıysa, tahminlerin doğru kalması için kaydet.';
  }

  @override
  String get lateReminderSetting => 'Geciken adet';

  @override
  String get autoNightTheme => 'Otomatik gece teması';

  @override
  String get autoNightThemeHint =>
      'Telefon karanlık moddayken gece teması kullanılır.';

  @override
  String get patternsTitle => 'Örüntülerin';

  @override
  String get patternsSubtitle => 'Döngülerinde tekrar edenler';

  @override
  String get patternsEmpty =>
      'Henüz tekrar eden bir örüntü yok. Daha fazla döngüde belirti ve ruh hali kaydettikçe örüntülerin burada görünür.';

  @override
  String get patternsNote =>
      'Yalnızca kendi kayıtlarından bu telefonda hesaplanır; tıbbi teşhis değildir.';

  @override
  String get patternPain => 'Orta veya şiddetli ağrı';

  @override
  String get patternDayBefore => 'Genellikle adetten bir gün önce';

  @override
  String patternDaysBefore(int days) {
    return 'Genellikle adetten yaklaşık $days gün önce';
  }

  @override
  String patternDuring(int day) {
    return 'Genellikle adetin $day. gününde';
  }

  @override
  String patternSeen(int cycles) {
    return '$cycles döngüde';
  }

  @override
  String get charts => 'Grafikler';

  @override
  String get chartsHint =>
      'Her günün değerini görmek için grafiğe dokun veya üzerinde kaydır.';

  @override
  String get chartNotEnoughData => 'Bu grafik için en az iki kayıt gerekir.';

  @override
  String get chartCycleSubtitle => 'Son 12 döngü; kesikli çizgi ortalamadır';

  @override
  String chartLastDays(int days) {
    return 'Son $days gün';
  }

  @override
  String chartSleepSubtitle(int days) {
    return 'Son $days gündeki uyku saatleri';
  }

  @override
  String get aboutTagline => 'Döngünün sevimli yol arkadaşı';

  @override
  String get aboutMeta => 'Ücretsiz ve açık kaynak · Tamamen çevrimdışı';

  @override
  String get rateOnMyket => 'Myket\'te puan ver';

  @override
  String get rateOnBazaar => 'Bazaar\'da puan ver';

  @override
  String get developerRole => 'Bu uygulamanın yapımcısı';

  @override
  String get contactCall => 'Ara';

  @override
  String get settingsAppearance => 'Görünüm ve dil';

  @override
  String remindersOnCount(int count) {
    return '$count hatırlatıcı açık';
  }

  @override
  String get appLockStatusOn => 'Uygulama kilidi açık';

  @override
  String get appLockStatusOff => 'Uygulama kilidi kapalı';

  @override
  String get settingsDataSubtitle => 'Yedekleme, geri yükleme ve silme';

  @override
  String get cycleRemindersGroup => 'Döngü';

  @override
  String get dailyRemindersGroup => 'Günlük';

  @override
  String get notificationsCaption => 'Bildirimler';

  @override
  String get backupFileCaption => 'Yedek dosyası';

  @override
  String get backupTextCaption => 'Metin olarak aktar';

  @override
  String get dataLocalNote =>
      'Tüm verilerin ve dosyaların yalnızca cihazında bulunur ve hiçbir sunucuya gönderilmez.';

  @override
  String get widgetDayLabel => 'döngü günü';

  @override
  String get widgetSizeWide => 'İnce · 5×1';

  @override
  String get widgetSizeSquare => 'Küçük · 2×2';

  @override
  String get widgetSizeMedium => 'Orta · 3×2';

  @override
  String get addWidget => 'Ekle';

  @override
  String get widgetPinFailed =>
      'Widget eklenemedi. Ana ekranın widget\'larından ekle.';

  @override
  String get careMenstrual =>
      'Biraz dinlen; bedenin büyük bir iş yapıyor 🌙|Sıcak bir bitki çayı iyi gelir ☕|Bugün kendine daha nazik ol 💗|Yeterince su iç ve biraz daha uyu 💧|Sıcak kompres krampları hafifletir 🌸';

  @override
  String get careFollicular =>
      'Enerjin geri geliyor; yeni başlangıçların zamanı ✨|Hareket etmek için harika bir gün 🏃‍♀️|Fikirlerini yaz; zihnin çok açık 📝|Ay gibi, her gün biraz daha dolgunsun 🌒';

  @override
  String get careOvulation =>
      'Bugün her zamankinden parlaksın ✨|Özgüvenini kutla 💫|Arkadaşlarınla buluşmak için güzel bir zaman 🌸|Enerjin zirvede; tadını çıkar ☀️';

  @override
  String get careLuteal =>
      'Biraz keyifsiz hissetmek tamamen normal 🌙|Tuzu ve kafeini azalt; bedenin teşekkür edecek 🍵|Sakin bir yürüyüş moralini yükseltir 🍃|Yeterli uyku kendine en güzel hediye 😴';

  @override
  String get careDiscreet =>
      'Bugün kendine nazik ol 💗|Bir bardak su iç 💧|Derin bir nefes al 🍃|Harikasın ✨';

  @override
  String get widgetChooseHint => 'Birini seç ve ana ekranına ekle.';

  @override
  String addWidgetToHome(String name) {
    return '$name widget\'ını ekle';
  }

  @override
  String get widgetPinNotShown => 'Widget ekleme penceresi açılmadı mı?';

  @override
  String get widgetHelp => 'Yardım';

  @override
  String get widgetHelpTitle => 'Widget eklenmiyor mu?';

  @override
  String get widgetHelpBody =>
      'Xiaomi ve Poco gibi bazı telefonlar widget\'ı ancak izin verirsen ekler:\n\n1. Little Moon simgesine basılı tut ve Uygulama bilgisi\'ne dokun.\n2. Diğer izinler\'i aç.\n3. Ana ekran kısayolları\'na izin ver.\n4. Geri dön ve ekle düğmesine tekrar dokun.\n\nYa da ana ekranda boş bir yere basılı tut, Widget\'lar\'a dokun ve Little Moon\'u bul.';

  @override
  String get widgetSizeLarge => 'Büyük · 5×4';

  @override
  String get careGeneral =>
      'Her gün kendine daha nazik davranmak için yeni bir fırsattır.|Bedenini dinle; o seninle her gün konuşur.|Her gün güçlü olmak zorunda değilsin; kendine karşı dürüst olman yeterli.|Dinlenmek de gelişim yolculuğunun bir parçasıdır.|Döngünün her evresinde değerlisin.|Bugün kendine en yakın arkadaşına davrandığın gibi davran.|Her şeyi bugün çözmek zorunda değilsin.|Bedenin eleştiriyi değil, özeni hak ediyor.|Kendine daha yavaş ilerleme izni ver.|Her gün parlamak zorunda değilsin; varlığın yeterli.|Derin bir nefes, huzurlu bir an, yeni bir başlangıç.|Duyguların düşmanın değil; onları şefkatle dinle.|Bugün yaptıklarından çok daha fazlasısın.|Kendin için attığın her küçük adım önemlidir.|Bedeninle savaşmak yerine onunla iş birliği yap.|Bugün kendinin kusursuz hâli olmak zorunda değilsin.|Hem umutlu hem de yorgun olmaya hakkın var.|Her döngü, kendini daha iyi tanımak için bir fırsattır.|Kendine şefkat göstermek güçlü bir alışkanlıktır.|Yavaş olsa bile ilerlemenle gurur duy.|Bugün dinlenmeye ihtiyacın varsa kendini dinle.|Huzurlu ve besleyici bir öğün de kendine duyduğun sevginin bir ifadesidir.|Su iç ve kendine birkaç dakika ayır.|Hafif esneme hareketleri huzura nazik bir davet olabilir.|Yeterli uyku, yarınki kendine verdiğin bir hediyedir.|Sakinleşmek için büyük bir nedenin olması gerekmez.|Ilık bir duş, yalnızca sana ait bir an olabilir.|Bedenin bugün daha yavaş hareket ediyorsa ona nazik davran.|Sınır koymak da öz bakımın bir parçasıdır.|Yardım istemek için kendine izin ver.|Bugün sana huzur veren küçük bir şey yap.|Bedeninin gerçek ihtiyaçları var; onlara saygı duy.|Öz bakımın karmaşık ya da pahalı olması gerekmez.|Bugün kendine sor: Gerçekten neye ihtiyacım var?|Ekrandan uzak birkaç dakika zihnine verebileceğin bir hediyedir.|Bugün kendini daha az yargılamaya söz ver.|Yorgunken dinlenmek için kendini açıklamak zorunda değilsin.|Kusursuz olmaktan çok, kendin gibi olmaya odaklan.|Bugün de sevgi ve saygıyı hak ediyorsun.|Bedeninin senin için yaptıklarını takdir et.|Her duygunu hemen değiştirmek zorunda değilsin.|Bugün kendine biraz alan bırak.|Hem güçlü olabilir hem de desteğe ihtiyaç duyabilirsin.|Bedenin düzeltmen gereken bir proje değil, sevgiyle eşlik edeceğin bir yol arkadaşıdır.|Sevilmeyi hak etmek için bedeninle savaşmak zorunda değilsin.|Her ay kendini yargılamak değil, yeniden tanımak için yeni bir fırsattır.|Bedeninin başka hiçbir bedene benzemesi gerekmiyor.|Değerin takvimdeki ya da tartıdaki sayılarla belirlenmez.|Bedenini suçlamak yerine merakla tanımaya çalış.|Her günün dünkü gibi olması gerekmez.|Bedenin senin sabrını hak ediyor.|Enerjindeki değişimler insan olmanın bir parçasıdır; kendine eşlik et.|Her gününden en yüksek verimi almak zorunda değilsin.|Planlarını ihtiyaçlarına göre değiştirebilirsin.|Kendine güven; deneyimini en iyi sen bilirsin.|Hissettiğin her duygu ilgi görmeyi hak eder.|Dinlenmeye ihtiyaç duyduğun için özür dilemek zorunda değilsin.|Bedenin planlarının düşmanı değil; sana anlatacakları var.|Kendini tanımak küçük ayrıntılara dikkat etmekle başlar.|Kendini başkalarıyla kıyaslamak yerine kendi yolunda ilerle.|Her gün aynı şekilde hissetmek zorunda değilsin.|Bedenin zor günlerde bile saygıyı hak eder.|Kendinle daha yumuşak konuş; iç sesin önemlidir.|Bugün tüm cevapları bilmek zorunda değilsin.|Büyümek, değişmek ve yeniden başlamak için kendine zaman tanı.|Başkalarına sunduğun huzuru sen de hak ediyorsun.|Bazen yapılacak en iyi şey daha az şey yapmaktır.|İhtiyacını her dinlediğinde kendine biraz daha yaklaşırsın.|Bedenin seninle iş birliği yapıyor; ona minnettar ol.|Ağrını ya da yorgunluğunu küçümsemek zorunda değilsin.|Öz bakım, kendi ihtiyaçlarını ciddiye almaktır.|Küçük bir adımla bile yeniden başlayabilirsin.|Kendine her dinlenme fırsatı verdiğinde başarısız olmuş olmazsın.|Bedeninin kendi ritminde ilerlemesine izin ver.|Huzurun da başarının bir parçasıdır.|Bugün sağlıklı bir sınır enerjini koruyabilir.|Herkes için her an ulaşılabilir olmak zorunda değilsin.|Kısa bir sessizlik anı da öz bakım olabilir.|Bugün kendini zorlamak yerine kendine destek ol.|Kimse fark etmese bile kendinle gurur duyabilirsin.|Her günün değerli olması için verimli geçmesi gerekmez.|Kendini cezalandırmak yerine sana neyin yardımcı olacağını merak et.|Bedenin, işlerine gösterdiğin özeni hak ediyor.|Neden eskisi gibi olmadığını sormak yerine şu an neye ihtiyacın olduğunu sor.|Zor bir gün, hikâyenin tamamı değildir.|Duygularını yargılamadan yaşamak için kendine alan tanı.|Destek almak için yaşadığın zorluğu kanıtlamak zorunda değilsin.|Kendine hatırlat: İhtiyaç duymak insan olmanın bir parçasıdır.|Daha yavaş ilerlemek de bir ilerlemedir.|Hedeflerine bağlı kalırken dinlenmeye de öncelik verebilirsin.|Her gün sana eşlik ettiği için bedenine teşekkür et.|Her duygun için bir şey yapmak zorunda değilsin; bazen onları fark etmek yeterlidir.|Kendini dinlediğinde daha bilinçli seçimler yaparsın.|Kendini suçlamak yerine kendine destek ol.|Gününü yeniden düzenleyebilirsin; plana sıkı sıkıya bağlı kalmak zorunda değilsin.|Her döngünün kendine özgü bir hikâyesi vardır; onu merakla gözlemle.|Kendi örüntülerini daha iyi tanımak için değişimlerini kaydet.|Döngünün başka birininkiyle aynı olması gerekmez.|Kendini daha iyi tanıdıkça sana uygun bakımı seçmen kolaylaşır.|Bedenin herkes için aynı işleyen kusursuz bir takvim değildir; kendi örüntülerini tanı.|Döngünün düzeni değişirse, bunu suçlamadan ve merakla gözlemle.|Döngünü takip etmek kendini tanıman içindir, kendini kısıtlamak için değil.|Bedeninin ay boyunca farklı ihtiyaçları olabilir.|Yargılamadan gözlemlemek, daha iyi bakımın başlangıcıdır.|Kesin tahminler yerine bedeninin işaretlerine dikkat et.|Her ay kendin hakkında yeni bir şey öğrenme fırsatıdır.|Herkesin döngü deneyiminin farklı olabileceğini unutma.|Bedeninin işaretlerini not et; bilgi içini rahatlatabilir.|Döngün deneyiminin bir parçasıdır, kimliğinin tamamı değil.|Her gün yeniden başlamak için bir fırsattır.|Güzel bir gün geçirmek için her şeyin kusursuz olması gerekmez.|Zor günlerin sana hissettirdiğinden daha güçlüsün.|Bir sonraki adım belli olmadığında bile yolculuğuna güven.|Devam ettiğin her seferde kendin hakkında bir şey öğrenirsin.|Buraya kadar geldiğin için kendinle gurur duy.|Başkalarının hızında ilerlemek zorunda değilsin.|Umut sessiz ve sakin bir şekilde de var olabilir.|Küçük başlangıçların da değerli olduğunu kendine hatırlat.|Planını değiştirebilir ve yine de hedefine bağlı kalabilirsin.|Her gün, şefkati seçmek için yeni bir fırsattır.|Başkalarına verdiğin desteğin aynısını sen de hak ediyorsun.|Yol zorlaştığında kendinin takım arkadaşı ol.|Tüm değişimlerin bir anda gerçekleşmesi gerekmez.|Küçük adımlarla kendin için daha şefkatli bir yaşam kurabilirsin.|Her gün büyük bir başlangıç olmak zorunda değil; bazen tek bir nefes yeterlidir.|Bugün umudu yeniden bulmak için kendine zaman tanı.|Hem öğreniyor hem de ilerliyor olabilirsin.|Acele etmek yerine bir sonraki adıma odaklan.|Değerli olmak için bir şeyi kanıtlamak zorunda değilsin.|Bazen ilerleme, artık sana neyin uygun olmadığını anlamaktır.|Başarının senin için ne anlama geldiğini yeniden tanımlamana izin ver.|Bilinçle attığın her adım seni kendine yaklaştırır.|Bugün dünkü kendinle yarışmak yerine kendine eşlik et.|Durabilir, nefes alabilir ve yeniden seçim yapabilirsin.|Belirsiz günlerde bile kendine nazik davranabilirsin.|Bugüne kendin için şefkatli bir niyetle başla.|Kendinle huzurlu ve şefkatli bir ilişkiyi hak ediyorsun.|Kendine her saygı gösterdiğinde sınırların daha belirginleşir.|Suçluluk hissetmeden kendine zaman ayırabilirsin.|Kendine hatırlat: Geride kalmıyorum, öğreniyorum.|Bugün huzurun için küçük bir seçim yapabilirsin.|Güvende hissetmek için her şeyi kontrol etmek zorunda değilsin.|Her gün kendine karşı sabırlı olmayı denemek için bir fırsattır.|İhtiyaçlarının önemli olduğunu unutma.|Nazik olabilir ve yine de kararlı durabilirsin.|Bugün daha çok çabalamak yerine daha çok desteğe ihtiyacın olabilir.|Her gün, başkalarını dışlamadan kendini seçmek için bir fırsattır.|Zor günlerde de devam eden bir bakımı hak ediyorsun.|Bedenini korkuyla değil, merakla tanı.|Endişe verici bir belirti ya da şiddetli ağrı yaşıyorsan profesyonel destek almak öz bakımın bir parçasıdır.';

  @override
  String get careGeneralDiscreet =>
      'Her gün kendine daha nazik davranmak için yeni bir fırsattır.|Bedenini dinle; o seninle her gün konuşur.|Her gün güçlü olmak zorunda değilsin; kendine karşı dürüst olman yeterli.|Dinlenmek de gelişim yolculuğunun bir parçasıdır.|Bugün kendine en yakın arkadaşına davrandığın gibi davran.|Her şeyi bugün çözmek zorunda değilsin.|Bedenin eleştiriyi değil, özeni hak ediyor.|Kendine daha yavaş ilerleme izni ver.|Her gün parlamak zorunda değilsin; varlığın yeterli.|Derin bir nefes, huzurlu bir an, yeni bir başlangıç.|Duyguların düşmanın değil; onları şefkatle dinle.|Bugün yaptıklarından çok daha fazlasısın.|Kendin için attığın her küçük adım önemlidir.|Bedeninle savaşmak yerine onunla iş birliği yap.|Bugün kendinin kusursuz hâli olmak zorunda değilsin.|Hem umutlu hem de yorgun olmaya hakkın var.|Yavaş olsa bile ilerlemenle gurur duy.|Bugün dinlenmeye ihtiyacın varsa kendini dinle.|Huzurlu ve besleyici bir öğün de kendine duyduğun sevginin bir ifadesidir.|Su iç ve kendine birkaç dakika ayır.|Hafif esneme hareketleri huzura nazik bir davet olabilir.|Yeterli uyku, yarınki kendine verdiğin bir hediyedir.|Sakinleşmek için büyük bir nedenin olması gerekmez.|Ilık bir duş, yalnızca sana ait bir an olabilir.|Bedenin bugün daha yavaş hareket ediyorsa ona nazik davran.|Sınır koymak da öz bakımın bir parçasıdır.|Yardım istemek için kendine izin ver.|Bugün sana huzur veren küçük bir şey yap.|Bedeninin gerçek ihtiyaçları var; onlara saygı duy.|Öz bakımın karmaşık ya da pahalı olması gerekmez.|Bugün kendine sor: Gerçekten neye ihtiyacım var?|Ekrandan uzak birkaç dakika zihnine verebileceğin bir hediyedir.|Bugün kendini daha az yargılamaya söz ver.|Yorgunken dinlenmek için kendini açıklamak zorunda değilsin.|Kusursuz olmaktan çok, kendin gibi olmaya odaklan.|Bugün de sevgi ve saygıyı hak ediyorsun.|Bedeninin senin için yaptıklarını takdir et.|Her duygunu hemen değiştirmek zorunda değilsin.|Bugün kendine biraz alan bırak.|Hem güçlü olabilir hem de desteğe ihtiyaç duyabilirsin.|Sevilmeyi hak etmek için bedeninle savaşmak zorunda değilsin.|Her ay kendini yargılamak değil, yeniden tanımak için yeni bir fırsattır.|Bedeninin başka hiçbir bedene benzemesi gerekmiyor.|Değerin takvimdeki ya da tartıdaki sayılarla belirlenmez.|Bedenini suçlamak yerine merakla tanımaya çalış.|Her günün dünkü gibi olması gerekmez.|Bedenin senin sabrını hak ediyor.|Enerjindeki değişimler insan olmanın bir parçasıdır; kendine eşlik et.|Her gününden en yüksek verimi almak zorunda değilsin.|Planlarını ihtiyaçlarına göre değiştirebilirsin.|Kendine güven; deneyimini en iyi sen bilirsin.|Hissettiğin her duygu ilgi görmeyi hak eder.|Dinlenmeye ihtiyaç duyduğun için özür dilemek zorunda değilsin.|Bedenin planlarının düşmanı değil; sana anlatacakları var.|Kendini tanımak küçük ayrıntılara dikkat etmekle başlar.|Kendini başkalarıyla kıyaslamak yerine kendi yolunda ilerle.|Her gün aynı şekilde hissetmek zorunda değilsin.|Bedenin zor günlerde bile saygıyı hak eder.|Kendinle daha yumuşak konuş; iç sesin önemlidir.|Bugün tüm cevapları bilmek zorunda değilsin.|Büyümek, değişmek ve yeniden başlamak için kendine zaman tanı.|Başkalarına sunduğun huzuru sen de hak ediyorsun.|Bazen yapılacak en iyi şey daha az şey yapmaktır.|İhtiyacını her dinlediğinde kendine biraz daha yaklaşırsın.|Bedenin seninle iş birliği yapıyor; ona minnettar ol.|Ağrını ya da yorgunluğunu küçümsemek zorunda değilsin.|Öz bakım, kendi ihtiyaçlarını ciddiye almaktır.|Küçük bir adımla bile yeniden başlayabilirsin.|Kendine her dinlenme fırsatı verdiğinde başarısız olmuş olmazsın.|Bedeninin kendi ritminde ilerlemesine izin ver.|Huzurun da başarının bir parçasıdır.|Bugün sağlıklı bir sınır enerjini koruyabilir.|Herkes için her an ulaşılabilir olmak zorunda değilsin.|Kısa bir sessizlik anı da öz bakım olabilir.|Bugün kendini zorlamak yerine kendine destek ol.|Kimse fark etmese bile kendinle gurur duyabilirsin.|Her günün değerli olması için verimli geçmesi gerekmez.|Kendini cezalandırmak yerine sana neyin yardımcı olacağını merak et.|Bedenin, işlerine gösterdiğin özeni hak ediyor.|Zor bir gün, hikâyenin tamamı değildir.|Duygularını yargılamadan yaşamak için kendine alan tanı.|Destek almak için yaşadığın zorluğu kanıtlamak zorunda değilsin.|Kendine hatırlat: İhtiyaç duymak insan olmanın bir parçasıdır.|Daha yavaş ilerlemek de bir ilerlemedir.|Hedeflerine bağlı kalırken dinlenmeye de öncelik verebilirsin.|Her gün sana eşlik ettiği için bedenine teşekkür et.|Her duygun için bir şey yapmak zorunda değilsin; bazen onları fark etmek yeterlidir.|Kendini dinlediğinde daha bilinçli seçimler yaparsın.|Kendini suçlamak yerine kendine destek ol.|Gününü yeniden düzenleyebilirsin; plana sıkı sıkıya bağlı kalmak zorunda değilsin.|Kendi örüntülerini daha iyi tanımak için değişimlerini kaydet.|Kendini daha iyi tanıdıkça sana uygun bakımı seçmen kolaylaşır.|Bedenin herkes için aynı işleyen kusursuz bir takvim değildir; kendi örüntülerini tanı.|Bedeninin ay boyunca farklı ihtiyaçları olabilir.|Yargılamadan gözlemlemek, daha iyi bakımın başlangıcıdır.|Kesin tahminler yerine bedeninin işaretlerine dikkat et.|Her ay kendin hakkında yeni bir şey öğrenme fırsatıdır.|Bedeninin işaretlerini not et; bilgi içini rahatlatabilir.|Her gün yeniden başlamak için bir fırsattır.|Güzel bir gün geçirmek için her şeyin kusursuz olması gerekmez.|Zor günlerin sana hissettirdiğinden daha güçlüsün.|Bir sonraki adım belli olmadığında bile yolculuğuna güven.|Devam ettiğin her seferde kendin hakkında bir şey öğrenirsin.|Buraya kadar geldiğin için kendinle gurur duy.|Başkalarının hızında ilerlemek zorunda değilsin.|Umut sessiz ve sakin bir şekilde de var olabilir.|Küçük başlangıçların da değerli olduğunu kendine hatırlat.|Planını değiştirebilir ve yine de hedefine bağlı kalabilirsin.|Her gün, şefkati seçmek için yeni bir fırsattır.|Başkalarına verdiğin desteğin aynısını sen de hak ediyorsun.|Yol zorlaştığında kendinin takım arkadaşı ol.|Tüm değişimlerin bir anda gerçekleşmesi gerekmez.|Küçük adımlarla kendin için daha şefkatli bir yaşam kurabilirsin.|Her gün büyük bir başlangıç olmak zorunda değil; bazen tek bir nefes yeterlidir.|Bugün umudu yeniden bulmak için kendine zaman tanı.|Hem öğreniyor hem de ilerliyor olabilirsin.|Acele etmek yerine bir sonraki adıma odaklan.|Değerli olmak için bir şeyi kanıtlamak zorunda değilsin.|Bazen ilerleme, artık sana neyin uygun olmadığını anlamaktır.|Başarının senin için ne anlama geldiğini yeniden tanımlamana izin ver.|Bilinçle attığın her adım seni kendine yaklaştırır.|Bugün dünkü kendinle yarışmak yerine kendine eşlik et.|Durabilir, nefes alabilir ve yeniden seçim yapabilirsin.|Belirsiz günlerde bile kendine nazik davranabilirsin.|Bugüne kendin için şefkatli bir niyetle başla.|Kendinle huzurlu ve şefkatli bir ilişkiyi hak ediyorsun.|Kendine her saygı gösterdiğinde sınırların daha belirginleşir.|Suçluluk hissetmeden kendine zaman ayırabilirsin.|Kendine hatırlat: Geride kalmıyorum, öğreniyorum.|Bugün huzurun için küçük bir seçim yapabilirsin.|Güvende hissetmek için her şeyi kontrol etmek zorunda değilsin.|Her gün kendine karşı sabırlı olmayı denemek için bir fırsattır.|İhtiyaçlarının önemli olduğunu unutma.|Nazik olabilir ve yine de kararlı durabilirsin.|Bugün daha çok çabalamak yerine daha çok desteğe ihtiyacın olabilir.|Her gün, başkalarını dışlamadan kendini seçmek için bir fırsattır.|Zor günlerde de devam eden bir bakımı hak ediyorsun.|Bedenini korkuyla değil, merakla tanı.|Endişe verici bir belirti ya da şiddetli ağrı yaşıyorsan profesyonel destek almak öz bakımın bir parçasıdır.';

  @override
  String get cycleLateWithinRangeNote =>
      'Adetin biraz gecikti ama bu hâlâ döngülerinin normal değişkenliği içinde.';

  @override
  String get cycleLateMildNote =>
      'Adetin olağan aralığından daha geç geldi. Stres, seyahat, hastalık veya uykusuzluk döngüyü kaydırabilir. Gecikme sürerse gebelik testi yapmayı veya bir doktora danışmayı düşün.';

  @override
  String get cycleShortNote =>
      'Döngülerin genellikle 21 günden kısa. Bu senin için yeniyse doktora söylemende fayda var.';

  @override
  String get cycleLongNote =>
      'Döngülerin genellikle 35 günden uzun. Bu senin için yeniyse doktora söylemende fayda var.';

  @override
  String get cycleMissedLogNote =>
      'Döngülerinden biri alışılmadık derecede uzun görünüyor; bir adeti kaydetmeyi unutmuş olabilirsin. Eklemen tahminleri daha doğru yapar.';

  @override
  String get predictionConfidenceLow =>
      'Tahmin güveni: düşük. Geliştirmek için birkaç döngü daha kaydet.';

  @override
  String get predictionConfidenceMedium => 'Tahmin güveni: orta.';

  @override
  String get predictionConfidenceHigh =>
      'Tahmin güveni: yüksek. Son döngülerin çok düzenli.';

  @override
  String reminderPatternSoon(String what) {
    return 'Hatırlatma: döngünün bu zamanlarında genellikle şunları fark ediyorsun: $what. Kendine nazik davran.';
  }

  @override
  String get hapticsTitle => 'Dokunsal titreşim';

  @override
  String get hapticsHint =>
      'Dokunurken, kaydederken ve işaretlerken hafif titreşim';

  @override
  String get dailyTipsTitle => 'Bugünün önerileri';

  @override
  String get tipCategoryNutrition => 'Beslenme';

  @override
  String get tipCategoryMovement => 'Hareket';

  @override
  String get tipCategoryRest => 'Dinlenme';

  @override
  String get tipsTapHint => 'Başka bir öneri görmek için dokun.';

  @override
  String get tipNutritionMenstrual =>
      'Mercimek, ıspanak ve fasulye gibi demir açısından zengin besinler kaybettiklerini yerine koymaya yardımcı olur 🥬|Sıcak çorbalar ve bitki çayları bugün iyi gelebilir 🍵|Su şişeni yakında tut; yeterli su şişkinliği hafifletebilir 💧';

  @override
  String get tipMovementMenstrual =>
      'Bugün hafif esneme ya da yavaş bir yürüyüş yeterli 🚶‍♀️|Hafif yoga sırt ve kalça gerginliğini azaltabilir 🧘‍♀️|Bedenini dinle; yoğun bir antrenmanı atlamak sorun değil 💗';

  @override
  String get tipRestMenstrual =>
      'Bu gece biraz erken yat; bedenin çok çalışıyor 😴|Alt karnına sıcak bir kompres iyi gelebilir 🌸|Bugün yavaşlamana izin ver 🌙';

  @override
  String get tipNutritionFollicular =>
      'Taze sebze, meyve ve tam tahıllar artan enerjine uyar 🥗|Öğünlerine biraz protein ekle; tok ve dengeli hissedersin 🍳|Yeni bir sağlıklı tarif dene; yemek yapacak enerjin olabilir 🍲';

  @override
  String get tipMovementFollicular =>
      'Enerjin yükseliyor: kardiyo ya da güç antrenmanı için iyi bir zaman 🏃‍♀️|Yeni bir şey dene; bir ders, bir doğa yürüyüşü ya da dans 💃|İyi ısın, sonra yavaş yavaş biraz daha zorlayabilirsin 💪';

  @override
  String get tipRestFollicular =>
      'Enerjini korumak için düzenli bir uyku saati tut ⏰|Gün ışığında kısa bir yürüyüş ruh halini yükseltebilir ☀️|Zihnin berikken haftanı şimdi planla 📝';

  @override
  String get tipNutritionOvulation =>
      'Renkli meyve ve sebzeler bugün güzel bir seçim 🍓|Bol su iç; her zamankinden daha sıcak hissedebilirsin 💧|Yulaf ve fasulye gibi lifli besinler sindirimi rahat tutar 🥣';

  @override
  String get tipMovementOvulation =>
      'Enerji çoğu zaman zirvede: sevdiğin bir antrenmanın tadını çıkar ⚡|Grup etkinlikleri ya da keyifli bir dış mekân yürüyüşü için güzel bir gün 🌿|Eklemlerini korumak için iyi ısın ve esne 🧘‍♀️';

  @override
  String get tipRestOvulation =>
      'Sevdiğin insanlarla vakit planla; daha sosyal hissedebilirsin 💬|Enerjik günlerde bile yatmadan önce yavaşla 🌙|Etkinlikler arasında birkaç sessiz dakika ayırıp şarj ol 🍃';

  @override
  String get tipNutritionLuteal =>
      'Yulaf ve tatlı patates gibi kompleks karbonhidratlar ruh halini dengeleyebilir 🍠|Şişkin ya da gergin hissediyorsan tuz ve kafeini azalt 🍵|Kuruyemiş, tohum ve biraz bitter çikolata doyurucu bir atıştırmalık olabilir 🍫';

  @override
  String get tipMovementLuteal =>
      'Hafif bir yürüyüş, yoga ya da yüzme ruh halini yükseltebilir 🏊‍♀️|Yorgunsan yoğunluğu düşür; nazik hareket de sayılır 🍃|Yatmadan önce esnemek gerginliği azaltabilir 🧘‍♀️';

  @override
  String get tipRestLuteal =>
      'Erken yatmak iyi gelir; bedenin şimdi daha fazla uykuya ihtiyaç duyabilir 😴|Ruh halin düşerse kendine nazik ol; adetten önce yaygındır 💗|Rahatlamak için birkaç yavaş nefes ya da sıcak bir duş dene 🛁';

  @override
  String get unusualCycle => 'Alışılmadık döngü';

  @override
  String get unusualCycleHint =>
      'Bu döngü hastalık, seyahat, stres veya ilaç yüzünden bozulduysa işaretle; ortalamalara ve tahminlere katılmasın.';

  @override
  String get unusualCycleUndoHint =>
      'Bu döngü alışılmadık olarak işaretli ve tahminlerde kullanılmıyor. Normale döndürelim mi?';

  @override
  String get markUnusual => 'İşaretle';

  @override
  String get unmarkUnusual => 'İşareti kaldır';

  @override
  String get historyTapHint =>
      'Alışılmadık olarak işaretlemek için bir döngüye dokun.';

  @override
  String get unusualCyclesCount => 'Alışılmadık döngüler';

  @override
  String get bbtLearningTitle => 'Bazal ısıdan öğrenme';

  @override
  String get lutealPersonal => 'Kişisel luteal faz';

  @override
  String get lutealDefault => 'Luteal faz (varsayılan)';

  @override
  String get lutealLearnedHint =>
      'Yumurtlamanın ısıyla doğrulandığı döngülerden öğrenildi.';

  @override
  String get lutealNeedMore =>
      'Birkaç döngü boyunca her sabah yataktan kalkmadan ısını kaydedersen uygulama kendi luteal fazını öğrenir.';

  @override
  String get bbtThisCycle => 'Isıyla yumurtlama';

  @override
  String get bbtNoShift => 'Henüz ısı artışı görülmedi';

  @override
  String get bbtRefinedNote => 'Sonraki adet tahmini ısıyla düzeltildi';

  @override
  String get bbtTip =>
      'Yumurtlamayı doğrulamak için ısını her sabah yataktan kalkmadan kaydet.';

  @override
  String get logHeroTitle => 'Bugün nasılsın?';

  @override
  String get logHeroSubtitle => 'Kendine birkaç dakika ayır';

  @override
  String get logSectionGeneral => 'Genel durum';

  @override
  String get logSectionPhysical => 'Beden';

  @override
  String get logSectionNote => 'Günlük not';
}
