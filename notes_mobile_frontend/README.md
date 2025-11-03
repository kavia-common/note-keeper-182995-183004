# notes_mobile_frontend

A Flutter mobile app for creating, editing, searching, and deleting notes with a simple, modern UI. The app uses on-device SQLite via the sqflite package. There is no network dependency between the app and the notes_database container at runtime; both maintain the same schema so you can inspect or seed data in the container while the app stores data locally on the device/emulator.

## Quick Start

Make sure you have Flutter, Android/iOS tooling, and an emulator or device available. Then install dependencies and run:

```bash
flutter pub get
flutter run
```

- To run tests in CI or locally without interactivity, use:
```bash
CI=true flutter test
```

- To analyze code:
```bash
flutter analyze
```

## Features

The application provides a streamlined notes experience:
- List notes in reverse chronological order by last update.
- Add new notes with title and content.
- Edit existing notes and save changes.
- Swipe a note to delete with an Undo action in a snackbar.
- Search notes by title or content as you type.
- Empty state messaging when there are no notes yet.

## Data Storage and Schema Parity

This mobile app persists notes to an on-device SQLite database using the sqflite plugin. At runtime it does not connect to the notes_database container or any remote service. Instead, both the mobile app and the database container share the same table schema so that you can seed, inspect, and validate data externally if desired.

- Package: sqflite
- Database filename: notes.db (device-local)
- Versioning: handled in-app (see dbVersion)

Schema parity details:
- Table name: notes
- Columns:
  - id INTEGER PRIMARY KEY AUTOINCREMENT
  - title TEXT NOT NULL
  - content TEXT NOT NULL
  - created_at INTEGER
  - updated_at INTEGER

You can find the schema creation and DB lifecycle code in:
- lib/data/database_helper.dart (creates and upgrades the database)
- lib/data/note_dao.dart (CRUD queries)
- lib/data/note_model.dart (entity mapping)
- lib/data/note_repository.dart (data access façade)

## How It Works (Architecture Overview)

On launch, the app initializes providers and shows the notes list screen. The NotesProvider loads notes via NoteRepository, which delegates to NoteDao for SQLite access. New items are optimistically added to state and then persisted. Updates and deletes also optimistically update state and then commit to the database. Search runs a LIKE query against title and content and refreshes the list.

Key files:
- lib/main.dart: App entry and routing
- lib/state/notes_provider.dart: State management, optimistic updates, search
- lib/ui/screens/notes_list_screen.dart: List view, search bar, FAB
- lib/ui/screens/note_edit_screen.dart: Create/edit form and save logic
- lib/ui/widgets/note_card.dart: List card UI
- lib/theme/app_theme.dart: Material 3 light theme aligned with style guide

## Running on Android

- Ensure Android SDK and an emulator or device is available.
- Verify sdk.dir and flutter.sdk are configured in android/local.properties.
- Then execute:
```bash
flutter run -d android
```

## Running on iOS (macOS required)

- Ensure Xcode and CocoaPods are installed.
- Set up an iOS simulator or connect a device.
- Then execute:
```bash
flutter run -d ios
```

## Testing

The repository includes widget tests:
```bash
CI=true flutter test
```

These tests validate basic UI flows such as rendering the Notes screen and navigating to the edit screen.

## Notes on Sample Data

If you also initialize the notes_database container’s SQLite instance, it uses the same table schema for notes and can seed a couple of example notes. The app will not read those records automatically since it stores data on-device; however, you can use the container as a reference for schema inspection and sample content.

## Troubleshooting

- If sqflite fails on desktop/web, ensure you run on a supported device (Android or iOS emulator/physical device).
- If builds fail due to missing Android tooling, confirm your ANDROID_HOME/SDK and Flutter installation are correct.
- If tests hang in non-interactive environments, use CI=true flutter test.

