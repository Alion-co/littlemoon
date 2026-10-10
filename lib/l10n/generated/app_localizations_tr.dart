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
  String get dedication => 'Bu uygulama benim küçük ayıma adanmıştır';

  @override
  String get editProfile => 'Profili düzenle';

  @override
  String get chooseAvatar => 'Avatarını seç';

  @override
  String get aboutDeveloper => 'Geliştirici hakkında';

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
}
