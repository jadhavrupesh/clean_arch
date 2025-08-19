import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/main.dart';

void main() {
  group('Main App Tests', () {
    testWidgets('App should render without crashing', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app renders
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App should have correct title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Get the MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Verify the title
      expect(app.title, 'Clean Architecture Demo');
    });

    testWidgets('App should have correct theme configuration', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Get the MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Verify theme configuration
      expect(app.themeMode, ThemeMode.light);
      expect(app.debugShowCheckedModeBanner, false);
      expect(app.theme, isNotNull);
    });

    testWidgets('App should display PostsPage as home', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that PostsPage is displayed (this will be the scaffold)
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
