class AppTexts {
  static Map<String, String> get(String lang) {
    if (lang == 'ar') {
      return {
        'welcome': 'مرحباً',
        'chooseLanguage': 'اختاري اللغة',
        'onboarding1Title': 'افهمي دورتك',
        'onboarding1Desc': 'تابعي كل مرحلة من دورتك الشهرية بسهولة.',
        'onboarding2Title': 'توقعي موعد الدورة',
        'onboarding2Desc': 'احصلي على توقعات أوضح لموعد دورتك القادمة.',
        'onboarding3Title': 'سجلي الأعراض',
        'onboarding3Desc': 'تابعي الألم، المزاج، النوم والمزيد.',
        'next': 'التالي',
        'back': 'رجوع',
        'ageTitle': 'كم عمرك؟',
        'lastPeriodTitle': 'متى بدأت آخر دورة؟',
        'periodLengthTitle': 'كم يوماً تستمر دورتك؟',
        'cycleLengthTitle': 'ما متوسط طول دورتك؟',
        'goalTitle': 'لماذا تستخدمين التطبيق؟',
      };
    }

    if (lang == 'en') {
      return {
        'welcome': 'Welcome',
        'chooseLanguage': 'Choose your language',
        'onboarding1Title': 'Know your cycle',
        'onboarding1Desc': 'Track every phase of your menstrual cycle easily.',
        'onboarding2Title': 'Predict your period',
        'onboarding2Desc': 'Get clearer predictions for your next period.',
        'onboarding3Title': 'Track symptoms',
        'onboarding3Desc': 'Log pain, mood, sleep and more.',
        'next': 'Next',
        'back': 'Back',
        'ageTitle': 'How old are you?',
        'lastPeriodTitle': 'When did your last period start?',
        'periodLengthTitle': 'How long do your periods last?',
        'cycleLengthTitle': 'What is your average cycle length?',
        'goalTitle': 'Why are you using the app?',
      };
    }

    return {
      'welcome': 'Bienvenue',
      'chooseLanguage': 'Choisis ta langue',
      'onboarding1Title': 'Comprends ton cycle',
      'onboarding1Desc': 'Suis chaque phase de ton cycle facilement.',
      'onboarding2Title': 'Prédis tes règles',
      'onboarding2Desc': 'Obtiens des prédictions plus claires pour tes prochaines règles.',
      'onboarding3Title': 'Suis tes symptômes',
      'onboarding3Desc': 'Note la douleur, l’humeur, le sommeil et plus.',
      'next': 'Suivant',
      'back': 'Retour',
      'ageTitle': 'Quel âge as-tu ?',
      'lastPeriodTitle': 'Quand ont commencé tes dernières règles ?',
      'periodLengthTitle': 'Combien de jours durent tes règles ?',
      'cycleLengthTitle': 'Quelle est la durée moyenne de ton cycle ?',
      'goalTitle': 'Pourquoi utilises-tu l’application ?',
    };
  }
}