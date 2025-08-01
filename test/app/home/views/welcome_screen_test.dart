import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/home/views/welcome_screen.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/widgets/analytics_opt_in.dart';
import 'package:petjournal/widgets/custom_switch.dart';

import 'welcome_screen_test.mocks.dart';

// Generate mocks for dependencies
@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;

  /// Creates a test screen with mocked database and router.
  Widget createScreen() {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(mockDb)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: const WelcomeScreen(),
        ),
      ),
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
    mockGoRouter = MockGoRouter();

    // Setup default database behavior
    when(mockDb.getSettings()).thenAnswer(
      (_) async => Setting(
        settingsId: 1,
        acceptedTermsAndConditions: false,
        onBoardingComplete: false,
        optIntoAnalyticsWarning: false,
        lastUsedVersion: null,
        defaultWeightUnit: null,
        createLinkedJournalEntries: true,
      ),
    );

    when(
      mockDb.saveSettingsOnboarding(any, any, any),
    ).thenAnswer((_) async => 1);
  });

  group('Initial State & UI Validation', () {
    testWidgets('renders initial screen elements', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ASSERT - Verify all initial UI elements are present
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('to Pet Journal'), findsOneWidget);
      expect(find.text('I accept the terms and conditions'), findsOneWidget);
      expect(
        find.byKey(WelcomeScreen.welcomeAcceptTermsAndConditionsKey),
        findsOneWidget,
      );
      expect(
        find.byKey(WelcomeScreen.welcomeOptIntoAnalyticsKey),
        findsOneWidget,
      );
    });

    testWidgets('Continue button is initially disabled', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ASSERT
      final button = tester.widget<TextButton>(
        find.byKey(WelcomeScreen.welcomeContinueKey),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('switches are initially unchecked', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ASSERT
      final termsSwitch = tester.widget<CustomSwitch>(
        find.byKey(WelcomeScreen.welcomeAcceptTermsAndConditionsKey),
      );
      expect(termsSwitch.switchValue, isFalse);

      final analyticsSwitch = tester.widget<AnalyticsOptIn>(
        find.byKey(WelcomeScreen.welcomeOptIntoAnalyticsKey),
      );
      expect(analyticsSwitch.optIntoAnalyticsValue, isFalse);
    });
  });

  group('User Interaction & State Changes', () {
    testWidgets('accepting terms enables continue button', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ACT - Accept terms
      await tester.tap(
        find.byKey(WelcomeScreen.welcomeAcceptTermsAndConditionsKey),
      );
      await tester.pump();

      // ASSERT
      final button = tester.widget<TextButton>(
        find.byKey(WelcomeScreen.welcomeContinueKey),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('analytics switch toggles correctly', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ACT - Toggle analytics
      final optInAnalyticsFinder = find.descendant(
        of: find.byKey(WelcomeScreen.welcomeOptIntoAnalyticsKey),
        matching: find.byType(Switch),
      );
      final scrollableFinder = find.byType(Scrollable).last;
      await tester.scrollUntilVisible(
        optInAnalyticsFinder,
        10,
        scrollable: scrollableFinder,
      );
      await tester.tap(optInAnalyticsFinder);
      await tester.pump();

      // ASSERT
      final analyticsSwitch = tester.widget<AnalyticsOptIn>(
        find.byType(AnalyticsOptIn),
      );
      expect(analyticsSwitch.optIntoAnalyticsValue, isTrue);
    });
  });

  group('Navigation & Data Persistence', () {
    testWidgets('saves settings and navigates on continue', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(createScreen());

      // ACT - Accept terms and continue
      await tester.tap(
        find.byKey(WelcomeScreen.welcomeAcceptTermsAndConditionsKey),
      );
      await tester.pump();
      await tester.tap(find.byKey(WelcomeScreen.welcomeContinueKey));
      await tester.pumpAndSettle();

      // ASSERT
      verify(mockDb.saveSettingsOnboarding(true, false, true)).called(1);
      verify(mockGoRouter.go(RouteDefs.home)).called(1);
    });
  });

  group('Error Handling', () {
    testWidgets('handles database error gracefully', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      when(
        mockDb.saveSettingsOnboarding(any, any, any),
      ).thenThrow(Exception('Database error'));
      await tester.pumpWidget(createScreen());

      // ACT - Accept terms and try to continue
      await tester.tap(
        find.byKey(WelcomeScreen.welcomeAcceptTermsAndConditionsKey),
      );
      await tester.pump();
      await tester.tap(find.byKey(WelcomeScreen.welcomeContinueKey));
      await tester.pumpAndSettle();

      // ASSERT - Should not navigate on error
      verifyNever(mockGoRouter.go(any));
    });
  });
}
