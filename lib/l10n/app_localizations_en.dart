// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dawrati';

  @override
  String get appTagline => 'Women\'s Health';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get chooseLanguageTitle => 'Choose your language';

  @override
  String get onboardTitle1 => 'Know Your Cycle';

  @override
  String get onboardDesc1 =>
      'Understand your period, ovulation and fertile window.';

  @override
  String get onboardTitle2 => 'Predict Your Period';

  @override
  String get onboardDesc2 => 'Get smart predictions for your next cycle.';

  @override
  String get onboardTitle3 => 'Track Symptoms';

  @override
  String get onboardDesc3 => 'Log mood, pain, sleep, water and daily symptoms.';

  @override
  String get onboardTitle4 => 'Dawrati AI';

  @override
  String get onboardDesc4 => 'Receive personalized insights every day.';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeTitle => 'Welcome to\nDawrati';

  @override
  String get welcomeSubtitle =>
      'Track your cycle, understand your body and receive personalized AI insights.';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithEmail => 'Continue with Email';

  @override
  String get continueWithoutAccount => 'Continue without an account';

  @override
  String get alreadyHaveAccount => 'I already have an account';

  @override
  String get qAge => 'How old are you?';

  @override
  String get qLastPeriod => 'When did your last period start?';

  @override
  String get qPeriodLength => 'How long do your periods last?';

  @override
  String get qCycleLength => 'Average cycle length';

  @override
  String get qGoal => 'Why are you using Dawrati?';

  @override
  String get goalTrackCycle => 'Track my cycle';

  @override
  String get goalGetPregnant => 'Get pregnant';

  @override
  String get goalAvoidPregnancy => 'Avoid pregnancy';

  @override
  String get goalUnderstandHealth => 'Understand my health';

  @override
  String get qContraception => 'Do you use contraception?';

  @override
  String get contraceptionNone => 'None';

  @override
  String get contraceptionPill => 'Pill';

  @override
  String get contraceptionIUD => 'IUD';

  @override
  String get contraceptionImplant => 'Implant';

  @override
  String get contraceptionOther => 'Other';

  @override
  String get qStress => 'Stress level';

  @override
  String get stressLow => 'Low';

  @override
  String get stressMedium => 'Medium';

  @override
  String get stressHigh => 'High';

  @override
  String get qSleep => 'Sleep duration';

  @override
  String get sleepLess6 => 'Less than 6h';

  @override
  String get sleep6to8 => '6–8h';

  @override
  String get sleepMore8 => 'More than 8h';

  @override
  String get qWeight => 'What is your weight?';

  @override
  String get selectDate => 'Select date';

  @override
  String get back => 'Back';

  @override
  String get continueLabel => 'Continue';

  @override
  String get goHome => 'Go Home';

  @override
  String get profileReadyTitle => 'Your profile is ready';

  @override
  String get profileReadyDesc =>
      'Dawrati can now personalize your cycle predictions.';

  @override
  String get navHome => 'Home';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navLog => 'Log';

  @override
  String get navInsights => 'Insights';

  @override
  String get navArticles => 'Articles';

  @override
  String get navProfile => 'Profile';

  @override
  String get profileTitle => 'Profile';

  @override
  String get freePlan => 'Dawrati Free Plan';

  @override
  String get cycleLabel => 'Cycle';

  @override
  String dayLabel(int day) {
    return 'Day $day';
  }

  @override
  String get phaseLabel => 'Phase';

  @override
  String get waterLabel => 'Water';

  @override
  String get sleepLabel => 'Sleep';

  @override
  String get premiumTitle => 'Dawrati Premium';

  @override
  String get premiumSubtitle => 'Unlock AI coach and advanced insights.';

  @override
  String get premiumPlanLabel => 'Dawrati Premium Plan';

  @override
  String get premiumActiveTitle => 'Premium is active';

  @override
  String get premiumActiveDesc =>
      'You have full access to every feature. Thank you!';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Appearance';

  @override
  String get chooseThemeTitle => 'Choose appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc => 'Cycle reminders';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyDesc => 'Manage your data';

  @override
  String get settingsCycle => 'Cycle Settings';

  @override
  String get settingsCycleDesc => '28-day cycle';

  @override
  String get settingsHelp => 'Help & Support';

  @override
  String get settingsHelpDesc => 'Contact us';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get settingsLogoutDesc => 'Sign out from Dawrati';

  @override
  String get todaysJourney => 'Today\'s Journey';

  @override
  String get moodLabel => 'Mood';

  @override
  String get activityLabel => 'Activity';

  @override
  String get homeLogPeriod => 'Log period';

  @override
  String get homeSymptoms => 'Symptoms';

  @override
  String get homeSex => 'Relationship';

  @override
  String get ovulationToday => 'Ovulation today';

  @override
  String get ovulationIn => 'Ovulation in';

  @override
  String get todayLabel => 'Today';

  @override
  String daysCount(int count) {
    return '$count days';
  }

  @override
  String get highChancePregnancy => 'High chance of pregnancy';

  @override
  String get fertilityIncreasing => 'Fertility is increasing';

  @override
  String get lowChancePregnancy => 'Low chance of getting pregnant';

  @override
  String get seeDailyInsights => 'See your daily insights';

  @override
  String get todaysArticles => 'Today\'s Articles';

  @override
  String get articleFertilityTitle => 'Your fertility today';

  @override
  String get articleFertilitySubtitle => 'Updated now';

  @override
  String get articleCrampsTitle => 'How to relieve cramps';

  @override
  String get articleCrampsSubtitle => '5 min read';

  @override
  String get articleCycleTitle => 'Understand your cycle';

  @override
  String get dawratiAiLabel => 'Dawrati AI';

  @override
  String get symptomCheckerTitle => 'Symptom Checker';

  @override
  String get seeAll => 'See all';

  @override
  String get symptomTrackText =>
      'Track unusual symptoms and learn when they may need attention.';

  @override
  String get symptomHelpText =>
      'Dawrati can help you understand patterns in your cycle, mood, sleep and symptoms.';

  @override
  String get quickSelfCheck => 'Quick self-check';

  @override
  String minutesReadLabel(int count) {
    return '$count min';
  }

  @override
  String get checkMySymptoms => 'Check my symptoms';

  @override
  String get notDiagnosisTool => 'Note: Dawrati is not a diagnosis tool.';

  @override
  String get basedOnCycle => 'Based on your current cycle';

  @override
  String get learningBodyTitle => 'Understanding your body';

  @override
  String get learningHabitsTitle => 'Healthy habits';

  @override
  String get learningHormonesTitle => 'Hormones explained';

  @override
  String get seeMore => 'See more';

  @override
  String get recommendedForYou => 'Recommended for you';

  @override
  String get aiRecommendationText =>
      'Your energy may decrease over the next 2 days. Prioritize sleep and hydration.';

  @override
  String get nutritionLabel => 'Nutrition';

  @override
  String get nutritionRecommendationText =>
      'Foods rich in iron can help support your body during this phase.';

  @override
  String get sleepRecommendationText =>
      'Going to bed 30 minutes earlier may improve your recovery.';

  @override
  String get myCycleTitle => 'My Cycle';

  @override
  String get currentDay => 'Current day';

  @override
  String get currentPhase => 'Current phase';

  @override
  String get averageCycle => 'Average cycle';

  @override
  String get averagePeriodLength => 'Period length';

  @override
  String get logsSaved => 'Logs saved';

  @override
  String get aiCoachCardTitle => 'Dawrati AI Coach';

  @override
  String get aiCoachCardSubtitle =>
      'Ask your cycle assistant for daily guidance.';

  @override
  String get premiumUnlockTextLong =>
      'Unlock AI coach, advanced insights and unlimited history.';

  @override
  String get tryPremium => 'Try Premium →';

  @override
  String get phaseMenstruation => 'Menstruation';

  @override
  String get phaseFollicular => 'Follicular';

  @override
  String get phaseOvulation => 'Ovulation';

  @override
  String get phaseLuteal => 'Luteal';

  @override
  String get fertilityPeak => 'Peak';

  @override
  String get fertilityHigh => 'High';

  @override
  String get fertilityMedium => 'Medium';

  @override
  String get fertilityLow => 'Low';

  @override
  String cycleDayLabel(int day) {
    return 'Cycle Day $day';
  }

  @override
  String get goodMorning => 'Good Morning 🌸';

  @override
  String get peakFertility => 'Peak fertility';

  @override
  String get highFertility => 'High fertility';

  @override
  String get lowFertility => 'Low fertility';

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendFertile => 'Fertile';

  @override
  String get legendSelected => 'Selected';

  @override
  String get chanceOfPregnancy => 'Chance of pregnancy';

  @override
  String get fertilityDescPeak =>
      'Ovulation is today. This is your peak fertile day.';

  @override
  String get fertilityDescHigh =>
      'You are in your fertile window. Pregnancy chance is higher.';

  @override
  String get fertilityDescMedium => 'Your fertile window is approaching soon.';

  @override
  String get fertilityDescLow =>
      'Low chance today. Fertile days are not active right now.';

  @override
  String get cycleTimelineTitle => 'Cycle Timeline';

  @override
  String get dailySummaryTitle => 'Daily Summary';

  @override
  String get noLogForDay =>
      'No log for this day. Add mood, water, sleep and symptoms.';

  @override
  String get noLogForDayShort => 'No log for this day';

  @override
  String get trackMoreDetails => 'Track symptoms, mood, sleep, water and more.';

  @override
  String get addDailyLog => 'Add Daily Log';

  @override
  String get setAsPeriodStart => 'Set as period start';

  @override
  String get notesLabel => 'Notes';

  @override
  String get cycleDayShort => 'Cycle day';

  @override
  String get currentPhaseShort => 'Current phase';

  @override
  String get dailyLogLabel => 'Daily Log';

  @override
  String get selectedDateLabel => 'Selected date';

  @override
  String logSavedForDate(String date) {
    return 'Log saved for $date';
  }

  @override
  String get howDoYouFeelToday => 'How do you feel today?';

  @override
  String get moodAmazing => 'Amazing';

  @override
  String get moodGood => 'Good';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodSad => 'Sad';

  @override
  String get moodAwful => 'Awful';

  @override
  String get symptomCramps => 'Cramps';

  @override
  String get symptomBloating => 'Bloating';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomBackPain => 'Back pain';

  @override
  String get symptomAcne => 'Acne';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get symptomBreastPain => 'Breast pain';

  @override
  String get periodFlowTitle => 'Period Flow';

  @override
  String get flowSpotting => 'Spotting';

  @override
  String get flowLight => 'Light';

  @override
  String get flowMedium => 'Medium';

  @override
  String get flowHeavy => 'Heavy';

  @override
  String get energyTitle => 'Energy';

  @override
  String get activityNone => 'None';

  @override
  String get activityWalk => 'Walk';

  @override
  String get activityRun => 'Run';

  @override
  String get activityGym => 'Gym';

  @override
  String get activityYoga => 'Yoga';

  @override
  String get notesHint => 'Write anything you want to remember...';

  @override
  String get saveLog => 'Save Log';

  @override
  String get todaysWellness => 'Today\'s Wellness';

  @override
  String get aiInsightSample =>
      'Based on today\'s mood, sleep and hydration, your body seems to be recovering well. Continue drinking water and prioritize good sleep tonight.';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get cycleOverview => 'Cycle Overview';

  @override
  String get last7Days => 'Last 7 days';

  @override
  String get hydrationTitle => 'Hydration';

  @override
  String get logsLabel => 'Logs';

  @override
  String aiInsightDynamicText(
    String phase,
    String water,
    String sleep,
    String mood,
  ) {
    return 'You are currently in the $phase. Your latest log shows ${water}L water, ${sleep}h sleep and mood: $mood.';
  }

  @override
  String get advancedInsights => 'Advanced Insights';

  @override
  String get advancedInsightsDesc =>
      'Unlock cycle trends, symptom patterns and AI health analysis.';

  @override
  String get premiumArrow => 'Premium →';

  @override
  String get personalAiCoach => 'Your Personal AI Coach';

  @override
  String get dailyGuidanceDesc =>
      'Daily guidance based on your cycle and your health logs.';

  @override
  String phaseDayCombo(String phase, int day) {
    return '$phase • Day $day';
  }

  @override
  String get todaysMood => 'Today\'s mood';

  @override
  String hydrationTodayValue(String value) {
    return '$value L today';
  }

  @override
  String sleepHoursValue(String value) {
    return '$value hours';
  }

  @override
  String get todaysAiInsight => 'Today\'s AI Insight';

  @override
  String get startAiConversation => 'Start AI Conversation';

  @override
  String get aiChatComingSoon =>
      'AI Chat will be available in the next version.';

  @override
  String get insightOvulation =>
      'You are likely in your most energetic phase. Stay hydrated and enjoy physical activity if you feel comfortable.';

  @override
  String get insightMenstruation =>
      'Your body may need more rest today. Prioritize sleep, hydration and iron-rich foods.';

  @override
  String get insightLowHydration =>
      'Your hydration is lower than recommended. Drinking more water may help reduce fatigue.';

  @override
  String get insightLowSleep =>
      'You slept less than recommended. A consistent bedtime may improve your energy tomorrow.';

  @override
  String get insightBalanced =>
      'Your recent health data looks balanced. Keep tracking daily to receive more personalized insights.';

  @override
  String get premiumAppBarTitle => 'Premium';

  @override
  String get unlockPremiumTitle => 'Unlock Dawrati Premium';

  @override
  String get unlockPremiumDesc =>
      'AI coach, advanced insights, unlimited history and smarter cycle predictions.';

  @override
  String get featureAiCoachDesc =>
      'Personal guidance based on your cycle and daily logs.';

  @override
  String get featureAdvancedInsightsDesc =>
      'Understand mood, sleep, hydration and cycle trends.';

  @override
  String get featureUnlimitedHistoryTitle => 'Unlimited History';

  @override
  String get featureUnlimitedHistoryDesc =>
      'Track patterns across months, not only recent days.';

  @override
  String get featureCloudBackupTitle => 'Cloud Backup';

  @override
  String get featureCloudBackupDesc =>
      'Keep your health data safe across devices.';

  @override
  String get monthlyLabel => 'Monthly';

  @override
  String get annualLabel => 'Annual';

  @override
  String get startPremium => 'Start Premium';

  @override
  String get premiumActivated => 'Premium activated';

  @override
  String get testingModeDisabled => 'Testing mode: payment is disabled.';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get billingUnavailable =>
      'In-app purchases aren\'t available on this device right now.';

  @override
  String get premiumKicker => 'Understand your body, one cycle at a time';

  @override
  String get premiumBestValueBadge => 'BEST VALUE';

  @override
  String premiumMonthlyEquivalent(String price) {
    return '~$price/month, billed yearly';
  }

  @override
  String premiumSavePercent(int percent) {
    return 'Save $percent%';
  }

  @override
  String get premiumTrustLine =>
      '🔒 Secure payment via Google Play · Cancel anytime';

  @override
  String get premiumFomoLine =>
      'Your body gives you signals every day — Premium helps you actually understand them.';

  @override
  String get notificationsSettingsTitle => 'Notifications';

  @override
  String get notificationsSettingsSubtitle =>
      'Choose which reminders you want to receive.';

  @override
  String get periodReminderTitle => 'Period reminder';

  @override
  String get periodReminderDesc =>
      'Get notified 2 days before your period is expected.';

  @override
  String get ovulationReminderTitle => 'Ovulation reminder';

  @override
  String get ovulationReminderDesc =>
      'Get notified on your predicted ovulation day.';

  @override
  String get waterReminderTitle => 'Water reminder';

  @override
  String get waterReminderDesc => 'A daily nudge to stay hydrated.';

  @override
  String get sleepReminderTitle => 'Sleep reminder';

  @override
  String get sleepReminderDesc => 'A gentle reminder to start winding down.';

  @override
  String get dailyLogReminderTitle => 'Daily log reminder';

  @override
  String get dailyLogReminderDesc => 'Don\'t forget to log your day.';

  @override
  String get reminderTimeLabel => 'Time';

  @override
  String get notificationPermissionDeniedMsg =>
      'Notifications are disabled. Enable them in your device settings to receive reminders.';

  @override
  String get periodReminderNotifTitle => 'Your period is coming';

  @override
  String get periodReminderNotifBody =>
      'Your period is expected in 2 days. Get ready!';

  @override
  String get ovulationReminderNotifTitle => 'Ovulation day';

  @override
  String get ovulationReminderNotifBody =>
      'Today is your predicted ovulation day.';

  @override
  String get waterReminderNotifTitle => 'Stay hydrated';

  @override
  String get waterReminderNotifBody => 'Time to drink some water.';

  @override
  String get sleepReminderNotifTitle => 'Wind down';

  @override
  String get sleepReminderNotifBody =>
      'It\'s almost bedtime. Get ready for a good night\'s sleep.';

  @override
  String get dailyLogReminderNotifTitle => 'Daily check-in';

  @override
  String get dailyLogReminderNotifBody =>
      'Don\'t forget to log your mood, symptoms and more today.';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get privacyIntro =>
      'Dawrati stores your data (cycle, daily logs, settings) on this device. If you\'re signed in, your data is also securely synced to our cloud servers for backup and cross-device sync. When you use AI features, relevant context is sent to our AI provider to generate responses.';

  @override
  String get privacyDataListTitle => 'What\'s stored on this device';

  @override
  String get privacyDataCycle => 'Your period start date and cycle history';

  @override
  String get privacyDataLogs =>
      'Your daily logs (mood, symptoms, water, sleep, notes)';

  @override
  String get privacyDataSettings =>
      'Your language, notification and subscription preferences';

  @override
  String get clearMyData => 'Clear my data';

  @override
  String get clearMyDataDesc =>
      'Permanently delete everything stored on this device and restart onboarding. If you\'re signed in, your cloud data remains saved unless you sign out.';

  @override
  String get clearDataConfirmTitle => 'Clear all data?';

  @override
  String get clearDataConfirmDesc =>
      'This cannot be undone. All your cycle history, logs and settings on this device will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get dataCleared => 'Your data has been cleared.';

  @override
  String get cycleSettingsTitle => 'Cycle Settings';

  @override
  String get periodStartDateLabel => 'Period start date';

  @override
  String get changeDate => 'Change date';

  @override
  String get cycleAssumptionsTitle => 'Current assumptions';

  @override
  String get cycleAssumptionsDesc =>
      'Dawrati currently predicts your cycle using a fixed 28-day cycle and a 5-day period. Custom cycle length is coming in a future update.';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get helpIntro =>
      'Have a question or found an issue? We\'re here to help.';

  @override
  String get helpContactEmail => 'Contact us';

  @override
  String get helpFaqTitle => 'Frequently asked questions';

  @override
  String get helpFaq1Q => 'How accurate are the cycle predictions?';

  @override
  String get helpFaq1A =>
      'Predictions are estimates based on a standard 28-day cycle and the period start date you provide. They improve as you log more data.';

  @override
  String get helpFaq2Q => 'Is my data private?';

  @override
  String get helpFaq2A =>
      'Yes. Your data is currently stored only on this device and is not shared with anyone.';

  @override
  String get helpFaq3Q => 'Can I export my data?';

  @override
  String get helpFaq3A => 'Data export is planned for a future update.';

  @override
  String get last30Days => 'Last 30 days';

  @override
  String get moodTrendTitle => 'Mood';

  @override
  String get noDataYetLabel =>
      'No data yet — start logging to see your trends.';

  @override
  String get medicationsTitle => 'Medications';

  @override
  String get addMedicationHint => 'Add a medication...';

  @override
  String get add => 'Add';

  @override
  String get noMedicationsAdded => 'No medications added for this day.';

  @override
  String get notRecorded => 'Not recorded';

  @override
  String get weightTitle => 'Weight';

  @override
  String get exportData => 'Export data';

  @override
  String get exportDataDesc => 'Download your full log history as a CSV file.';

  @override
  String get exportNoData => 'You don\'t have any logs to export yet.';

  @override
  String get exportReady => 'Your export is ready.';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmDesc =>
      'You\'ll return to the welcome screen. Your data stays on this device.';

  @override
  String get aiChatEmptyState =>
      'Ask me anything about your cycle, symptoms, mood, sleep or hydration.';

  @override
  String get aiChatInputHint => 'Type your message...';

  @override
  String get aiChatMissingKey => 'AI coach isn\'t set up yet. Missing API key.';

  @override
  String get aiChatNetworkError =>
      'Couldn\'t reach the AI coach. Check your connection and try again.';

  @override
  String get aiChatGenericError => 'Something went wrong. Please try again.';

  @override
  String aiFreeMessagesLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'messages',
      one: 'message',
    );
    return '$count free $_temp0 left today';
  }

  @override
  String get aiFreeLimitReachedTitle => 'Daily free limit reached';

  @override
  String get aiFreeLimitReachedDesc =>
      'You\'ve used your 3 free AI messages today. Upgrade to Premium for unlimited conversations, or come back tomorrow.';

  @override
  String get emailAuthSignUpTitle => 'Create your account';

  @override
  String get emailAuthSignInTitle => 'Welcome back';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get signInButton => 'Sign in';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get passwordResetSent =>
      'Password reset email sent. Check your inbox.';

  @override
  String get authErrorInvalidEmail => 'That email address looks invalid.';

  @override
  String get authErrorUserNotFound => 'No account found with that email.';

  @override
  String get authErrorWrongPassword => 'Incorrect email or password.';

  @override
  String get authErrorEmailInUse =>
      'An account already exists with that email.';

  @override
  String get authErrorWeakPassword =>
      'Password should be at least 6 characters.';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get appleSignInComingSoon => 'Sign in with Apple is coming soon.';

  @override
  String get switchToSignIn => 'Already have an account? Sign in';

  @override
  String get switchToSignUp => 'New here? Create an account';

  @override
  String get symptomCheckerScreenTitle => 'Symptom Checker';

  @override
  String get selectSymptomsPrompt => 'Select what you\'re experiencing today';

  @override
  String get analyzeSymptoms => 'Analyze';

  @override
  String get symptomAnalysisTitle => 'What this might mean';

  @override
  String get noSymptomsSelected => 'Select at least one symptom to analyze.';

  @override
  String get symptomNotesLabel => 'Describe more (optional)';

  @override
  String get symptomNotesHint => 'Add any extra detail about how you feel...';

  @override
  String get symptomNotesPremiumLock =>
      'Premium members can add detailed notes for a more personalized analysis';

  @override
  String get articleFertilityBody =>
      'Your fertility naturally rises and falls across your cycle. Today\'s chances of conceiving are shaped by where you are in that rhythm, alongside factors like sleep, stress and overall health.\n\nTracking these changes over a few cycles helps Dawrati give you more accurate predictions.';

  @override
  String get articleCrampsBody =>
      'Cramps happen when your uterus contracts to shed its lining, and mild pain is completely normal.\n\nA warm compress, gentle stretching, and staying hydrated can ease the discomfort. If cramps are severe enough to disrupt your daily life, it\'s worth talking to a doctor.';

  @override
  String get articleCycleBody =>
      'Your cycle moves through four phases: menstrual, follicular, ovulation and luteal, each driven by different hormone levels.\n\nUnderstanding which phase you\'re in can help explain shifts in your energy, mood and skin. Dawrati\'s AI coach can walk you through what to expect in each one.';

  @override
  String get learningBodyText =>
      'Your body changes in small, predictable ways throughout your cycle — from hormone levels to body temperature.\n\nLearning to notice these signals can help you plan your week, understand your mood swings, and catch anything unusual early.';

  @override
  String get learningHabitsBody =>
      'Small daily habits — regular movement, balanced meals, consistent sleep — can make your cycle noticeably smoother.\n\nYou don\'t need to overhaul your routine overnight; a few consistent changes tend to have the biggest impact over time.';

  @override
  String get learningHormonesBody =>
      'Estrogen and progesterone rise and fall throughout your cycle, influencing everything from your appetite to your sleep quality.\n\nGetting familiar with this rhythm makes it easier to understand why some days feel different from others.';

  @override
  String get startOfCycleSectionTitle => 'At the start of your cycle';

  @override
  String get startArticle1Title => 'Vaginal discharge: what\'s normal?';

  @override
  String get startArticle1Subtitle => '6 min read';

  @override
  String get startArticle1Body =>
      'Discharge changes in color and texture across your cycle, and most of these changes are completely normal — they\'re your body\'s way of regulating itself.\n\nClear or white discharge is common around ovulation, while it\'s often lighter just after your period. If you notice a strong odor, unusual color, or discomfort, it\'s worth checking with a doctor.';

  @override
  String get startArticle2Title => 'Could I be pregnant?';

  @override
  String get startArticle2Subtitle => '5 min read';

  @override
  String get startArticle2Body =>
      'Early pregnancy signs can include a missed period, tender breasts, fatigue, and nausea — but they can also overlap with normal premenstrual symptoms, which makes them easy to miss.\n\nA home pregnancy test is most reliable a few days after your missed period. If your period is late and you\'re unsure, testing is the clearest way to know.';

  @override
  String get startArticle3Title => 'Easing period pain naturally';

  @override
  String get startArticle3Subtitle => '5 min read';

  @override
  String get startArticle3Body =>
      'A warm compress on your lower abdomen, light movement like walking or stretching, and staying hydrated can all help ease period pain.\n\nHerbal teas such as ginger or chamomile are gentle options many people find soothing. If your pain is severe or doesn\'t improve, speak with a healthcare provider.';

  @override
  String get liveBetterSectionTitle => 'Live your cycle better';

  @override
  String get liveArticle1Title => 'Breast tenderness: what helps';

  @override
  String get liveArticle1Subtitle => '4 min read';

  @override
  String get liveArticle1Body =>
      'Breast tenderness before your period is caused by hormonal shifts and usually fades once your period starts.\n\nA supportive, well-fitted bra, reducing caffeine and salt, and gentle warmth can all help ease the discomfort. It typically isn\'t a cause for concern unless it\'s severe or doesn\'t go away.';

  @override
  String get liveArticle2Title => 'Relieving bloating';

  @override
  String get liveArticle2Subtitle => '5 min read';

  @override
  String get liveArticle2Body =>
      'Bloating around your period is caused by hormonal changes that lead your body to retain more water and salt.\n\nDrinking plenty of water, cutting back on salty foods, and light movement can help reduce the swelling. It should ease naturally within a few days.';

  @override
  String get liveArticle3Title => 'Sleeping better during your period';

  @override
  String get liveArticle3Subtitle => '6 min read';

  @override
  String get liveArticle3Body =>
      'Hormonal shifts and cramps can make it harder to fall and stay asleep during your period.\n\nKeeping your room cool, avoiding screens before bed, and using a warm compress for cramps can all improve your sleep quality. A consistent bedtime helps your body adjust more easily across your whole cycle.';

  @override
  String get articlesHubTitle => 'Articles';

  @override
  String get articlesHubSubtitle =>
      'Everything Dawrati knows, organized in one place';

  @override
  String get browseAllArticles => 'Browse all articles';

  @override
  String get nutritionCoachTitle => 'Nutrition Assistant';

  @override
  String get nutritionCoachStarterMessage =>
      'Hi! I\'m your nutrition assistant. To calculate your daily calorie needs, tell me your age, weight, height, activity level, and your goal (lose, maintain, or gain weight).';

  @override
  String get sleepCoachTitle => 'Sleep Assistant';

  @override
  String get sleepCoachStarterMessage =>
      'Hi! I\'m your sleep assistant. Tell me what\'s been going on with your sleep — trouble falling asleep, waking up during the night, or feeling tired — and I\'ll help you find ways to sleep better.';

  @override
  String get premiumOnlyFeatureTitle => 'Premium feature';

  @override
  String get premiumOnlyFeatureDesc =>
      'This conversation is available exclusively for Premium members. Upgrade to unlock it.';

  @override
  String get settingsPartner => 'Partner mode';

  @override
  String get settingsPartnerDesc =>
      'Share a code so your partner can follow your cycle and mood';

  @override
  String get partnerEntryLink => 'Are you a partner? Enter your code';

  @override
  String get partnerEntryTitle => 'Connect as a partner';

  @override
  String get partnerEntrySubtitle =>
      'Enter the code your partner shared with you to follow her cycle.';

  @override
  String get partnerCodeHint => 'CODE';

  @override
  String get partnerConnectButton => 'Connect';

  @override
  String get partnerCodeInvalid =>
      'This code isn\'t valid. Check it with your partner and try again.';

  @override
  String get partnerDashboardTitle => 'Her cycle';

  @override
  String get partnerDashboardSubtitle => 'A shared, read-only view';

  @override
  String get partnerDisconnect => 'Disconnect';

  @override
  String get partnerNoDataYet => 'No data shared yet. Check back soon.';

  @override
  String get partnerCurrentPhase => 'Current phase';

  @override
  String get partnerTipMenstruation =>
      'She may feel more pain or fatigue today. Be gentle and understanding of her need to rest.';

  @override
  String get partnerTipFollicular =>
      'Her energy is gradually rising these days — a good time for plans together.';

  @override
  String get partnerTipOvulation =>
      'She\'s in her fertile window. Mood and energy are often at their best.';

  @override
  String get partnerTipLuteal =>
      'She may experience mood swings or bloating. A little extra patience and support go a long way.';

  @override
  String get partnerPremiumLockTitle => 'Full details are Premium';

  @override
  String get partnerPremiumLockDesc =>
      'Ask her to upgrade to Premium to unlock her exact cycle day, upcoming dates, mood, and daily stats for you.';

  @override
  String get partnerCycleDay => 'Cycle day';

  @override
  String get partnerMood => 'Mood';

  @override
  String get partnerWater => 'Water';

  @override
  String get partnerSleep => 'Sleep';

  @override
  String get partnerNextPeriod => 'Next period';

  @override
  String get partnerNextOvulation => 'Next ovulation';

  @override
  String get partnerCalendarTitle => 'Her cycle this month';

  @override
  String get partnerCodeScreenTitle => 'Your partner code';

  @override
  String get partnerCodeScreenSubtitle =>
      'Share this code with your partner so they can follow your cycle from their own phone — no account needed on their side.';

  @override
  String get partnerCodeUnavailable =>
      'Sign in to your account to get a partner code.';

  @override
  String get partnerShareCode => 'Share code';

  @override
  String partnerShareMessage(String code) {
    return 'Follow my cycle on Dawrati — open the app, tap \"Are you a partner?\" and enter this code: $code';
  }

  @override
  String get relationshipCoachTitle => 'Relationship Assistant';

  @override
  String get relationshipCoachStarterMessage =>
      'Hi! I\'m here to help you connect with your partner. Want tips on explaining how you\'re feeling today, or ways to stay close during different phases of your cycle?';

  @override
  String cycleBasedOnHistory(int count, int days, int periodDays) {
    return 'Based on your last $count logged periods, Dawrati predicts a $days-day cycle and a $periodDays-day period — this updates automatically as you log more.';
  }

  @override
  String cycleBasedOnEstimate(int days) {
    return 'Dawrati is using your estimated $days-day cycle for now. Log a couple of periods and predictions will get more accurate automatically.';
  }

  @override
  String get cycleIrregularWarningTitle =>
      'Your cycles have varied a lot lately';

  @override
  String get cycleIrregularWarningDesc =>
      'Your last few cycles have differed by more than a week in length. This isn\'t a diagnosis, but it may be worth mentioning to a doctor.';

  @override
  String get exportCsvOption => 'Export raw data (CSV)';

  @override
  String get exportDoctorSummary => 'Export summary for my doctor';

  @override
  String get exportChooseFormat => 'Choose an export format';

  @override
  String get settingsAppLock => 'App Lock';

  @override
  String get settingsAppLockDescOn => 'PIN enabled';

  @override
  String get settingsAppLockDescOff => 'Off';

  @override
  String get appLockEnterPin => 'Enter your PIN';

  @override
  String get appLockWrongPin => 'Incorrect PIN';

  @override
  String get appLockCreatePin => 'Create a PIN';

  @override
  String get appLockConfirmPin => 'Confirm your PIN';

  @override
  String get appLockPinMismatch => 'PINs don\'t match, try again';

  @override
  String get appLockUseBiometrics => 'Use Face/Touch ID';

  @override
  String get appLockUseBiometricsDesc =>
      'Unlock with your fingerprint or face instead of typing your PIN.';

  @override
  String get appLockEnable => 'Enable app lock';

  @override
  String get appLockEnableDesc => 'Require a PIN to open the app.';

  @override
  String get appLockDisable => 'Disable app lock';

  @override
  String get appLockDisableConfirmTitle => 'Disable app lock?';

  @override
  String get appLockDisableConfirmDesc =>
      'Anyone with your phone will be able to open Dawrati without a PIN.';

  @override
  String get appLockChangePin => 'Change PIN';

  @override
  String get appLockBiometricsUnavailable =>
      'Biometrics aren\'t available on this device.';

  @override
  String get settingsReferral => 'Invite Friends';

  @override
  String get settingsReferralDesc => 'Give Premium, get Premium';

  @override
  String get referralTitle => 'Invite Friends';

  @override
  String get referralSignInRequired =>
      'Sign in to get your invite code and start earning free Premium days.';

  @override
  String get referralInviteTitle => 'Invite a friend, get Premium';

  @override
  String referralInviteDesc(int days) {
    return 'Share your code. When a friend uses it, you both get $days days of Premium — free.';
  }

  @override
  String get referralShareButton => 'Share my code';

  @override
  String referralShareMessage(String code, int days) {
    return 'Join me on Dawrati! Use my code $code when you sign up and we both get $days days of Premium free.';
  }

  @override
  String get referralRedeemTitle => 'Have a friend\'s code?';

  @override
  String get referralCodeHint => 'Enter code';

  @override
  String get referralRedeemButton => 'Redeem';

  @override
  String get referralCannotUseOwnCode => 'You can\'t use your own code.';

  @override
  String get referralInvalidCode =>
      'That code doesn\'t exist. Double check and try again.';

  @override
  String referralRedeemSuccess(int days) {
    return 'Nice! You just got $days days of Premium.';
  }

  @override
  String get referralAlreadyRedeemed =>
      'You\'ve already redeemed a referral code.';

  @override
  String get symptomInsightTitle => 'Pattern spotted';

  @override
  String symptomInsightText(String symptom, String phase) {
    return 'You often log $symptom during your $phase phase.';
  }

  @override
  String get symptomInsightLockedText =>
      'We noticed a pattern in your symptoms. Unlock Premium to see it.';

  @override
  String get notifPillReminder => 'Pill reminder';

  @override
  String get notifPillReminderDesc => 'Daily reminder to take your pill';

  @override
  String get pillReminderNotifTitle => 'Pill time';

  @override
  String get pillReminderNotifBody => 'Don\'t forget to take your pill today.';

  @override
  String get exportIcsOption => 'Export to calendar (.ics)';

  @override
  String streakBannerText(int days) {
    return '$days-day logging streak';
  }

  @override
  String get settingsWidget => 'Home screen widget';

  @override
  String get settingsWidgetDesc => 'See your cycle day at a glance';

  @override
  String get widgetPinUnsupported =>
      'Your device doesn\'t support adding widgets this way — try long-pressing your home screen instead.';
}
