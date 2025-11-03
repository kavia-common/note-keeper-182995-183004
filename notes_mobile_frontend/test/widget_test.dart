import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_mobile_frontend/main.dart';
import 'package:provider/provider.dart';
import 'package:notes_mobile_frontend/state/notes_provider.dart';
import 'package:notes_mobile_frontend/ui/screens/notes_list_screen.dart';
import 'package:notes_mobile_frontend/ui/screens/note_edit_screen.dart';
import 'package:notes_mobile_frontend/theme/app_theme.dart';

Widget _buildTestApp() {
  // Build a minimal app that mirrors main.dart but keeps it simple for tests.
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => NotesProvider())],
    child: MaterialApp(
      title: 'Notes',
      theme: AppTheme.light(),
      home: const NotesListScreen(),
      routes: {
        NoteEditScreen.routeName: (_) => const NoteEditScreen(),
      },
    ),
  );
}

void main() {
  testWidgets('Shows app bar title and FAB', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());
    expect(find.text('Notes'), findsOneWidget);
    expect(find.byKey(const ValueKey('fabAddNote')), findsOneWidget);
  });

  testWidgets('Navigates to edit screen when tapping FAB', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());
    // Tap FAB
    await tester.tap(find.byKey(const ValueKey('fabAddNote')));
    await tester.pumpAndSettle();
    // Edit screen shows Save button
    expect(find.byKey(const ValueKey('saveBtn')), findsOneWidget);
    expect(find.byKey(const ValueKey('titleField')), findsOneWidget);
    expect(find.byKey(const ValueKey('contentField')), findsOneWidget);
  });

  testWidgets('NotesApp root builds', (WidgetTester tester) async {
    // Ensure main widget composes without requiring a real DB instance for tests
    await tester.pumpWidget(const NotesApp());
    expect(find.byType(NotesListScreen), findsOneWidget);
  });
}
