import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/constants/defaults.dart' as defaults;
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';

import 'settings_controller_test.mocks.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
/// Taken from https://riverpod.dev/docs/essentials/testing
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);
  return container;
}

@GenerateMocks([DatabaseService])
void main() {
  group('SettingsController Tests', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('watchSettings', () {
      testWidgets(
        'Should emit mapped settings When database returns valid data',
        (tester) async {
          // ARRANGE
          final expectedSettings = Setting(
            settingsId: defaults.defaultSettingsId,
            acceptedTermsAndConditions: true,
            optIntoAnalyticsWarning: true,
            onBoardingComplete: true,
            defaultWeightUnit: WeightUnits.metric,
            createLinkedJournalEntries: true,
          );

          when(
            mockDatabaseService.watchSettings(),
          ).thenAnswer((_) => Stream.value(expectedSettings));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final settings = await container.read(
            settingsControllerProvider.future,
          );

          // ASSERT
          expect(settings.acceptedTermsAndConditions, true);
          expect(settings.optIntoAnalyticsWarning, true);
          expect(settings.onBoardingComplete, true);
          expect(settings.defaultWeightUnit, WeightUnits.metric);
          expect(settings.createLinkedJournalEntries, true);
          verify(mockDatabaseService.watchSettings()).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should emit mapped settings When database returns empty data',
        (tester) async {
          // ARRANGE
          final defaultWeightUnit = defaults.getDefaultWeightUnit();

          final emptySettings = Setting(
            settingsId: defaults.defaultSettingsId,
            acceptedTermsAndConditions: false,
            optIntoAnalyticsWarning: false,
            onBoardingComplete: false,
            defaultWeightUnit: defaultWeightUnit,
            createLinkedJournalEntries: true,
          );

          when(
            mockDatabaseService.watchSettings(),
          ).thenAnswer((_) => Stream.value(emptySettings));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final settings = await container.read(
            settingsControllerProvider.future,
          );

          // ASSERT
          expect(settings.acceptedTermsAndConditions, false);
          expect(settings.optIntoAnalyticsWarning, false);
          expect(settings.onBoardingComplete, false);
          expect(settings.defaultWeightUnit, defaultWeightUnit);
          expect(settings.createLinkedJournalEntries, true);
          verify(mockDatabaseService.watchSettings()).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets('Should handle error When database stream fails', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.watchSettings(),
        ).thenAnswer((_) => Stream.error('Database error'));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(settingsControllerProvider.future),
          throwsA(isA<String>()),
        );

        verify(mockDatabaseService.watchSettings()).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('saveOnboardingSettings', () {
      testWidgets(
        'Should return true When database successfully saves onboarding settings',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsOnboarding(any, any, any),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveOnboardingSettings(true, true, true);

          // ASSERT
          expect(success, true);
          verify(
            mockDatabaseService.saveSettingsOnboarding(true, true, true),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets('Should return false When database fails to save settings', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.saveSettingsOnboarding(any, any, any),
        ).thenAnswer((_) async => 0);

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final success = await container
            .read(settingsControllerProvider.notifier)
            .saveOnboardingSettings(true, true, true);

        // ASSERT
        expect(success, false);
        verify(
          mockDatabaseService.saveSettingsOnboarding(true, true, true),
        ).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should handle error When database throws exception', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.saveSettingsOnboarding(any, any, any),
        ).thenThrow(Exception('Database error'));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container
              .read(settingsControllerProvider.notifier)
              .saveOnboardingSettings(true, true, true),
          throwsException,
        );

        verify(
          mockDatabaseService.saveSettingsOnboarding(true, true, true),
        ).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('saveUserSettings', () {
      testWidgets(
        'Should return true When database successfully saves weight units',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsUser(any, any, any),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveUserSettings(WeightUnits.metric, null, null);

          // ASSERT
          expect(success, true);
          verify(
            mockDatabaseService.saveSettingsUser(
              WeightUnits.metric,
              null,
              null,
            ),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should return true When database successfully saves analytics opt in',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsUser(any, any, any),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveUserSettings(null, true, null);

          // ASSERT
          expect(success, true);
          verify(
            mockDatabaseService.saveSettingsUser(null, true, null),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should return true When database successfully saves create journal entry',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsUser(any, any, any),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveUserSettings(null, null, false);

          // ASSERT
          expect(success, true);
          verify(
            mockDatabaseService.saveSettingsUser(null, null, false),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should return true When database successfully saves all settings',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsUser(any, any, any),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveUserSettings(WeightUnits.metric, true, false);

          // ASSERT
          expect(success, true);
          verify(
            mockDatabaseService.saveSettingsUser(
              WeightUnits.metric,
              true,
              false,
            ),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should return false When database fails to save user settings',
        (tester) async {
          // ARRANGE
          when(
            mockDatabaseService.saveSettingsUser(any, any, any),
          ).thenAnswer((_) async => 0);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final success = await container
              .read(settingsControllerProvider.notifier)
              .saveUserSettings(WeightUnits.imperial, true, true);

          // ASSERT
          expect(success, false);
          verify(
            mockDatabaseService.saveSettingsUser(
              WeightUnits.imperial,
              true,
              true,
            ),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets('Should handle null values', (tester) async {
        // ARRANGE
        when(
          mockDatabaseService.saveSettingsUser(null, null, null),
        ).thenAnswer((_) async => 1);

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final success = await container
            .read(settingsControllerProvider.notifier)
            .saveUserSettings(null, null, null);

        // ASSERT
        expect(success, true);
        verify(
          mockDatabaseService.saveSettingsUser(null, null, null),
        ).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });
  });
}
