import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mock;
import 'package:petjournal/app/settings/views/settings_screen.dart';
import 'package:petjournal/app/settings/views/widgets/edit_settings_widget.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/widgets/analytics_opt_in.dart';
import 'package:petjournal/widgets/weight_units_dropdown.dart';
import '../../../testhelpers/stream_helper.dart';
import 'settings_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
Setting createMockSettings({
  WeightUnits weightUnit = WeightUnits.metric,
  bool optIntoAnalyticsWarning = false,
  bool onBoardingComplete = true,
}) {
  return Setting(
    settingsId: 1,
    acceptedTermsAndConditions: true,
    onBoardingComplete: onBoardingComplete,
    optIntoAnalyticsWarning: optIntoAnalyticsWarning,
    lastUsedVersion: null,
    defaultWeightUnit: weightUnit.dataValue,
  );
}

void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;

  Widget createScreen(MockDatabaseService db) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: const SettingsScreen(),
        ),
      ),
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
    mockGoRouter = MockGoRouter();
  });

  group('SettingsScreen', () {
    testWidgets('shows loading indicator while fetching settings', (
      tester,
    ) async {
      mock
          .when(mockDb.watchSettings())
          .thenAnswer(
            (_) => streamDelayer(
              Stream.value(createMockSettings()),
              const Duration(milliseconds: 100),
            ),
          );

      await tester.pumpWidget(createScreen(mockDb));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('shows error state when settings fetch fails', (tester) async {
      mock
          .when(mockDb.watchSettings())
          .thenThrow(Exception('Failed to load settings'));

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      expect(find.textContaining('Error loading settings:'), findsOneWidget);
      mock.verify(mockDb.watchSettings()).called(1);
    });

    testWidgets('displays current settings when loaded', (tester) async {
      final mockSettings = createMockSettings(
        weightUnit: WeightUnits.imperial,
        optIntoAnalyticsWarning: true,
      );
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.byType(EditSettingsWidget), findsOneWidget);
      expect(find.byType(WeightUnitsDropdown), findsOneWidget);
      expect(find.byType(AnalyticsOptIn), findsOneWidget);
      expect(find.widgetWithText(TextButton, "Save"), findsOneWidget);
      expect(find.widgetWithText(TextButton, "Delete All"), findsOneWidget);
    });

    testWidgets('saves weight unit changes', (tester) async {
      final mockSettings = createMockSettings(weightUnit: WeightUnits.metric);
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));
      mock
          .when(mockDb.saveSettingsUser(mock.any, mock.any))
          .thenAnswer((_) => Future.value(1));

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      // Find and tap the weight units dropdown
      await tester.tap(find.byType(WeightUnitsDropdown));
      await tester.pumpAndSettle();

      // Select imperial units
      await tester.tap(find.text('Imperial (lbs)').last);
      await tester.pumpAndSettle();

      // Tap the save button
      await tester.tap(find.widgetWithText(TextButton, "Save"));

      mock
          .verify(mockDb.saveSettingsUser(WeightUnits.imperial, false))
          .called(1);
    });

    testWidgets('toggles analytics opt-in', (tester) async {
      final mockSettings = createMockSettings(
        optIntoAnalyticsWarning: false,
        weightUnit: WeightUnits.metric,
      );
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));
      mock
          .when(mockDb.saveSettingsUser(mock.any, mock.any))
          .thenAnswer((_) => Future.value(1));

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      // Find and tap the analytics switch
      final optInAnalyticsFinder = find.descendant(
        of: find.byType(AnalyticsOptIn),
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

      // Tap the save button
      await tester.tap(find.widgetWithText(TextButton, "Save"));
      mock
          .verify(
            mockDb.saveSettingsUser(
              WeightUnits.metric,
              true, // optIntoAnalyticsWarning changed to true
            ),
          )
          .called(1);
    });

    testWidgets('shows confirmation dialog when clearing data', (tester) async {
      final mockSettings = createMockSettings();
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));
      mock.when(mockDb.clearAllData()).thenAnswer((_) => Future.value());

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      // Find and tap the clear data button
      await tester.tap(find.text('Delete All'));
      await tester.pumpAndSettle();

      // Verify dialog appears
      expect(find.text('Delete All Data?'), findsOneWidget);
      expect(
        find.text('Are you sure you want to delete all data in the app?'),
        findsOneWidget,
      );

      // Cancel the dialog
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      mock.verifyNever(mockDb.clearAllData());

      // Open dialog again and confirm
      await tester.tap(find.text('Delete All'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      mock.verify(mockDb.clearAllData()).called(1);
      mock.verify(mockGoRouter.go(RouteDefs.home)).called(1);
    });

    testWidgets('shows success message after clearing data', (tester) async {
      final mockSettings = createMockSettings();
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));
      mock.when(mockDb.clearAllData()).thenAnswer((_) => Future.value());

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete All'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(find.text('All data removed successfully!'), findsOneWidget);
    });

    testWidgets('handles error when clearing data fails', (tester) async {
      final mockSettings = createMockSettings();
      mock
          .when(mockDb.watchSettings())
          .thenAnswer((_) => Stream.value(mockSettings));
      mock
          .when(mockDb.clearAllData())
          .thenThrow(Exception('Failed to clear data'));

      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete All'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Error removing data'), findsOneWidget);

      // ASSERT - Should not navigate on error
      mock.verifyNever(mockGoRouter.go(mock.any));
    });
  });
}
