# Google Play "Data Safety" form — pre-filled answers

Reference for the Play Console "Data safety" section. Fill it in exactly like this once the app entry exists.

## Does your app collect or share any of the required user data types?
**Yes**

## Data types collected

### Personal info
- **Email address** — Collected, linked to user identity. Purpose: Account management, App functionality. Required (needed for sign-in).

### Health and fitness
- **Health info** (cycle dates, symptoms, mood, sleep, water, weight, medications) — Collected, linked to user identity (if signed in). Purpose: App functionality. Optional (app usable without an account, data then stays local-only).

### App activity
- **App interactions** (AI coach chat messages) — Collected, linked to user identity. Purpose: App functionality (used only to generate AI responses). Not shared for advertising.

### Financial info
- **Purchase history** (subscription status) — Collected, linked to user identity. Purpose: App functionality (managing Premium access). Note: payment card details are handled entirely by Google Play Billing — Dawrati never sees or stores them.

## Is all of the user data collected by your app encrypted in transit?
**Yes**

## Do you provide a way for users to request that their data is deleted?
**Yes** — via Settings → Privacy → "Clear my data" (local), and by contacting support@dawrati.app for full account/cloud data deletion.

## Data sharing with third parties
- **OpenAI** (AI provider): chat messages and relevant cycle context are sent only when the user actively uses AI Coach / Symptom Checker, solely to generate the response. Not used for advertising or sold.
- **Google Play Billing**: payment processing only. Dawrati never receives raw card data.
- **Firebase (Google Cloud)**: acts as the backend infrastructure (auth + database), not an independent third party under Play's definition, but worth knowing it's Google Cloud infrastructure if asked.

## Is data collection required or optional?
Mostly **optional** — the app is usable fully offline/local without an account. Sign-in (and therefore cloud sync, partner mode, referrals, AI history) is opt-in.

---

# Content rating questionnaire — likely answers

- Category: **Reference, News, or Utility** or **Health & Fitness** app type in the questionnaire
- Violence: None
- Sexual content: **Mentions of pregnancy, fertility, and sexual health topics** — answer honestly, this typically results in a **Teen (13+)** or equivalent rating in most rating systems, not "Everyone"
- Drugs/alcohol/tobacco references: None
- User-generated content shared with others: **Yes, limited** — Partner Mode shares a curated snapshot of cycle data with one invited person via a private code (not public, not searchable)
- Location sharing: No
- Personal info shared with other users: No (only the Partner Mode snapshot, opt-in, private code-based)

Answer the actual Play Console questionnaire directly since exact wording/options change — this is just a reference so you're not caught off guard.
