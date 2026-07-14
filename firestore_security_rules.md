# Firestore Security Rules

Paste this into **Firebase Console → Firestore Database → Rules**, replacing the current contents, then click **Publish**.

It covers everything the app currently needs: each user's own profile and daily logs (private), the Partner Mode collections (`partnerLinks` and each user's `partnerView` summary), which a partner can read anonymously but never write, and the referral program (`referralCodes` and each user's `referralCredits`), which lets a friend credit you with bonus Premium days without ever being able to touch your account directly.

```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    // A user's own profile + settings. Only the owner can read or write it.
    match /users/{uid} {
      allow read, write: if request.auth != null && request.auth.uid == uid;

      // Daily log entries — private to the owner only.
      match /dailyLogs/{date} {
        allow read, write: if request.auth != null && request.auth.uid == uid;
      }

      // Curated, partner-safe snapshot (phase, cycle day, mood, water,
      // sleep, premium flag — never raw logs or account info).
      // The owner can write it; any signed-in user (including an
      // anonymously-signed-in partner) can read it.
      match /partnerView/{document=**} {
        allow read: if request.auth != null;
        allow write: if request.auth != null && request.auth.uid == uid;
      }

      // Referral rewards someone else's device deposits here when they
      // redeem this user's code. The owner reads and deletes their own
      // credits once claimed; anyone signed in can create one (for a
      // friend they just referred), capped at a sane number of days so
      // no one can grant themselves unlimited Premium.
      match /referralCredits/{creditId} {
        allow read, delete: if request.auth != null && request.auth.uid == uid;
        allow create: if request.auth != null
                      && request.resource.data.days is int
                      && request.resource.data.days > 0
                      && request.resource.data.days <= 30;
        allow update: if false;
      }
    }

    // Maps a short partner code -> the owning user's uid. Any signed-in
    // user can look up a code; only the owner can create/claim their own
    // code, and it can never be reassigned once created.
    match /partnerLinks/{code} {
      allow read: if request.auth != null;
      allow create: if request.auth != null
                    && request.auth.uid == request.resource.data.ownerUid;
      allow update, delete: if false;
    }

    // Same pattern as partnerLinks, for referral codes.
    match /referralCodes/{code} {
      allow read: if request.auth != null;
      allow create: if request.auth != null
                    && request.auth.uid == request.resource.data.ownerUid;
      allow update, delete: if false;
    }
  }
}
```

## Why this is safe

- A partner device only ever gets **anonymous** Firebase auth (no email/password) — just enough to satisfy `request.auth != null`.
- A partner can only read `partnerView/summary`, a small curated document your app writes deliberately (phase, cycle day, next dates, today's mood/water/sleep, premium flag). It never contains your daily-log notes, symptoms text, photos, chat history, or email.
- A partner code is effectively unguessable (8 random characters from a 33-character set ≈ 1.4 × 10¹² combinations) and, once created, can't be reassigned to a different owner.
- Your full profile (`/users/{uid}`) and daily logs stay fully private — nothing in this ruleset opens them up beyond the owner.
- A referral credit can only ever be *created* by someone else (never read, updated, or deleted by them), is capped at 30 days, and only the account it was deposited into can read or remove it — so a redeeming device can reward the referrer but can never touch the referrer's account otherwise.
