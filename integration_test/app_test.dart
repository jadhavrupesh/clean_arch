import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:clean_arch/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Posts App Integration Tests', () {
    testWidgets('should load and display posts from API', (
      WidgetTester tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify that the app bar is displayed
      expect(find.text('Clean Architecture Demo'), findsOneWidget);

      // Wait for the posts to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify that at least one post is displayed
      // Since the app fetches from jsonplaceholder, we should see posts
      expect(find.byType(Card), findsAtLeastNWidgets(1));

      // Verify that the posts have titles and bodies
      expect(find.byType(Text), findsAtLeastNWidgets(2));
    });

    testWidgets('should show loading indicator while fetching posts', (
      WidgetTester tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pump(); // Don't wait for settle to catch loading state

      // Verify that loading indicator is shown initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should refresh posts when refresh button is tapped', (
      WidgetTester tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the refresh button in the app bar
      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton, findsOneWidget);

      // Tap the refresh button
      await tester.tap(refreshButton);
      await tester.pump();

      // Verify that loading indicator appears again
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the refresh to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify that posts are still displayed after refresh
      expect(find.byType(Card), findsAtLeastNWidgets(1));
    });

    testWidgets('should display post details correctly', (
      WidgetTester tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the first post card
      final firstCard = find.byType(Card).first;
      expect(firstCard, findsOneWidget);

      // Verify that the card contains text (title and body)
      final cardWidget = tester.widget<Card>(firstCard);
      expect(cardWidget, isNotNull);

      // Look for text widgets within the card
      final textsInCard = find.descendant(
        of: firstCard,
        matching: find.byType(Text),
      );

      expect(textsInCard, findsAtLeastNWidgets(2)); // At least title and body
    });

    testWidgets('should maintain state during scroll', (
      WidgetTester tester,
    ) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Get the initial number of posts
      final initialCards = find.byType(Card);
      final initialCount = tester.widgetList(initialCards).length;

      // Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Verify that the same number of posts are still displayed
      final cardsAfterScroll = find.byType(Card);
      final countAfterScroll = tester.widgetList(cardsAfterScroll).length;

      expect(countAfterScroll, equals(initialCount));
    });
  });
}
