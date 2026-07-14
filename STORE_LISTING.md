# Dawrati (دورتي) — Store Listing Content

Reference copy to paste into App Store Connect / Google Play Console once the developer accounts are ready.

- **App name:** دورتي (Dawrati)
- **Bundle/Package ID:** `com.dawrati.app` (same on Android and iOS)
- **Category:** Health & Fitness (Play Store) / Health & Fitness or Medical (App Store)
- **Suggested content rating:** Teen / 12+ (mentions pregnancy, sexual health topics)

---

## Arabic (primary)

**Short description (Play Store, ≤80 chars):**
تطبيقك الذكي لتتبع الدورة الشهرية، مع مدربة ذكاء اصطناعي شخصية

**Full description:**
دورتي هو رفيقك اليومي لفهم جسدك وتتبع دورتك الشهرية بدقة وخصوصية تامة.

✨ المميزات:
• تتبع دقيق للدورة الشهرية والتبويض والخصوبة
• سجل يومي شامل: المزاج، الماء، النوم، النشاط، والأعراض
• مدربة الذكاء الاصطناعي: اسأليها عن دورتك، التغذية، أو النوم واحصلي على إجابات فورية
• فاحص الأعراض الذكي
• مكتبة مقالات شاملة عن الصحة النسائية
• تذكيرات ذكية لموعد الدورة والتبويض وشرب الماء
• تحليلات ورسوم بيانية تفاعلية لفهم أنماط دورتك
• واجهة عربية بالكامل مع دعم الفرنسية والإنجليزية
• خصوصية تامة - بياناتك محمية ومشفرة

حمّلي دورتي اليوم وابدئي رحلتك نحو فهم أعمق لجسدك.

**Keywords:** دورة شهرية, تتبع الدورة, تبويض, خصوبة, صحة المرأة, تقويم الدورة, حمل

---

## English

**Short description (≤80 chars):**
Your smart period tracker with a personal AI coach

**Full description:**
Dawrati is your daily companion for understanding your body and tracking your cycle with precision and complete privacy.

✨ Features:
• Accurate period, ovulation, and fertility tracking
• Comprehensive daily log: mood, water, sleep, activity, and symptoms
• AI Coach: ask about your cycle, nutrition, or sleep and get instant answers
• Smart symptom checker
• A full library of women's health articles
• Smart reminders for your period, ovulation, and water intake
• Interactive charts and insights to understand your patterns
• Fully Arabic interface with French and English support
• Complete privacy — your data is protected and encrypted

Download Dawrati today and start your journey to understanding your body better.

**Keywords:** period tracker, cycle tracking, ovulation, fertility, women's health, period calendar, pregnancy

---

## French

**Short description (≤80 chars):**
Votre suivi de cycle intelligent avec un coach IA personnel

**Full description:**
Dawrati est votre compagnon quotidien pour comprendre votre corps et suivre votre cycle avec précision et une confidentialité totale.

✨ Fonctionnalités :
• Suivi précis des règles, de l'ovulation et de la fertilité
• Journal quotidien complet : humeur, eau, sommeil, activité et symptômes
• Coach IA : posez vos questions sur votre cycle, la nutrition ou le sommeil et obtenez des réponses instantanées
• Vérificateur de symptômes intelligent
• Une bibliothèque complète d'articles sur la santé féminine
• Rappels intelligents pour vos règles, l'ovulation et l'hydratation
• Graphiques interactifs pour comprendre vos tendances
• Interface entièrement en arabe, avec support du français et de l'anglais
• Confidentialité totale — vos données sont protégées et chiffrées

Téléchargez Dawrati dès aujourd'hui et commencez votre voyage vers une meilleure compréhension de votre corps.

**Keywords:** suivi de règles, cycle menstruel, ovulation, fertilité, santé féminine, calendrier des règles, grossesse

---

## Progress so far

- ✅ Google Play Console account created (user)
- ✅ Release signing keystore generated (`android/app/upload-keystore.jks`, gitignored) and wired into `build.gradle.kts` — release builds are now signed with a real production key, not the debug key
- ✅ Signed release App Bundle built and verified: `build/app/outputs/bundle/release/app-release.aab`
- ✅ Privacy policy text drafted: `PRIVACY_POLICY.md`
- ✅ Store listing copy drafted (this file) — temperature-feature references removed since that feature was deleted from the app

## ⚠️ Still needed before submission

1. **Host the privacy policy** — `PRIVACY_POLICY.md` needs to live at a public URL for Play Console's Data Safety section (GitHub Pages, Firebase Hosting, or any static host). Give me the URL once it's up.
2. **Screenshots** — real device screenshots at Play Store's required sizes (phone: min 320px, max 3840px on the longest side; at least 2, ideally 4-8). Can be captured from the emulator.
3. **App icon (512×512) and feature graphic (1024×500)** for the Play Store listing.
4. **In Play Console:** create the app entry, complete the Data Safety questionnaire, content rating questionnaire, and create the 2 subscription products with IDs `dawrati_premium_monthly` / `dawrati_premium_yearly` (must match the code exactly).
5. **Apple Developer Program** ($99/year) — separate from Google Play, only needed if/when targeting iOS.
