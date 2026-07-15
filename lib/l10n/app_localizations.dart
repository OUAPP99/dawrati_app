import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'دورتي'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In ar, this message translates to:
  /// **'صحة المرأة'**
  String get appTagline;

  /// No description provided for @changeLanguage.
  ///
  /// In ar, this message translates to:
  /// **'تغيير اللغة'**
  String get changeLanguage;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختاري لغتك'**
  String get chooseLanguageTitle;

  /// No description provided for @onboardTitle1.
  ///
  /// In ar, this message translates to:
  /// **'افهمي دورتك'**
  String get onboardTitle1;

  /// No description provided for @onboardDesc1.
  ///
  /// In ar, this message translates to:
  /// **'افهمي دورتك الشهرية، تبويضك ونافذة خصوبتك.'**
  String get onboardDesc1;

  /// No description provided for @onboardTitle2.
  ///
  /// In ar, this message translates to:
  /// **'توقعي دورتك'**
  String get onboardTitle2;

  /// No description provided for @onboardDesc2.
  ///
  /// In ar, this message translates to:
  /// **'احصلي على توقعات ذكية لدورتك القادمة.'**
  String get onboardDesc2;

  /// No description provided for @onboardTitle3.
  ///
  /// In ar, this message translates to:
  /// **'تتبعي الأعراض'**
  String get onboardTitle3;

  /// No description provided for @onboardDesc3.
  ///
  /// In ar, this message translates to:
  /// **'سجّلي مزاجك، الألم، النوم، الماء والأعراض اليومية.'**
  String get onboardDesc3;

  /// No description provided for @onboardTitle4.
  ///
  /// In ar, this message translates to:
  /// **'ذكاء دورتي الاصطناعي'**
  String get onboardTitle4;

  /// No description provided for @onboardDesc4.
  ///
  /// In ar, this message translates to:
  /// **'احصلي على تحليلات مخصصة كل يوم.'**
  String get onboardDesc4;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدئي الآن'**
  String get getStarted;

  /// No description provided for @welcomeTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في\nدورتي'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تتبعي دورتك، افهمي جسدك واحصلي على تحليلات ذكاء اصطناعي مخصصة.'**
  String get welcomeSubtitle;

  /// No description provided for @continueWithApple.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة عبر Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة عبر Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithEmail.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة عبر البريد الإلكتروني'**
  String get continueWithEmail;

  /// No description provided for @continueWithoutAccount.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة بدون حساب'**
  String get continueWithoutAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لدي حساب بالفعل'**
  String get alreadyHaveAccount;

  /// No description provided for @qAge.
  ///
  /// In ar, this message translates to:
  /// **'كم عمرك؟'**
  String get qAge;

  /// No description provided for @qLastPeriod.
  ///
  /// In ar, this message translates to:
  /// **'متى بدأت آخر دورة لك؟'**
  String get qLastPeriod;

  /// No description provided for @qPeriodLength.
  ///
  /// In ar, this message translates to:
  /// **'كم تستغرق دورتك الشهرية؟'**
  String get qPeriodLength;

  /// No description provided for @qCycleLength.
  ///
  /// In ar, this message translates to:
  /// **'متوسط طول الدورة'**
  String get qCycleLength;

  /// No description provided for @qGoal.
  ///
  /// In ar, this message translates to:
  /// **'لماذا تستخدمين دورتي؟'**
  String get qGoal;

  /// No description provided for @goalTrackCycle.
  ///
  /// In ar, this message translates to:
  /// **'تتبع دورتي'**
  String get goalTrackCycle;

  /// No description provided for @goalGetPregnant.
  ///
  /// In ar, this message translates to:
  /// **'الحمل'**
  String get goalGetPregnant;

  /// No description provided for @goalAvoidPregnancy.
  ///
  /// In ar, this message translates to:
  /// **'تجنب الحمل'**
  String get goalAvoidPregnancy;

  /// No description provided for @goalUnderstandHealth.
  ///
  /// In ar, this message translates to:
  /// **'فهم صحتي'**
  String get goalUnderstandHealth;

  /// No description provided for @qContraception.
  ///
  /// In ar, this message translates to:
  /// **'هل تستخدمين وسائل منع الحمل؟'**
  String get qContraception;

  /// No description provided for @contraceptionNone.
  ///
  /// In ar, this message translates to:
  /// **'لا شيء'**
  String get contraceptionNone;

  /// No description provided for @contraceptionPill.
  ///
  /// In ar, this message translates to:
  /// **'حبوب منع الحمل'**
  String get contraceptionPill;

  /// No description provided for @contraceptionIUD.
  ///
  /// In ar, this message translates to:
  /// **'لولب'**
  String get contraceptionIUD;

  /// No description provided for @contraceptionImplant.
  ///
  /// In ar, this message translates to:
  /// **'غرسة'**
  String get contraceptionImplant;

  /// No description provided for @contraceptionOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get contraceptionOther;

  /// No description provided for @qStress.
  ///
  /// In ar, this message translates to:
  /// **'مستوى التوتر'**
  String get qStress;

  /// No description provided for @stressLow.
  ///
  /// In ar, this message translates to:
  /// **'منخفض'**
  String get stressLow;

  /// No description provided for @stressMedium.
  ///
  /// In ar, this message translates to:
  /// **'متوسط'**
  String get stressMedium;

  /// No description provided for @stressHigh.
  ///
  /// In ar, this message translates to:
  /// **'مرتفع'**
  String get stressHigh;

  /// No description provided for @qSleep.
  ///
  /// In ar, this message translates to:
  /// **'مدة النوم'**
  String get qSleep;

  /// No description provided for @sleepLess6.
  ///
  /// In ar, this message translates to:
  /// **'أقل من 6 ساعات'**
  String get sleepLess6;

  /// No description provided for @sleep6to8.
  ///
  /// In ar, this message translates to:
  /// **'6–8 ساعات'**
  String get sleep6to8;

  /// No description provided for @sleepMore8.
  ///
  /// In ar, this message translates to:
  /// **'أكثر من 8 ساعات'**
  String get sleepMore8;

  /// No description provided for @qWeight.
  ///
  /// In ar, this message translates to:
  /// **'ما وزنك؟'**
  String get qWeight;

  /// No description provided for @selectDate.
  ///
  /// In ar, this message translates to:
  /// **'اختاري التاريخ'**
  String get selectDate;

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// No description provided for @continueLabel.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueLabel;

  /// No description provided for @goHome.
  ///
  /// In ar, this message translates to:
  /// **'الذهاب للرئيسية'**
  String get goHome;

  /// No description provided for @profileReadyTitle.
  ///
  /// In ar, this message translates to:
  /// **'ملفك الشخصي جاهز'**
  String get profileReadyTitle;

  /// No description provided for @profileReadyDesc.
  ///
  /// In ar, this message translates to:
  /// **'يمكن لدورتي الآن تخصيص توقعات دورتك.'**
  String get profileReadyDesc;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navCalendar.
  ///
  /// In ar, this message translates to:
  /// **'التقويم'**
  String get navCalendar;

  /// No description provided for @navLog.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل'**
  String get navLog;

  /// No description provided for @navInsights.
  ///
  /// In ar, this message translates to:
  /// **'التحليلات'**
  String get navInsights;

  /// No description provided for @navArticles.
  ///
  /// In ar, this message translates to:
  /// **'المقالات'**
  String get navArticles;

  /// No description provided for @navProfile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get navProfile;

  /// No description provided for @profileTitle.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profileTitle;

  /// No description provided for @freePlan.
  ///
  /// In ar, this message translates to:
  /// **'خطة دورتي المجانية'**
  String get freePlan;

  /// No description provided for @cycleLabel.
  ///
  /// In ar, this message translates to:
  /// **'الدورة'**
  String get cycleLabel;

  /// No description provided for @dayLabel.
  ///
  /// In ar, this message translates to:
  /// **'اليوم {day}'**
  String dayLabel(int day);

  /// No description provided for @phaseLabel.
  ///
  /// In ar, this message translates to:
  /// **'المرحلة'**
  String get phaseLabel;

  /// No description provided for @waterLabel.
  ///
  /// In ar, this message translates to:
  /// **'الماء'**
  String get waterLabel;

  /// No description provided for @sleepLabel.
  ///
  /// In ar, this message translates to:
  /// **'النوم'**
  String get sleepLabel;

  /// No description provided for @premiumTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتي بريميوم'**
  String get premiumTitle;

  /// No description provided for @premiumSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'افتحي مساعد الذكاء الاصطناعي والتحليلات المتقدمة.'**
  String get premiumSubtitle;

  /// No description provided for @premiumPlanLabel.
  ///
  /// In ar, this message translates to:
  /// **'خطة دورتي بريميوم'**
  String get premiumPlanLabel;

  /// No description provided for @premiumActiveTitle.
  ///
  /// In ar, this message translates to:
  /// **'بريميوم مفعّل'**
  String get premiumActiveTitle;

  /// No description provided for @premiumActiveDesc.
  ///
  /// In ar, this message translates to:
  /// **'لديكِ وصول كامل لجميع المزايا. شكرًا لكِ!'**
  String get premiumActiveDesc;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get settingsTheme;

  /// No description provided for @chooseThemeTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختاري المظهر'**
  String get chooseThemeTitle;

  /// No description provided for @themeSystem.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي (حسب النظام)'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get themeDark;

  /// No description provided for @settingsNotifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات الدورة'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsPrivacy.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyDesc.
  ///
  /// In ar, this message translates to:
  /// **'إدارة بياناتك'**
  String get settingsPrivacyDesc;

  /// No description provided for @settingsCycle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الدورة'**
  String get settingsCycle;

  /// No description provided for @settingsCycleDesc.
  ///
  /// In ar, this message translates to:
  /// **'دورة من 28 يومًا'**
  String get settingsCycleDesc;

  /// No description provided for @settingsHelp.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة والدعم'**
  String get settingsHelp;

  /// No description provided for @settingsHelpDesc.
  ///
  /// In ar, this message translates to:
  /// **'تواصلي معنا'**
  String get settingsHelpDesc;

  /// No description provided for @settingsLogout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutDesc.
  ///
  /// In ar, this message translates to:
  /// **'الخروج من دورتي'**
  String get settingsLogoutDesc;

  /// No description provided for @todaysJourney.
  ///
  /// In ar, this message translates to:
  /// **'رحلة اليوم'**
  String get todaysJourney;

  /// No description provided for @moodLabel.
  ///
  /// In ar, this message translates to:
  /// **'المزاج'**
  String get moodLabel;

  /// No description provided for @activityLabel.
  ///
  /// In ar, this message translates to:
  /// **'النشاط'**
  String get activityLabel;

  /// No description provided for @homeLogPeriod.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدورة'**
  String get homeLogPeriod;

  /// No description provided for @homeSymptoms.
  ///
  /// In ar, this message translates to:
  /// **'الأعراض'**
  String get homeSymptoms;

  /// No description provided for @homeSex.
  ///
  /// In ar, this message translates to:
  /// **'العلاقة'**
  String get homeSex;

  /// No description provided for @ovulationToday.
  ///
  /// In ar, this message translates to:
  /// **'التبويض اليوم'**
  String get ovulationToday;

  /// No description provided for @ovulationIn.
  ///
  /// In ar, this message translates to:
  /// **'التبويض خلال'**
  String get ovulationIn;

  /// No description provided for @todayLabel.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get todayLabel;

  /// No description provided for @daysCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} أيام'**
  String daysCount(int count);

  /// No description provided for @highChancePregnancy.
  ///
  /// In ar, this message translates to:
  /// **'فرصة عالية للحمل'**
  String get highChancePregnancy;

  /// No description provided for @fertilityIncreasing.
  ///
  /// In ar, this message translates to:
  /// **'الخصوبة في ازدياد'**
  String get fertilityIncreasing;

  /// No description provided for @lowChancePregnancy.
  ///
  /// In ar, this message translates to:
  /// **'فرصة منخفضة للحمل'**
  String get lowChancePregnancy;

  /// No description provided for @seeDailyInsights.
  ///
  /// In ar, this message translates to:
  /// **'شاهدي تحليلاتك اليومية'**
  String get seeDailyInsights;

  /// No description provided for @todaysArticles.
  ///
  /// In ar, this message translates to:
  /// **'مقالات اليوم'**
  String get todaysArticles;

  /// No description provided for @articleFertilityTitle.
  ///
  /// In ar, this message translates to:
  /// **'خصوبتك اليوم'**
  String get articleFertilityTitle;

  /// No description provided for @articleFertilitySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تم التحديث الآن'**
  String get articleFertilitySubtitle;

  /// No description provided for @articleCrampsTitle.
  ///
  /// In ar, this message translates to:
  /// **'كيفية تخفيف التقلصات'**
  String get articleCrampsTitle;

  /// No description provided for @articleCrampsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 5 دقائق'**
  String get articleCrampsSubtitle;

  /// No description provided for @articleCycleTitle.
  ///
  /// In ar, this message translates to:
  /// **'افهمي دورتك'**
  String get articleCycleTitle;

  /// No description provided for @dawratiAiLabel.
  ///
  /// In ar, this message translates to:
  /// **'ذكاء دورتي الاصطناعي'**
  String get dawratiAiLabel;

  /// No description provided for @symptomCheckerTitle.
  ///
  /// In ar, this message translates to:
  /// **'فحص الأعراض'**
  String get symptomCheckerTitle;

  /// No description provided for @seeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get seeAll;

  /// No description provided for @symptomTrackText.
  ///
  /// In ar, this message translates to:
  /// **'تتبعي الأعراض غير المعتادة واعرفي متى تحتاج انتباهًا.'**
  String get symptomTrackText;

  /// No description provided for @symptomHelpText.
  ///
  /// In ar, this message translates to:
  /// **'يمكن لدورتي مساعدتك على فهم أنماط دورتك، مزاجك، نومك وأعراضك.'**
  String get symptomHelpText;

  /// No description provided for @quickSelfCheck.
  ///
  /// In ar, this message translates to:
  /// **'فحص ذاتي سريع'**
  String get quickSelfCheck;

  /// No description provided for @minutesReadLabel.
  ///
  /// In ar, this message translates to:
  /// **'{count} دقائق'**
  String minutesReadLabel(int count);

  /// No description provided for @checkMySymptoms.
  ///
  /// In ar, this message translates to:
  /// **'افحصي أعراضي'**
  String get checkMySymptoms;

  /// No description provided for @notDiagnosisTool.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة: دورتي ليست أداة تشخيص.'**
  String get notDiagnosisTool;

  /// No description provided for @basedOnCycle.
  ///
  /// In ar, this message translates to:
  /// **'بناءً على دورتك الحالية'**
  String get basedOnCycle;

  /// No description provided for @learningBodyTitle.
  ///
  /// In ar, this message translates to:
  /// **'فهم جسدك'**
  String get learningBodyTitle;

  /// No description provided for @learningHabitsTitle.
  ///
  /// In ar, this message translates to:
  /// **'عادات صحية'**
  String get learningHabitsTitle;

  /// No description provided for @learningHormonesTitle.
  ///
  /// In ar, this message translates to:
  /// **'الهرمونات ببساطة'**
  String get learningHormonesTitle;

  /// No description provided for @seeMore.
  ///
  /// In ar, this message translates to:
  /// **'عرض المزيد'**
  String get seeMore;

  /// No description provided for @recommendedForYou.
  ///
  /// In ar, this message translates to:
  /// **'موصى به لك'**
  String get recommendedForYou;

  /// No description provided for @aiRecommendationText.
  ///
  /// In ar, this message translates to:
  /// **'قد تنخفض طاقتك خلال اليومين القادمين. أعطي الأولوية للنوم والترطيب.'**
  String get aiRecommendationText;

  /// No description provided for @nutritionLabel.
  ///
  /// In ar, this message translates to:
  /// **'التغذية'**
  String get nutritionLabel;

  /// No description provided for @nutritionRecommendationText.
  ///
  /// In ar, this message translates to:
  /// **'الأطعمة الغنية بالحديد يمكن أن تدعم جسدك خلال هذه المرحلة.'**
  String get nutritionRecommendationText;

  /// No description provided for @sleepRecommendationText.
  ///
  /// In ar, this message translates to:
  /// **'النوم مبكرًا بـ 30 دقيقة قد يحسّن تعافيك.'**
  String get sleepRecommendationText;

  /// No description provided for @myCycleTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتي'**
  String get myCycleTitle;

  /// No description provided for @currentDay.
  ///
  /// In ar, this message translates to:
  /// **'اليوم الحالي'**
  String get currentDay;

  /// No description provided for @currentPhase.
  ///
  /// In ar, this message translates to:
  /// **'المرحلة الحالية'**
  String get currentPhase;

  /// No description provided for @averageCycle.
  ///
  /// In ar, this message translates to:
  /// **'متوسط الدورة'**
  String get averageCycle;

  /// No description provided for @averagePeriodLength.
  ///
  /// In ar, this message translates to:
  /// **'مدة الدورة الشهرية'**
  String get averagePeriodLength;

  /// No description provided for @logsSaved.
  ///
  /// In ar, this message translates to:
  /// **'السجلات المحفوظة'**
  String get logsSaved;

  /// No description provided for @aiCoachCardTitle.
  ///
  /// In ar, this message translates to:
  /// **'مدرب دورتي الذكي'**
  String get aiCoachCardTitle;

  /// No description provided for @aiCoachCardSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اسألي مساعدة دورتك للحصول على إرشادات يومية.'**
  String get aiCoachCardSubtitle;

  /// No description provided for @premiumUnlockTextLong.
  ///
  /// In ar, this message translates to:
  /// **'افتحي مساعد الذكاء الاصطناعي والتحليلات المتقدمة وسجلًا غير محدود.'**
  String get premiumUnlockTextLong;

  /// No description provided for @tryPremium.
  ///
  /// In ar, this message translates to:
  /// **'جربي بريميوم ←'**
  String get tryPremium;

  /// No description provided for @phaseMenstruation.
  ///
  /// In ar, this message translates to:
  /// **'الحيض'**
  String get phaseMenstruation;

  /// No description provided for @phaseFollicular.
  ///
  /// In ar, this message translates to:
  /// **'الطور الجريبي'**
  String get phaseFollicular;

  /// No description provided for @phaseOvulation.
  ///
  /// In ar, this message translates to:
  /// **'التبويض'**
  String get phaseOvulation;

  /// No description provided for @phaseLuteal.
  ///
  /// In ar, this message translates to:
  /// **'الطور الأصفري'**
  String get phaseLuteal;

  /// No description provided for @fertilityPeak.
  ///
  /// In ar, this message translates to:
  /// **'ذروة'**
  String get fertilityPeak;

  /// No description provided for @fertilityHigh.
  ///
  /// In ar, this message translates to:
  /// **'مرتفعة'**
  String get fertilityHigh;

  /// No description provided for @fertilityMedium.
  ///
  /// In ar, this message translates to:
  /// **'متوسطة'**
  String get fertilityMedium;

  /// No description provided for @fertilityLow.
  ///
  /// In ar, this message translates to:
  /// **'منخفضة'**
  String get fertilityLow;

  /// No description provided for @cycleDayLabel.
  ///
  /// In ar, this message translates to:
  /// **'اليوم {day} من الدورة'**
  String cycleDayLabel(int day);

  /// No description provided for @goodMorning.
  ///
  /// In ar, this message translates to:
  /// **'صباح الخير 🌸'**
  String get goodMorning;

  /// No description provided for @peakFertility.
  ///
  /// In ar, this message translates to:
  /// **'ذروة الخصوبة'**
  String get peakFertility;

  /// No description provided for @highFertility.
  ///
  /// In ar, this message translates to:
  /// **'خصوبة مرتفعة'**
  String get highFertility;

  /// No description provided for @lowFertility.
  ///
  /// In ar, this message translates to:
  /// **'خصوبة منخفضة'**
  String get lowFertility;

  /// No description provided for @legendPeriod.
  ///
  /// In ar, this message translates to:
  /// **'الدورة'**
  String get legendPeriod;

  /// No description provided for @legendFertile.
  ///
  /// In ar, this message translates to:
  /// **'خصبة'**
  String get legendFertile;

  /// No description provided for @legendSelected.
  ///
  /// In ar, this message translates to:
  /// **'محدد'**
  String get legendSelected;

  /// No description provided for @chanceOfPregnancy.
  ///
  /// In ar, this message translates to:
  /// **'فرصة الحمل'**
  String get chanceOfPregnancy;

  /// No description provided for @fertilityDescPeak.
  ///
  /// In ar, this message translates to:
  /// **'التبويض اليوم. هذا يومك الأكثر خصوبة.'**
  String get fertilityDescPeak;

  /// No description provided for @fertilityDescHigh.
  ///
  /// In ar, this message translates to:
  /// **'أنتِ في نافذة الخصوبة. فرصة الحمل أعلى الآن.'**
  String get fertilityDescHigh;

  /// No description provided for @fertilityDescMedium.
  ///
  /// In ar, this message translates to:
  /// **'نافذة خصوبتك تقترب قريبًا.'**
  String get fertilityDescMedium;

  /// No description provided for @fertilityDescLow.
  ///
  /// In ar, this message translates to:
  /// **'فرصة منخفضة اليوم. أيام الخصوبة غير نشطة حاليًا.'**
  String get fertilityDescLow;

  /// No description provided for @cycleTimelineTitle.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الزمني للدورة'**
  String get cycleTimelineTitle;

  /// No description provided for @dailySummaryTitle.
  ///
  /// In ar, this message translates to:
  /// **'الملخص اليومي'**
  String get dailySummaryTitle;

  /// No description provided for @noLogForDay.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد سجل لهذا اليوم. أضيفي المزاج، الماء، النوم والأعراض.'**
  String get noLogForDay;

  /// No description provided for @noLogForDayShort.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد سجل لهذا اليوم'**
  String get noLogForDayShort;

  /// No description provided for @trackMoreDetails.
  ///
  /// In ar, this message translates to:
  /// **'تتبعي الأعراض، المزاج، النوم، الماء والمزيد.'**
  String get trackMoreDetails;

  /// No description provided for @addDailyLog.
  ///
  /// In ar, this message translates to:
  /// **'إضافة سجل يومي'**
  String get addDailyLog;

  /// No description provided for @setAsPeriodStart.
  ///
  /// In ar, this message translates to:
  /// **'تعيين كبداية للدورة'**
  String get setAsPeriodStart;

  /// No description provided for @notesLabel.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get notesLabel;

  /// No description provided for @cycleDayShort.
  ///
  /// In ar, this message translates to:
  /// **'يوم الدورة'**
  String get cycleDayShort;

  /// No description provided for @currentPhaseShort.
  ///
  /// In ar, this message translates to:
  /// **'المرحلة الحالية'**
  String get currentPhaseShort;

  /// No description provided for @dailyLogLabel.
  ///
  /// In ar, this message translates to:
  /// **'السجل اليومي'**
  String get dailyLogLabel;

  /// No description provided for @selectedDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ المحدد'**
  String get selectedDateLabel;

  /// No description provided for @logSavedForDate.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ السجل ليوم {date}'**
  String logSavedForDate(String date);

  /// No description provided for @howDoYouFeelToday.
  ///
  /// In ar, this message translates to:
  /// **'كيف تشعرين اليوم؟'**
  String get howDoYouFeelToday;

  /// No description provided for @moodAmazing.
  ///
  /// In ar, this message translates to:
  /// **'رائع'**
  String get moodAmazing;

  /// No description provided for @moodGood.
  ///
  /// In ar, this message translates to:
  /// **'جيد'**
  String get moodGood;

  /// No description provided for @moodOkay.
  ///
  /// In ar, this message translates to:
  /// **'مقبول'**
  String get moodOkay;

  /// No description provided for @moodSad.
  ///
  /// In ar, this message translates to:
  /// **'حزين'**
  String get moodSad;

  /// No description provided for @moodAwful.
  ///
  /// In ar, this message translates to:
  /// **'سيء جدًا'**
  String get moodAwful;

  /// No description provided for @symptomCramps.
  ///
  /// In ar, this message translates to:
  /// **'تقلصات'**
  String get symptomCramps;

  /// No description provided for @symptomBloating.
  ///
  /// In ar, this message translates to:
  /// **'انتفاخ'**
  String get symptomBloating;

  /// No description provided for @symptomHeadache.
  ///
  /// In ar, this message translates to:
  /// **'صداع'**
  String get symptomHeadache;

  /// No description provided for @symptomBackPain.
  ///
  /// In ar, this message translates to:
  /// **'ألم الظهر'**
  String get symptomBackPain;

  /// No description provided for @symptomAcne.
  ///
  /// In ar, this message translates to:
  /// **'حب الشباب'**
  String get symptomAcne;

  /// No description provided for @symptomFatigue.
  ///
  /// In ar, this message translates to:
  /// **'إرهاق'**
  String get symptomFatigue;

  /// No description provided for @symptomNausea.
  ///
  /// In ar, this message translates to:
  /// **'غثيان'**
  String get symptomNausea;

  /// No description provided for @symptomBreastPain.
  ///
  /// In ar, this message translates to:
  /// **'ألم الثدي'**
  String get symptomBreastPain;

  /// No description provided for @periodFlowTitle.
  ///
  /// In ar, this message translates to:
  /// **'تدفق الدورة'**
  String get periodFlowTitle;

  /// No description provided for @flowSpotting.
  ///
  /// In ar, this message translates to:
  /// **'نزيف خفيف جدًا'**
  String get flowSpotting;

  /// No description provided for @flowLight.
  ///
  /// In ar, this message translates to:
  /// **'خفيف'**
  String get flowLight;

  /// No description provided for @flowMedium.
  ///
  /// In ar, this message translates to:
  /// **'متوسط'**
  String get flowMedium;

  /// No description provided for @flowHeavy.
  ///
  /// In ar, this message translates to:
  /// **'غزير'**
  String get flowHeavy;

  /// No description provided for @energyTitle.
  ///
  /// In ar, this message translates to:
  /// **'الطاقة'**
  String get energyTitle;

  /// No description provided for @activityNone.
  ///
  /// In ar, this message translates to:
  /// **'لا شيء'**
  String get activityNone;

  /// No description provided for @activityWalk.
  ///
  /// In ar, this message translates to:
  /// **'مشي'**
  String get activityWalk;

  /// No description provided for @activityRun.
  ///
  /// In ar, this message translates to:
  /// **'جري'**
  String get activityRun;

  /// No description provided for @activityGym.
  ///
  /// In ar, this message translates to:
  /// **'نادي رياضي'**
  String get activityGym;

  /// No description provided for @activityYoga.
  ///
  /// In ar, this message translates to:
  /// **'يوغا'**
  String get activityYoga;

  /// No description provided for @notesHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتبي أي شيء تريدين تذكره...'**
  String get notesHint;

  /// No description provided for @saveLog.
  ///
  /// In ar, this message translates to:
  /// **'حفظ السجل'**
  String get saveLog;

  /// No description provided for @todaysWellness.
  ///
  /// In ar, this message translates to:
  /// **'عافية اليوم'**
  String get todaysWellness;

  /// No description provided for @aiInsightSample.
  ///
  /// In ar, this message translates to:
  /// **'بناءً على مزاجك ونومك وترطيبك اليوم، يبدو أن جسمك يتعافى جيدًا. واصلي شرب الماء وأعطي الأولوية للنوم الجيد الليلة.'**
  String get aiInsightSample;

  /// No description provided for @insightsTitle.
  ///
  /// In ar, this message translates to:
  /// **'التحليلات'**
  String get insightsTitle;

  /// No description provided for @cycleOverview.
  ///
  /// In ar, this message translates to:
  /// **'نظرة عامة على الدورة'**
  String get cycleOverview;

  /// No description provided for @last7Days.
  ///
  /// In ar, this message translates to:
  /// **'آخر 7 أيام'**
  String get last7Days;

  /// No description provided for @hydrationTitle.
  ///
  /// In ar, this message translates to:
  /// **'الترطيب'**
  String get hydrationTitle;

  /// No description provided for @logsLabel.
  ///
  /// In ar, this message translates to:
  /// **'السجلات'**
  String get logsLabel;

  /// No description provided for @aiInsightDynamicText.
  ///
  /// In ar, this message translates to:
  /// **'أنتِ حاليًا في مرحلة {phase}. يُظهر سجلك الأخير {water} لتر ماء، {sleep} ساعات نوم والمزاج: {mood}.'**
  String aiInsightDynamicText(
    String phase,
    String water,
    String sleep,
    String mood,
  );

  /// No description provided for @advancedInsights.
  ///
  /// In ar, this message translates to:
  /// **'تحليلات متقدمة'**
  String get advancedInsights;

  /// No description provided for @advancedInsightsDesc.
  ///
  /// In ar, this message translates to:
  /// **'افتحي اتجاهات الدورة، أنماط الأعراض وتحليل الصحة بالذكاء الاصطناعي.'**
  String get advancedInsightsDesc;

  /// No description provided for @premiumArrow.
  ///
  /// In ar, this message translates to:
  /// **'بريميوم ←'**
  String get premiumArrow;

  /// No description provided for @personalAiCoach.
  ///
  /// In ar, this message translates to:
  /// **'مدربك الشخصي بالذكاء الاصطناعي'**
  String get personalAiCoach;

  /// No description provided for @dailyGuidanceDesc.
  ///
  /// In ar, this message translates to:
  /// **'إرشادات يومية بناءً على دورتك وسجلات صحتك.'**
  String get dailyGuidanceDesc;

  /// No description provided for @phaseDayCombo.
  ///
  /// In ar, this message translates to:
  /// **'{phase} • اليوم {day}'**
  String phaseDayCombo(String phase, int day);

  /// No description provided for @todaysMood.
  ///
  /// In ar, this message translates to:
  /// **'مزاج اليوم'**
  String get todaysMood;

  /// No description provided for @hydrationTodayValue.
  ///
  /// In ar, this message translates to:
  /// **'{value} لتر اليوم'**
  String hydrationTodayValue(String value);

  /// No description provided for @sleepHoursValue.
  ///
  /// In ar, this message translates to:
  /// **'{value} ساعات'**
  String sleepHoursValue(String value);

  /// No description provided for @todaysAiInsight.
  ///
  /// In ar, this message translates to:
  /// **'تحليل الذكاء الاصطناعي اليوم'**
  String get todaysAiInsight;

  /// No description provided for @startAiConversation.
  ///
  /// In ar, this message translates to:
  /// **'بدء محادثة مع الذكاء الاصطناعي'**
  String get startAiConversation;

  /// No description provided for @aiChatComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'ستتوفر محادثة الذكاء الاصطناعي في النسخة القادمة.'**
  String get aiChatComingSoon;

  /// No description provided for @insightOvulation.
  ///
  /// In ar, this message translates to:
  /// **'من المرجح أنكِ في أكثر مراحلك نشاطًا. حافظي على الترطيب واستمتعي بالنشاط البدني إن شعرتِ بالراحة.'**
  String get insightOvulation;

  /// No description provided for @insightMenstruation.
  ///
  /// In ar, this message translates to:
  /// **'قد يحتاج جسمك لمزيد من الراحة اليوم. أعطي الأولوية للنوم والترطيب والأطعمة الغنية بالحديد.'**
  String get insightMenstruation;

  /// No description provided for @insightLowHydration.
  ///
  /// In ar, this message translates to:
  /// **'ترطيبك أقل من الموصى به. شرب المزيد من الماء قد يساعد على تقليل الإرهاق.'**
  String get insightLowHydration;

  /// No description provided for @insightLowSleep.
  ///
  /// In ar, this message translates to:
  /// **'نمتِ أقل من الموصى به. موعد نوم ثابت قد يحسّن طاقتك غدًا.'**
  String get insightLowSleep;

  /// No description provided for @insightBalanced.
  ///
  /// In ar, this message translates to:
  /// **'بيانات صحتك الأخيرة تبدو متوازنة. واصلي التتبع اليومي للحصول على تحليلات أكثر تخصيصًا.'**
  String get insightBalanced;

  /// No description provided for @premiumAppBarTitle.
  ///
  /// In ar, this message translates to:
  /// **'بريميوم'**
  String get premiumAppBarTitle;

  /// No description provided for @unlockPremiumTitle.
  ///
  /// In ar, this message translates to:
  /// **'افتحي دورتي بريميوم'**
  String get unlockPremiumTitle;

  /// No description provided for @unlockPremiumDesc.
  ///
  /// In ar, this message translates to:
  /// **'مدرب ذكاء اصطناعي، تحليلات متقدمة، سجل غير محدود وتوقعات دورة أذكى.'**
  String get unlockPremiumDesc;

  /// No description provided for @featureAiCoachDesc.
  ///
  /// In ar, this message translates to:
  /// **'إرشادات شخصية بناءً على دورتك وسجلاتك اليومية.'**
  String get featureAiCoachDesc;

  /// No description provided for @featureAdvancedInsightsDesc.
  ///
  /// In ar, this message translates to:
  /// **'افهمي المزاج، النوم، الترطيب واتجاهات الدورة.'**
  String get featureAdvancedInsightsDesc;

  /// No description provided for @featureUnlimitedHistoryTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل غير محدود'**
  String get featureUnlimitedHistoryTitle;

  /// No description provided for @featureUnlimitedHistoryDesc.
  ///
  /// In ar, this message translates to:
  /// **'تتبعي الأنماط عبر الأشهر، وليس فقط الأيام الأخيرة.'**
  String get featureUnlimitedHistoryDesc;

  /// No description provided for @featureCloudBackupTitle.
  ///
  /// In ar, this message translates to:
  /// **'نسخ احتياطي سحابي'**
  String get featureCloudBackupTitle;

  /// No description provided for @featureCloudBackupDesc.
  ///
  /// In ar, this message translates to:
  /// **'احفظي بيانات صحتك آمنة عبر جميع أجهزتك.'**
  String get featureCloudBackupDesc;

  /// No description provided for @monthlyLabel.
  ///
  /// In ar, this message translates to:
  /// **'شهري'**
  String get monthlyLabel;

  /// No description provided for @annualLabel.
  ///
  /// In ar, this message translates to:
  /// **'سنوي'**
  String get annualLabel;

  /// No description provided for @startPremium.
  ///
  /// In ar, this message translates to:
  /// **'ابدئي بريميوم'**
  String get startPremium;

  /// No description provided for @premiumActivated.
  ///
  /// In ar, this message translates to:
  /// **'تم تفعيل بريميوم'**
  String get premiumActivated;

  /// No description provided for @testingModeDisabled.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاختبار: الدفع معطل.'**
  String get testingModeDisabled;

  /// No description provided for @restorePurchases.
  ///
  /// In ar, this message translates to:
  /// **'استعادة مشترياتي'**
  String get restorePurchases;

  /// No description provided for @billingUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'عمليات الشراء داخل التطبيق غير متاحة على هذا الجهاز حاليًا.'**
  String get billingUnavailable;

  /// No description provided for @premiumKicker.
  ///
  /// In ar, this message translates to:
  /// **'افهمي جسمك، دورة بعد دورة'**
  String get premiumKicker;

  /// No description provided for @premiumBestValueBadge.
  ///
  /// In ar, this message translates to:
  /// **'الأفضل قيمة'**
  String get premiumBestValueBadge;

  /// No description provided for @premiumMonthlyEquivalent.
  ///
  /// In ar, this message translates to:
  /// **'~{price}/شهريًا، بفوترة سنوية'**
  String premiumMonthlyEquivalent(String price);

  /// No description provided for @premiumSavePercent.
  ///
  /// In ar, this message translates to:
  /// **'وفّري {percent}٪'**
  String premiumSavePercent(int percent);

  /// No description provided for @premiumTrustLine.
  ///
  /// In ar, this message translates to:
  /// **'🔒 دفع آمن عبر Google Play · ألغي في أي وقت'**
  String get premiumTrustLine;

  /// No description provided for @premiumFomoLine.
  ///
  /// In ar, this message translates to:
  /// **'جسمك يرسل لك إشارات كل يوم — بريميوم يساعدك على فهمها فعليًا.'**
  String get premiumFomoLine;

  /// No description provided for @notificationsSettingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsSettingsTitle;

  /// No description provided for @notificationsSettingsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختاري التذكيرات التي تريدين تلقيها.'**
  String get notificationsSettingsSubtitle;

  /// No description provided for @periodReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير الدورة'**
  String get periodReminderTitle;

  /// No description provided for @periodReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'احصلي على إشعار قبل يومين من موعد دورتك المتوقع.'**
  String get periodReminderDesc;

  /// No description provided for @ovulationReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير التبويض'**
  String get ovulationReminderTitle;

  /// No description provided for @ovulationReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'احصلي على إشعار في يوم التبويض المتوقع.'**
  String get ovulationReminderDesc;

  /// No description provided for @waterReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير الماء'**
  String get waterReminderTitle;

  /// No description provided for @waterReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'تذكير يومي للحفاظ على ترطيب جسمك.'**
  String get waterReminderDesc;

  /// No description provided for @sleepReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير النوم'**
  String get sleepReminderTitle;

  /// No description provided for @sleepReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'تذكير لطيف للبدء بالاستعداد للنوم.'**
  String get sleepReminderDesc;

  /// No description provided for @dailyLogReminderTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكير السجل اليومي'**
  String get dailyLogReminderTitle;

  /// No description provided for @dailyLogReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'لا تنسي تسجيل يومك.'**
  String get dailyLogReminderDesc;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوقت'**
  String get reminderTimeLabel;

  /// No description provided for @notificationPermissionDeniedMsg.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات معطلة. فعّليها من إعدادات جهازك لتلقي التذكيرات.'**
  String get notificationPermissionDeniedMsg;

  /// No description provided for @periodReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتك قادمة'**
  String get periodReminderNotifTitle;

  /// No description provided for @periodReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'من المتوقع أن تبدأ دورتك خلال يومين. استعدي!'**
  String get periodReminderNotifBody;

  /// No description provided for @ovulationReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'يوم التبويض'**
  String get ovulationReminderNotifTitle;

  /// No description provided for @ovulationReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'اليوم هو يوم تبويضك المتوقع.'**
  String get ovulationReminderNotifBody;

  /// No description provided for @waterReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'حافظي على ترطيبك'**
  String get waterReminderNotifTitle;

  /// No description provided for @waterReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'حان وقت شرب الماء.'**
  String get waterReminderNotifBody;

  /// No description provided for @sleepReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'استعدي للنوم'**
  String get sleepReminderNotifTitle;

  /// No description provided for @sleepReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'اقترب موعد النوم. استعدي لليلة نوم هادئة.'**
  String get sleepReminderNotifBody;

  /// No description provided for @dailyLogReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'متابعة يومية'**
  String get dailyLogReminderNotifTitle;

  /// No description provided for @dailyLogReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'لا تنسي تسجيل مزاجك وأعراضك والمزيد اليوم.'**
  String get dailyLogReminderNotifBody;

  /// No description provided for @privacyTitle.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية'**
  String get privacyTitle;

  /// No description provided for @privacyIntro.
  ///
  /// In ar, this message translates to:
  /// **'تخزّن دورتي بياناتك (الدورة، السجلات اليومية، الإعدادات) على هذا الجهاز. إذا سجّلتِ الدخول، تتم أيضًا مزامنة بياناتك بأمان مع خوادمنا السحابية للنسخ الاحتياطي وعبر الأجهزة. عند استخدام ميزات الذكاء الاصطناعي، يُرسل السياق ذو الصلة إلى مزوّد الذكاء الاصطناعي لتوليد الردود.'**
  String get privacyIntro;

  /// No description provided for @privacyDataListTitle.
  ///
  /// In ar, this message translates to:
  /// **'ما يتم تخزينه على هذا الجهاز'**
  String get privacyDataListTitle;

  /// No description provided for @privacyDataCycle.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ بداية دورتك وسجل دورتك'**
  String get privacyDataCycle;

  /// No description provided for @privacyDataLogs.
  ///
  /// In ar, this message translates to:
  /// **'سجلاتك اليومية (المزاج، الأعراض، الماء، النوم، الملاحظات)'**
  String get privacyDataLogs;

  /// No description provided for @privacyDataSettings.
  ///
  /// In ar, this message translates to:
  /// **'تفضيلات اللغة والإشعارات والاشتراك'**
  String get privacyDataSettings;

  /// No description provided for @clearMyData.
  ///
  /// In ar, this message translates to:
  /// **'مسح بياناتي'**
  String get clearMyData;

  /// No description provided for @clearMyDataDesc.
  ///
  /// In ar, this message translates to:
  /// **'حذف كل ما هو مخزن على هذا الجهاز نهائيًا وإعادة بدء التهيئة. إذا كنتِ مسجلة الدخول، تبقى بياناتك السحابية محفوظة ما لم تسجّلي الخروج.'**
  String get clearMyDataDesc;

  /// No description provided for @clearDataConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'مسح جميع البيانات؟'**
  String get clearDataConfirmTitle;

  /// No description provided for @clearDataConfirmDesc.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن التراجع عن هذا الإجراء. سيتم حذف كل سجل دورتك وسجلاتك وإعداداتك على هذا الجهاز.'**
  String get clearDataConfirmDesc;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @dataCleared.
  ///
  /// In ar, this message translates to:
  /// **'تم مسح بياناتك.'**
  String get dataCleared;

  /// No description provided for @cycleSettingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الدورة'**
  String get cycleSettingsTitle;

  /// No description provided for @periodStartDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ بداية الدورة'**
  String get periodStartDateLabel;

  /// No description provided for @changeDate.
  ///
  /// In ar, this message translates to:
  /// **'تغيير التاريخ'**
  String get changeDate;

  /// No description provided for @cycleAssumptionsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الافتراضات الحالية'**
  String get cycleAssumptionsTitle;

  /// No description provided for @cycleAssumptionsDesc.
  ///
  /// In ar, this message translates to:
  /// **'تتوقع دورتي حاليًا دورتك باستخدام دورة ثابتة مدتها 28 يومًا وفترة حيض مدتها 5 أيام. ستتوفر مدة دورة مخصصة في تحديث قادم.'**
  String get cycleAssumptionsDesc;

  /// No description provided for @helpSupportTitle.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة والدعم'**
  String get helpSupportTitle;

  /// No description provided for @helpIntro.
  ///
  /// In ar, this message translates to:
  /// **'لديك سؤال أو وجدتِ مشكلة؟ نحن هنا للمساعدة.'**
  String get helpIntro;

  /// No description provided for @helpContactEmail.
  ///
  /// In ar, this message translates to:
  /// **'تواصلي معنا'**
  String get helpContactEmail;

  /// No description provided for @helpFaqTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get helpFaqTitle;

  /// No description provided for @helpFaq1Q.
  ///
  /// In ar, this message translates to:
  /// **'ما مدى دقة توقعات الدورة؟'**
  String get helpFaq1Q;

  /// No description provided for @helpFaq1A.
  ///
  /// In ar, this message translates to:
  /// **'التوقعات تقديرية بناءً على دورة قياسية مدتها 28 يومًا وتاريخ بداية الدورة الذي تحددينه. تتحسن كلما سجلتِ المزيد من البيانات.'**
  String get helpFaq1A;

  /// No description provided for @helpFaq2Q.
  ///
  /// In ar, this message translates to:
  /// **'هل بياناتي خاصة؟'**
  String get helpFaq2Q;

  /// No description provided for @helpFaq2A.
  ///
  /// In ar, this message translates to:
  /// **'نعم. تُخزَّن بياناتك حاليًا على هذا الجهاز فقط ولا تتم مشاركتها مع أحد.'**
  String get helpFaq2A;

  /// No description provided for @helpFaq3Q.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني تصدير بياناتي؟'**
  String get helpFaq3Q;

  /// No description provided for @helpFaq3A.
  ///
  /// In ar, this message translates to:
  /// **'تصدير البيانات مخطط له في تحديث قادم.'**
  String get helpFaq3A;

  /// No description provided for @last30Days.
  ///
  /// In ar, this message translates to:
  /// **'آخر 30 يومًا'**
  String get last30Days;

  /// No description provided for @moodTrendTitle.
  ///
  /// In ar, this message translates to:
  /// **'المزاج'**
  String get moodTrendTitle;

  /// No description provided for @noDataYetLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات بعد — ابدئي بالتسجيل لرؤية اتجاهاتك.'**
  String get noDataYetLabel;

  /// No description provided for @medicationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأدوية'**
  String get medicationsTitle;

  /// No description provided for @addMedicationHint.
  ///
  /// In ar, this message translates to:
  /// **'أضيفي دواءً...'**
  String get addMedicationHint;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @noMedicationsAdded.
  ///
  /// In ar, this message translates to:
  /// **'لم تتم إضافة أدوية لهذا اليوم.'**
  String get noMedicationsAdded;

  /// No description provided for @notRecorded.
  ///
  /// In ar, this message translates to:
  /// **'غير مسجلة'**
  String get notRecorded;

  /// No description provided for @weightTitle.
  ///
  /// In ar, this message translates to:
  /// **'الوزن'**
  String get weightTitle;

  /// No description provided for @exportData.
  ///
  /// In ar, this message translates to:
  /// **'تصدير البيانات'**
  String get exportData;

  /// No description provided for @exportDataDesc.
  ///
  /// In ar, this message translates to:
  /// **'تحميل سجل يومياتك الكامل بصيغة CSV.'**
  String get exportDataDesc;

  /// No description provided for @exportNoData.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديكِ سجلات لتصديرها بعد.'**
  String get exportNoData;

  /// No description provided for @exportReady.
  ///
  /// In ar, this message translates to:
  /// **'تصديرك جاهز.'**
  String get exportReady;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج؟'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmDesc.
  ///
  /// In ar, this message translates to:
  /// **'ستعودين إلى شاشة الترحيب. تبقى بياناتك على هذا الجهاز.'**
  String get logoutConfirmDesc;

  /// No description provided for @aiChatEmptyState.
  ///
  /// In ar, this message translates to:
  /// **'اسأليني أي شيء عن دورتك، أعراضك، مزاجك، نومك أو ترطيبك.'**
  String get aiChatEmptyState;

  /// No description provided for @aiChatInputHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتبي رسالتك...'**
  String get aiChatInputHint;

  /// No description provided for @aiChatMissingKey.
  ///
  /// In ar, this message translates to:
  /// **'مدرب الذكاء الاصطناعي غير مُعد بعد. مفتاح API مفقود.'**
  String get aiChatMissingKey;

  /// No description provided for @aiChatNetworkError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر الوصول إلى مدرب الذكاء الاصطناعي. تحققي من اتصالك وحاولي مرة أخرى.'**
  String get aiChatNetworkError;

  /// No description provided for @aiChatGenericError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما. يرجى المحاولة مرة أخرى.'**
  String get aiChatGenericError;

  /// No description provided for @aiFreeMessagesLeft.
  ///
  /// In ar, this message translates to:
  /// **'{count} {count, plural, one {رسالة مجانية متبقية} other {رسائل مجانية متبقية}} اليوم'**
  String aiFreeMessagesLeft(int count);

  /// No description provided for @aiFreeLimitReachedTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم بلوغ الحد المجاني اليومي'**
  String get aiFreeLimitReachedTitle;

  /// No description provided for @aiFreeLimitReachedDesc.
  ///
  /// In ar, this message translates to:
  /// **'لقد استخدمتِ رسائلك المجانية الثلاث لهذا اليوم. اشتركي في بريميوم لمحادثات غير محدودة، أو عودي غدًا.'**
  String get aiFreeLimitReachedDesc;

  /// No description provided for @emailAuthSignUpTitle.
  ///
  /// In ar, this message translates to:
  /// **'أنشئي حسابك'**
  String get emailAuthSignUpTitle;

  /// No description provided for @emailAuthSignInTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بعودتك'**
  String get emailAuthSignInTitle;

  /// No description provided for @emailLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get passwordLabel;

  /// No description provided for @signUpButton.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get signUpButton;

  /// No description provided for @signInButton.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signInButton;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @passwordResetSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط إعادة تعيين كلمة المرور. تحققي من بريدك الإلكتروني.'**
  String get passwordResetSent;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In ar, this message translates to:
  /// **'يبدو أن هذا البريد الإلكتروني غير صالح.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد حساب بهذا البريد الإلكتروني.'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني أو كلمة المرور غير صحيحة.'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In ar, this message translates to:
  /// **'يوجد حساب بالفعل بهذا البريد الإلكتروني.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorGeneric.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما. يرجى المحاولة مرة أخرى.'**
  String get authErrorGeneric;

  /// No description provided for @appleSignInComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول عبر Apple سيتوفر قريبًا.'**
  String get appleSignInComingSoon;

  /// No description provided for @switchToSignIn.
  ///
  /// In ar, this message translates to:
  /// **'لديكِ حساب بالفعل؟ سجّلي الدخول'**
  String get switchToSignIn;

  /// No description provided for @switchToSignUp.
  ///
  /// In ar, this message translates to:
  /// **'جديدة هنا؟ أنشئي حسابًا'**
  String get switchToSignUp;

  /// No description provided for @symptomCheckerScreenTitle.
  ///
  /// In ar, this message translates to:
  /// **'فاحص الأعراض'**
  String get symptomCheckerScreenTitle;

  /// No description provided for @selectSymptomsPrompt.
  ///
  /// In ar, this message translates to:
  /// **'اختاري ما تشعرين به اليوم'**
  String get selectSymptomsPrompt;

  /// No description provided for @analyzeSymptoms.
  ///
  /// In ar, this message translates to:
  /// **'تحليل'**
  String get analyzeSymptoms;

  /// No description provided for @symptomAnalysisTitle.
  ///
  /// In ar, this message translates to:
  /// **'ماذا قد يعني هذا'**
  String get symptomAnalysisTitle;

  /// No description provided for @noSymptomsSelected.
  ///
  /// In ar, this message translates to:
  /// **'اختاري عرضًا واحدًا على الأقل للتحليل.'**
  String get noSymptomsSelected;

  /// No description provided for @symptomNotesLabel.
  ///
  /// In ar, this message translates to:
  /// **'صفي المزيد (اختياري)'**
  String get symptomNotesLabel;

  /// No description provided for @symptomNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أضيفي أي تفاصيل إضافية عمّا تشعرين به...'**
  String get symptomNotesHint;

  /// No description provided for @symptomNotesPremiumLock.
  ///
  /// In ar, this message translates to:
  /// **'يمكن لأعضاء بريميوم إضافة ملاحظات مفصلة للحصول على تحليل أكثر تخصيصًا'**
  String get symptomNotesPremiumLock;

  /// No description provided for @articleFertilityBody.
  ///
  /// In ar, this message translates to:
  /// **'تتغير خصوبتك بشكل طبيعي على مدار دورتك. تعتمد فرص الحمل اليوم على المرحلة التي أنتِ فيها، إضافة إلى عوامل أخرى مثل النوم والتوتر وصحتك العامة.\n\nتتبع هذه التغيرات على مدى عدة دورات يساعد دورتي على تقديم توقعات أكثر دقة.'**
  String get articleFertilityBody;

  /// No description provided for @articleCrampsBody.
  ///
  /// In ar, this message translates to:
  /// **'تحدث التقلصات عندما ينقبض الرحم للتخلص من بطانته، والألم الخفيف أمر طبيعي تمامًا.\n\nيمكن أن يساعد الكمّاد الدافئ والتمدد الخفيف وشرب كمية كافية من الماء في تخفيف الانزعاج. إذا كانت التقلصات شديدة لدرجة تؤثر على حياتك اليومية، فمن الأفضل استشارة طبيب.'**
  String get articleCrampsBody;

  /// No description provided for @articleCycleBody.
  ///
  /// In ar, this message translates to:
  /// **'تمر دورتك بأربع مراحل: الحيض، الجريبية، التبويض، والأصفرية، وكل مرحلة تحكمها مستويات هرمونية مختلفة.\n\nفهم المرحلة التي أنتِ فيها يساعد على تفسير التغيرات في طاقتك ومزاجك وبشرتك. يمكن لمدرب دورتي الذكي مرافقتك لمعرفة ما تتوقعينه في كل مرحلة.'**
  String get articleCycleBody;

  /// No description provided for @learningBodyText.
  ///
  /// In ar, this message translates to:
  /// **'يتغير جسدك بطرق صغيرة ويمكن توقعها على مدار دورتك، من المستويات الهرمونية إلى درجة حرارة الجسم.\n\nتعلّم ملاحظة هذه الإشارات يساعدك على تنظيم أسبوعك، وفهم تقلبات مزاجك، واكتشاف أي أمر غير معتاد مبكرًا.'**
  String get learningBodyText;

  /// No description provided for @learningHabitsBody.
  ///
  /// In ar, this message translates to:
  /// **'العادات اليومية الصغيرة — الحركة المنتظمة، والوجبات المتوازنة، والنوم الثابت — يمكن أن تجعل دورتك أكثر سلاسة بشكل ملحوظ.\n\nلست بحاجة لتغيير روتينك بالكامل دفعة واحدة؛ فبضعة تغييرات ثابتة غالبًا ما يكون لها الأثر الأكبر مع الوقت.'**
  String get learningHabitsBody;

  /// No description provided for @learningHormonesBody.
  ///
  /// In ar, this message translates to:
  /// **'يرتفع هرمونا الإستروجين والبروجسترون وينخفضان على مدار دورتك، ويؤثران على شهيتك وجودة نومك وأكثر من ذلك.\n\nالتعرف على هذا الإيقاع يسهّل فهم سبب اختلاف بعض الأيام عن غيرها.'**
  String get learningHormonesBody;

  /// No description provided for @startOfCycleSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'في بداية دورتك'**
  String get startOfCycleSectionTitle;

  /// No description provided for @startArticle1Title.
  ///
  /// In ar, this message translates to:
  /// **'الإفرازات المهبلية: ما هو الطبيعي؟'**
  String get startArticle1Title;

  /// No description provided for @startArticle1Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 6 دقائق'**
  String get startArticle1Subtitle;

  /// No description provided for @startArticle1Body.
  ///
  /// In ar, this message translates to:
  /// **'يتغير لون وقوام الإفرازات على مدار الدورة، ومعظم هذه التغيرات طبيعية تمامًا — فهي طريقة جسدك لتنظيم نفسه.\n\nالإفرازات الصافية أو البيضاء شائعة حول فترة التبويض، وغالبًا ما تكون أخف مباشرة بعد الدورة. إذا لاحظتِ رائحة قوية أو لونًا غير معتاد أو انزعاجًا، فمن الأفضل مراجعة طبيبة.'**
  String get startArticle1Body;

  /// No description provided for @startArticle2Title.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكن أن أكون حاملاً؟'**
  String get startArticle2Title;

  /// No description provided for @startArticle2Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 5 دقائق'**
  String get startArticle2Subtitle;

  /// No description provided for @startArticle2Body.
  ///
  /// In ar, this message translates to:
  /// **'قد تشمل علامات الحمل المبكرة تأخر الدورة، وحساسية الثدي، والتعب، والغثيان — لكنها قد تتشابه مع أعراض ما قبل الدورة المعتادة، مما يجعلها سهلة التجاهل.\n\nاختبار الحمل المنزلي يكون أكثر دقة بعد أيام قليلة من تأخر الدورة. إذا تأخرت دورتك ولم تكوني متأكدة، فإجراء الاختبار هو أوضح طريقة لمعرفة ذلك.'**
  String get startArticle2Body;

  /// No description provided for @startArticle3Title.
  ///
  /// In ar, this message translates to:
  /// **'تخفيف ألم الدورة بشكل طبيعي'**
  String get startArticle3Title;

  /// No description provided for @startArticle3Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 5 دقائق'**
  String get startArticle3Subtitle;

  /// No description provided for @startArticle3Body.
  ///
  /// In ar, this message translates to:
  /// **'يمكن أن يساعد الكمّاد الدافئ على أسفل البطن، والحركة الخفيفة مثل المشي أو التمدد، وشرب كمية كافية من الماء في تخفيف ألم الدورة.\n\nتُعد المشروبات العشبية مثل الزنجبيل أو البابونج خيارات لطيفة يجدها كثيرات مريحة. إذا كان الألم شديدًا أو لم يتحسن، فتحدثي مع مقدم رعاية صحية.'**
  String get startArticle3Body;

  /// No description provided for @liveBetterSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'لتعيشي دورتك بشكل أفضل'**
  String get liveBetterSectionTitle;

  /// No description provided for @liveArticle1Title.
  ///
  /// In ar, this message translates to:
  /// **'حساسية الثدي: ما الذي يساعد'**
  String get liveArticle1Title;

  /// No description provided for @liveArticle1Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 4 دقائق'**
  String get liveArticle1Subtitle;

  /// No description provided for @liveArticle1Body.
  ///
  /// In ar, this message translates to:
  /// **'تحدث حساسية الثدي قبل الدورة بسبب التغيرات الهرمونية، وعادة ما تختفي مع بداية الدورة.\n\nيمكن أن تساعد حمالة صدر داعمة ومناسبة، وتقليل الكافيين والملح، والدفء الخفيف في تخفيف الانزعاج. غالبًا لا يكون الأمر مقلقًا إلا إذا كان شديدًا أو مستمرًا.'**
  String get liveArticle1Body;

  /// No description provided for @liveArticle2Title.
  ///
  /// In ar, this message translates to:
  /// **'تخفيف الانتفاخ'**
  String get liveArticle2Title;

  /// No description provided for @liveArticle2Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 5 دقائق'**
  String get liveArticle2Subtitle;

  /// No description provided for @liveArticle2Body.
  ///
  /// In ar, this message translates to:
  /// **'ينتج الانتفاخ المرتبط بالدورة عن تغيرات هرمونية تجعل الجسم يحتفظ بكمية أكبر من الماء والملح.\n\nشرب كمية وفيرة من الماء، وتقليل الأطعمة المالحة، والحركة الخفيفة يمكن أن تساعد في تقليل الانتفاخ. عادة ما يخف الأمر تلقائيًا خلال أيام قليلة.'**
  String get liveArticle2Body;

  /// No description provided for @liveArticle3Title.
  ///
  /// In ar, this message translates to:
  /// **'نوم أفضل خلال الدورة'**
  String get liveArticle3Title;

  /// No description provided for @liveArticle3Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'قراءة 6 دقائق'**
  String get liveArticle3Subtitle;

  /// No description provided for @liveArticle3Body.
  ///
  /// In ar, this message translates to:
  /// **'قد تجعل التغيرات الهرمونية والتقلصات النوم أكثر صعوبة خلال الدورة.\n\nالحفاظ على برودة الغرفة، وتجنب الشاشات قبل النوم، واستخدام كمّاد دافئ للتقلصات يمكن أن يحسّن جودة نومك. موعد نوم ثابت يساعد جسدك على التكيف بسهولة أكبر طوال الدورة.'**
  String get liveArticle3Body;

  /// No description provided for @articlesHubTitle.
  ///
  /// In ar, this message translates to:
  /// **'المقالات'**
  String get articlesHubTitle;

  /// No description provided for @articlesHubSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'كل ما تعرفه دورتي، منظّم في مكان واحد'**
  String get articlesHubSubtitle;

  /// No description provided for @browseAllArticles.
  ///
  /// In ar, this message translates to:
  /// **'تصفحي جميع المقالات'**
  String get browseAllArticles;

  /// No description provided for @nutritionCoachTitle.
  ///
  /// In ar, this message translates to:
  /// **'مساعدة التغذية'**
  String get nutritionCoachTitle;

  /// No description provided for @nutritionCoachStarterMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا! أنا مساعدتك الغذائية. لحساب احتياجك اليومي من السعرات الحرارية، أخبريني بعمرك ووزنك وطولك ومستوى نشاطك وهدفك (خسارة الوزن، الحفاظ عليه، أو زيادته).'**
  String get nutritionCoachStarterMessage;

  /// No description provided for @sleepCoachTitle.
  ///
  /// In ar, this message translates to:
  /// **'مساعدة النوم'**
  String get sleepCoachTitle;

  /// No description provided for @sleepCoachStarterMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا! أنا مساعدتك للنوم. أخبريني بما يحدث مع نومك — صعوبة في النوم، استيقاظ أثناء الليل، أو شعور بالتعب — وسأساعدك في إيجاد طرق للنوم بشكل أفضل.'**
  String get sleepCoachStarterMessage;

  /// No description provided for @premiumOnlyFeatureTitle.
  ///
  /// In ar, this message translates to:
  /// **'ميزة بريميوم'**
  String get premiumOnlyFeatureTitle;

  /// No description provided for @premiumOnlyFeatureDesc.
  ///
  /// In ar, this message translates to:
  /// **'هذه المحادثة متاحة حصريًا لأعضاء بريميوم. اشتركي في بريميوم لفتحها.'**
  String get premiumOnlyFeatureDesc;

  /// No description provided for @settingsPartner.
  ///
  /// In ar, this message translates to:
  /// **'وضع الشريك'**
  String get settingsPartner;

  /// No description provided for @settingsPartnerDesc.
  ///
  /// In ar, this message translates to:
  /// **'شاركي رمزًا ليتابع شريكك دورتك ومزاجك'**
  String get settingsPartnerDesc;

  /// No description provided for @partnerEntryLink.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت شريك؟ أدخل رمزك'**
  String get partnerEntryLink;

  /// No description provided for @partnerEntryTitle.
  ///
  /// In ar, this message translates to:
  /// **'الاتصال كشريك'**
  String get partnerEntryTitle;

  /// No description provided for @partnerEntrySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز الذي شاركته شريكتك لمتابعة دورتها.'**
  String get partnerEntrySubtitle;

  /// No description provided for @partnerCodeHint.
  ///
  /// In ar, this message translates to:
  /// **'الرمز'**
  String get partnerCodeHint;

  /// No description provided for @partnerConnectButton.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get partnerConnectButton;

  /// No description provided for @partnerCodeInvalid.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرمز غير صحيح. تحقق منه مع شريكتك وحاول مرة أخرى.'**
  String get partnerCodeInvalid;

  /// No description provided for @partnerDashboardTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتها'**
  String get partnerDashboardTitle;

  /// No description provided for @partnerDashboardSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'عرض مشترك للقراءة فقط'**
  String get partnerDashboardSubtitle;

  /// No description provided for @partnerDisconnect.
  ///
  /// In ar, this message translates to:
  /// **'قطع الاتصال'**
  String get partnerDisconnect;

  /// No description provided for @partnerNoDataYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات مشتركة بعد. تحقق قريبًا.'**
  String get partnerNoDataYet;

  /// No description provided for @partnerCurrentPhase.
  ///
  /// In ar, this message translates to:
  /// **'المرحلة الحالية'**
  String get partnerCurrentPhase;

  /// No description provided for @partnerTipMenstruation.
  ///
  /// In ar, this message translates to:
  /// **'قد تشعر بألم أو تعب أكبر اليوم. كن لطيفًا ومتفهمًا لحاجتها إلى الراحة.'**
  String get partnerTipMenstruation;

  /// No description provided for @partnerTipFollicular.
  ///
  /// In ar, this message translates to:
  /// **'طاقتها ترتفع تدريجيًا هذه الأيام — وقت جيد لخطط معًا.'**
  String get partnerTipFollicular;

  /// No description provided for @partnerTipOvulation.
  ///
  /// In ar, this message translates to:
  /// **'هي في فترة خصوبتها. غالبًا ما يكون مزاجها ونشاطها في أفضل حالاتهما.'**
  String get partnerTipOvulation;

  /// No description provided for @partnerTipLuteal.
  ///
  /// In ar, this message translates to:
  /// **'قد تشعر بتقلبات مزاجية أو انتفاخ. القليل من الصبر والدعم الإضافي يصنع فرقًا كبيرًا.'**
  String get partnerTipLuteal;

  /// No description provided for @partnerPremiumLockTitle.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل الكاملة لأعضاء بريميوم'**
  String get partnerPremiumLockTitle;

  /// No description provided for @partnerPremiumLockDesc.
  ///
  /// In ar, this message translates to:
  /// **'اطلب منها الاشتراك في بريميوم لفتح يوم دورتها الدقيق، والمواعيد القادمة، ومزاجها، وإحصائياتها اليومية.'**
  String get partnerPremiumLockDesc;

  /// No description provided for @partnerCycleDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم الدورة'**
  String get partnerCycleDay;

  /// No description provided for @partnerMood.
  ///
  /// In ar, this message translates to:
  /// **'المزاج'**
  String get partnerMood;

  /// No description provided for @partnerWater.
  ///
  /// In ar, this message translates to:
  /// **'الماء'**
  String get partnerWater;

  /// No description provided for @partnerSleep.
  ///
  /// In ar, this message translates to:
  /// **'النوم'**
  String get partnerSleep;

  /// No description provided for @partnerNextPeriod.
  ///
  /// In ar, this message translates to:
  /// **'الدورة القادمة'**
  String get partnerNextPeriod;

  /// No description provided for @partnerNextOvulation.
  ///
  /// In ar, this message translates to:
  /// **'التبويض القادم'**
  String get partnerNextOvulation;

  /// No description provided for @partnerCalendarTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتها هذا الشهر'**
  String get partnerCalendarTitle;

  /// No description provided for @partnerCodeScreenTitle.
  ///
  /// In ar, this message translates to:
  /// **'رمز الشريك الخاص بك'**
  String get partnerCodeScreenTitle;

  /// No description provided for @partnerCodeScreenSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'شاركي هذا الرمز مع شريكك ليتمكن من متابعة دورتك من هاتفه الخاص — دون الحاجة لإنشاء حساب من جانبه.'**
  String get partnerCodeScreenSubtitle;

  /// No description provided for @partnerCodeUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'سجّلي الدخول إلى حسابك للحصول على رمز شريك.'**
  String get partnerCodeUnavailable;

  /// No description provided for @partnerShareCode.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة الرمز'**
  String get partnerShareCode;

  /// No description provided for @partnerShareMessage.
  ///
  /// In ar, this message translates to:
  /// **'تابع دورتي على دورتي — افتح التطبيق واضغط على \"هل أنت شريك؟\" وأدخل هذا الرمز: {code}'**
  String partnerShareMessage(String code);

  /// No description provided for @relationshipCoachTitle.
  ///
  /// In ar, this message translates to:
  /// **'مساعدة العلاقة'**
  String get relationshipCoachTitle;

  /// No description provided for @relationshipCoachStarterMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا! أنا هنا لمساعدتك على التواصل بشكل أفضل مع شريكك. هل تريدين نصائح لشرح ما تشعرين به اليوم، أو طرقًا للبقاء متقاربين خلال مختلف مراحل دورتك؟'**
  String get relationshipCoachStarterMessage;

  /// No description provided for @cycleBasedOnHistory.
  ///
  /// In ar, this message translates to:
  /// **'بناءً على آخر {count} دورات سجلتِها، تتوقع دورتي دورة مدتها {days} يومًا وحيضًا لمدة {periodDays} أيام — يتحدّث هذا تلقائيًا كلما سجّلتِ المزيد.'**
  String cycleBasedOnHistory(int count, int days, int periodDays);

  /// No description provided for @cycleBasedOnEstimate.
  ///
  /// In ar, this message translates to:
  /// **'تستخدم دورتي حاليًا تقديرك لدورة مدتها {days} يومًا. سجّلي بضع دورات وستصبح التوقعات أكثر دقة تلقائيًا.'**
  String cycleBasedOnEstimate(int days);

  /// No description provided for @cycleIrregularWarningTitle.
  ///
  /// In ar, this message translates to:
  /// **'دورتك تفاوتت كثيرًا مؤخرًا'**
  String get cycleIrregularWarningTitle;

  /// No description provided for @cycleIrregularWarningDesc.
  ///
  /// In ar, this message translates to:
  /// **'اختلفت مدة دوراتك الأخيرة بأكثر من أسبوع. هذا ليس تشخيصًا، لكن قد يستحق ذكره لطبيبتك.'**
  String get cycleIrregularWarningDesc;

  /// No description provided for @exportCsvOption.
  ///
  /// In ar, this message translates to:
  /// **'تصدير البيانات الخام (CSV)'**
  String get exportCsvOption;

  /// No description provided for @exportDoctorSummary.
  ///
  /// In ar, this message translates to:
  /// **'تصدير ملخص لطبيبتي'**
  String get exportDoctorSummary;

  /// No description provided for @exportChooseFormat.
  ///
  /// In ar, this message translates to:
  /// **'اختاري صيغة التصدير'**
  String get exportChooseFormat;

  /// No description provided for @settingsAppLock.
  ///
  /// In ar, this message translates to:
  /// **'قفل التطبيق'**
  String get settingsAppLock;

  /// No description provided for @settingsAppLockDescOn.
  ///
  /// In ar, this message translates to:
  /// **'رمز PIN مفعّل'**
  String get settingsAppLockDescOn;

  /// No description provided for @settingsAppLockDescOff.
  ///
  /// In ar, this message translates to:
  /// **'معطّل'**
  String get settingsAppLockDescOff;

  /// No description provided for @appLockEnterPin.
  ///
  /// In ar, this message translates to:
  /// **'أدخلي رمز PIN'**
  String get appLockEnterPin;

  /// No description provided for @appLockWrongPin.
  ///
  /// In ar, this message translates to:
  /// **'رمز PIN غير صحيح'**
  String get appLockWrongPin;

  /// No description provided for @appLockCreatePin.
  ///
  /// In ar, this message translates to:
  /// **'أنشئي رمز PIN'**
  String get appLockCreatePin;

  /// No description provided for @appLockConfirmPin.
  ///
  /// In ar, this message translates to:
  /// **'أكّدي رمز PIN'**
  String get appLockConfirmPin;

  /// No description provided for @appLockPinMismatch.
  ///
  /// In ar, this message translates to:
  /// **'الرمزان غير متطابقين، حاولي مجددًا'**
  String get appLockPinMismatch;

  /// No description provided for @appLockUseBiometrics.
  ///
  /// In ar, this message translates to:
  /// **'استخدام بصمة الوجه/الإصبع'**
  String get appLockUseBiometrics;

  /// No description provided for @appLockUseBiometricsDesc.
  ///
  /// In ar, this message translates to:
  /// **'افتحي التطبيق ببصمتك أو وجهك بدلاً من كتابة رمز PIN.'**
  String get appLockUseBiometricsDesc;

  /// No description provided for @appLockEnable.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل قفل التطبيق'**
  String get appLockEnable;

  /// No description provided for @appLockEnableDesc.
  ///
  /// In ar, this message translates to:
  /// **'طلب رمز PIN لفتح التطبيق.'**
  String get appLockEnableDesc;

  /// No description provided for @appLockDisable.
  ///
  /// In ar, this message translates to:
  /// **'تعطيل قفل التطبيق'**
  String get appLockDisable;

  /// No description provided for @appLockDisableConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعطيل قفل التطبيق؟'**
  String get appLockDisableConfirmTitle;

  /// No description provided for @appLockDisableConfirmDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتمكن أي شخص لديه هاتفك من فتح دورتي بدون رمز PIN.'**
  String get appLockDisableConfirmDesc;

  /// No description provided for @appLockChangePin.
  ///
  /// In ar, this message translates to:
  /// **'تغيير رمز PIN'**
  String get appLockChangePin;

  /// No description provided for @appLockBiometricsUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'البصمة الحيوية غير متاحة على هذا الجهاز.'**
  String get appLockBiometricsUnavailable;

  /// No description provided for @settingsReferral.
  ///
  /// In ar, this message translates to:
  /// **'دعوة صديقات'**
  String get settingsReferral;

  /// No description provided for @settingsReferralDesc.
  ///
  /// In ar, this message translates to:
  /// **'قدّمي بريميوم واحصلي على بريميوم'**
  String get settingsReferralDesc;

  /// No description provided for @referralTitle.
  ///
  /// In ar, this message translates to:
  /// **'دعوة صديقات'**
  String get referralTitle;

  /// No description provided for @referralSignInRequired.
  ///
  /// In ar, this message translates to:
  /// **'سجّلي الدخول للحصول على رمز الدعوة الخاص بك والبدء في كسب أيام بريميوم مجانية.'**
  String get referralSignInRequired;

  /// No description provided for @referralInviteTitle.
  ///
  /// In ar, this message translates to:
  /// **'ادعي صديقة واحصلي على بريميوم'**
  String get referralInviteTitle;

  /// No description provided for @referralInviteDesc.
  ///
  /// In ar, this message translates to:
  /// **'شاركي رمزك. عندما تستخدمه صديقتك، تحصلان كلتاكما على {days} أيام من بريميوم — مجانًا.'**
  String referralInviteDesc(int days);

  /// No description provided for @referralShareButton.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة رمزي'**
  String get referralShareButton;

  /// No description provided for @referralShareMessage.
  ///
  /// In ar, this message translates to:
  /// **'انضمي إليّ في دورتي! استخدمي رمزي {code} عند التسجيل ونحصل كلتانا على {days} أيام من بريميوم مجانًا.'**
  String referralShareMessage(String code, int days);

  /// No description provided for @referralRedeemTitle.
  ///
  /// In ar, this message translates to:
  /// **'لديك رمز صديقة؟'**
  String get referralRedeemTitle;

  /// No description provided for @referralCodeHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخلي الرمز'**
  String get referralCodeHint;

  /// No description provided for @referralRedeemButton.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل'**
  String get referralRedeemButton;

  /// No description provided for @referralCannotUseOwnCode.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكنك استخدام رمزك الخاص.'**
  String get referralCannotUseOwnCode;

  /// No description provided for @referralInvalidCode.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرمز غير موجود. تحققي وحاولي مجددًا.'**
  String get referralInvalidCode;

  /// No description provided for @referralRedeemSuccess.
  ///
  /// In ar, this message translates to:
  /// **'رائع! حصلتِ للتو على {days} أيام من بريميوم.'**
  String referralRedeemSuccess(int days);

  /// No description provided for @referralAlreadyRedeemed.
  ///
  /// In ar, this message translates to:
  /// **'لقد استخدمتِ رمز دعوة من قبل.'**
  String get referralAlreadyRedeemed;

  /// No description provided for @symptomInsightTitle.
  ///
  /// In ar, this message translates to:
  /// **'لاحظنا نمطًا'**
  String get symptomInsightTitle;

  /// No description provided for @symptomInsightText.
  ///
  /// In ar, this message translates to:
  /// **'غالبًا ما تسجّلين {symptom} خلال مرحلة {phase}.'**
  String symptomInsightText(String symptom, String phase);

  /// No description provided for @symptomInsightLockedText.
  ///
  /// In ar, this message translates to:
  /// **'لاحظنا نمطًا في أعراضك. افتحي بريميوم لرؤيته.'**
  String get symptomInsightLockedText;

  /// No description provided for @notifPillReminder.
  ///
  /// In ar, this message translates to:
  /// **'تذكير بحبوب منع الحمل'**
  String get notifPillReminder;

  /// No description provided for @notifPillReminderDesc.
  ///
  /// In ar, this message translates to:
  /// **'تذكير يومي لتناول حبوب منع الحمل'**
  String get notifPillReminderDesc;

  /// No description provided for @pillReminderNotifTitle.
  ///
  /// In ar, this message translates to:
  /// **'حان وقت الحبة'**
  String get pillReminderNotifTitle;

  /// No description provided for @pillReminderNotifBody.
  ///
  /// In ar, this message translates to:
  /// **'لا تنسي تناول حبة منع الحمل اليوم.'**
  String get pillReminderNotifBody;

  /// No description provided for @exportIcsOption.
  ///
  /// In ar, this message translates to:
  /// **'تصدير إلى التقويم (.ics)'**
  String get exportIcsOption;

  /// No description provided for @streakBannerText.
  ///
  /// In ar, this message translates to:
  /// **'{days} أيام متتالية'**
  String streakBannerText(int days);

  /// No description provided for @settingsWidget.
  ///
  /// In ar, this message translates to:
  /// **'أداة الشاشة الرئيسية'**
  String get settingsWidget;

  /// No description provided for @settingsWidgetDesc.
  ///
  /// In ar, this message translates to:
  /// **'شاهدي يوم دورتك بلمحة واحدة'**
  String get settingsWidgetDesc;

  /// No description provided for @widgetPinUnsupported.
  ///
  /// In ar, this message translates to:
  /// **'جهازك لا يدعم إضافة الأدوات بهذه الطريقة — جربي الضغط المطول على شاشتك الرئيسية بدلاً من ذلك.'**
  String get widgetPinUnsupported;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
