# ⏳ HolaTimer

> Countdown app for life's important moments — no ads, ever.  
> Built with love. My girlfriend was pregnant and I couldn't find a clean timer app.

**Version:** 1.0.0 Beta  
**Date:** 2026-05-08  
**Author:** Mulder (Esteban Peralta Núñez) — [linkedin.com/in/esteban-peralta-nunez](https://www.linkedin.com/in/esteban-peralta-nunez/)

---

## What it does

- Countdown to any event: pregnancy, birthday, anniversary, travel, or custom
- Pregnancy mode: weekly fruit/veggie size comparison + baby development info (40 weeks, 6 languages)
- 6 languages: Spanish, English, Japanese, Italian, French, German — auto-detected on first launch
- Home screen widget showing your most urgent event
- Photo gallery per event (ultrasound photos, memories)
- Daily notifications with per-event-type custom sounds
- Share countdown card to WhatsApp / Instagram with `#HolaTimer`
- Welcome / onboarding screen on first launch
- Zero ads

---

## Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | 3.x+ |
| Dart | 3.x+ |
| Android SDK | API 26+ (Android 8.0) |
| JDK | 17+ |

Install Flutter: https://docs.flutter.dev/get-started/install

---

## Run in development

```bash
# 1. Install dependencies
flutter pub get

# 2. Connect a device (USB debugging on) or start an emulator
flutter devices

# 3. Run debug build
flutter run

# 4. Run release build on connected device
flutter run --release
```

---

## Generate APK

### Single APK (simplest, larger file)
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Split APKs by CPU architecture (smaller, recommended for sideloading)
```bash
flutter build apk --split-per-abi --release
# Output: build/app/outputs/flutter-apk/
#   app-arm64-v8a-release.apk   ← modern phones (use this one)
#   app-armeabi-v7a-release.apk ← older 32-bit phones
#   app-x86_64-release.apk      ← emulators
```

### AAB for Google Play (required for store upload)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

> **Note:** The app currently signs with debug keys so `flutter run --release` works out of the box.
> Before publishing to Play Store, create a release keystore:
> ```bash
> keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
> ```
> Then configure `android/key.properties` and reference it in `android/app/build.gradle.kts`.

---

## Notification sounds

Custom sound channels are wired up and ready. To activate them, place `.mp3` files in:

```
android/app/src/main/res/raw/
```

| File | Event type | Sound style |
|------|-----------|-------------|
| `baby.mp3` | Pregnancy | Baby laugh / coo (~2s) |
| `wedding_bells.mp3` | Anniversary | Wedding bells chime (~2s) |
| `happy_birthday.mp3` | Birthday | Happy Birthday jingle (~1s) |
| `plane_takeoff.mp3` | Travel | Plane engine / takeoff (~2s) |

Free sounds: [freesound.org](https://freesound.org)

> **Important:** After adding sound files, uninstall the app before reinstalling.
> Android caches notification channels — an existing channel won't pick up a new sound.

---

## Home screen widget

The widget is registered in AndroidManifest and ready to use after installing the app:

1. Long-press home screen → Widgets
2. Find **HolaTimer**
3. Drag to home screen

Shows the most urgent upcoming event. Updates every time the app opens.

---

## Project structure

```
lib/
├── data/
│   ├── database.dart              # SQLite v2 (events + photos tables)
│   ├── events_repository.dart
│   ├── photos_repository.dart
│   └── pregnancy_data.dart        # 40 weeks, 6 languages
├── l10n/
│   └── app_l10n.dart              # Typed localization — 6 languages, ~45 strings each
├── models/
│   ├── event.dart
│   └── event_photo.dart
├── providers/
│   ├── locale_provider.dart
│   └── onboarding_provider.dart
├── screens/
│   ├── about_screen.dart
│   ├── event_detail_screen.dart   # Share card + photo gallery
│   ├── event_form_screen.dart
│   ├── events_screen.dart
│   ├── home_screen.dart
│   ├── onboarding_screen.dart
│   └── settings_screen.dart
├── services/
│   ├── notification_service.dart  # Per-type channels + sounds
│   └── widget_service.dart        # Updates home screen widget data
├── widgets/
│   ├── countdown_display.dart     # Color-themed by event type
│   ├── photo_gallery.dart
│   ├── pregnancy_animation.dart
│   └── week_info_card.dart
├── app_theme.dart                 # EventTypeColors + colorsFor()
├── main.dart
└── router.dart

android/app/src/main/
├── kotlin/.../HolaTimerWidget.kt  # AppWidgetProvider (home_widget)
└── res/
    ├── drawable/widget_bg.xml     # Pink gradient background
    ├── layout/holatimer_widget.xml
    ├── raw/                       # Place .mp3 sound files here
    └── xml/holatimer_widget_info.xml
```

---

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `go_router` | Navigation |
| `sqflite` | Local SQLite database |
| `flutter_local_notifications` | Daily scheduled notifications |
| `timezone` | Timezone-aware scheduling |
| `shared_preferences` | Language + onboarding persistence |
| `image_picker` | Camera / gallery for event photos |
| `path_provider` | App documents directory |
| `share_plus` | Share image to WhatsApp / Instagram |
| `home_widget` | Android home screen widget |
| `url_launcher` | Open external links (LinkedIn) |
| `intl` | Date formatting per locale |

---

## Possible improvements — v2+

### High impact
- [ ] **Google login + cloud backup** — sync across devices, restore on reinstall
- [ ] **Recurring events** — birthdays and anniversaries that reset each year automatically
- [ ] **Milestone notifications** — surprise alerts at 100 days, 50 days, "last week!" etc.
- [ ] **iOS version** — same codebase, needs notification + widget platform adjustments

### Medium impact
- [ ] **Dark mode** — AMOLED-friendly dark theme
- [ ] **Couple mode** — share an event with a partner so both count down together
- [ ] **Multiple widget sizes** — let user pick which event the widget shows, add 4×2 size
- [ ] **WearOS widget** — glanceable countdown on smartwatch
- [ ] **Calendar integration** — import event date from Google / device calendar
- [ ] **Tablet / iPad layout** — two-column layout for large screens

### Nice to have
- [ ] **Custom event colors** — user overrides the per-type default color
- [ ] **Rich notifications** — include event photo or large emoji in the notification
- [ ] **Export data** — backup all events as JSON or CSV
- [ ] **Instagram Stories card** — 9:16 vertical share card option
- [ ] **Pregnancy appointments** — doctor visit reminders built into pregnancy events
- [ ] **Custom notification sounds** — user picks from device music library
- [ ] **Swipe to archive events** — swipe left to hide without deleting

---

## Changelog

### v1.0.0 Beta — 2026-05-08
- First release
- Event types: pregnancy, birthday, anniversary, travel, custom
- Pregnancy mode: 40-week data (fruit size, weight, development) in 6 languages
- Languages: ES, EN, JA, IT, FR, DE — persisted in SharedPreferences, auto-detected on first launch
- Onboarding screen with language selector on first launch
- SQLite local storage (events + photos, schema v2)
- Daily push notifications with per-type Android notification channels
- Custom sound support: baby, wedding bells, happy birthday, plane takeoff
- Home screen widget via `home_widget` — shows most urgent event, tap to open app
- Photo gallery per event: camera or gallery picker, persistent storage, full-screen viewer
- Share countdown card (PNG) to WhatsApp / Instagram with #HolaTimer hashtag
- Per-event-type color themes (pregnancy: pink, birthday: orange, anniversary: red, travel: blue, custom: purple)
- About screen with origin story + LinkedIn contact

---

*Made with ❤️ by Mulder · #HolaTimer*
