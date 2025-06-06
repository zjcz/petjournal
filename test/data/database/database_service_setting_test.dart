import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/constants/defaults.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;

void main() {
  late DatabaseService database;

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    database = DatabaseService(inMemory);
  });

  tearDown(() => database.close());

  group('Settings Operations', () {
    test(
      'createDefaultSettings should create settings with default values',
      () async {
        // Arrange
        await database.createDefaultSettings();

        // Act
        final settings = await database.getSettings();

        // Assert
        expect(settings, match.isNotNull);
        expect(settings?.settingsId, equals(defaultSettingsId));
        expect(settings?.acceptedTermsAndConditions, equals(false));
        expect(settings?.onBoardingComplete, equals(false));
        expect(settings?.optIntoAnalyticsWarning, equals(false));
        expect(settings?.lastUsedVersion, match.isNull);
        expect(settings?.defaultWeightUnit, match.isNull);
      },
    );

    test('getSettings should return settings when they exist', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      final settings = await database.getSettings();

      // Assert
      expect(settings, match.isNotNull);
      expect(settings?.settingsId, equals(defaultSettingsId));
    });

    test('watchSettings should emit settings changes', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act & Assert
      expect(
        database.watchSettings(),
        emits(
          match
              .isA<Setting>()
              .having(
                (s) => s.settingsId,
                'settingsId',
                equals(defaultSettingsId),
              )
              .having(
                (s) => s.acceptedTermsAndConditions,
                'acceptedTermsAndConditions',
                equals(false),
              )
              .having(
                (s) => s.onBoardingComplete,
                'onBoardingComplete',
                equals(false),
              )
              .having(
                (s) => s.optIntoAnalyticsWarning,
                'optIntoAnalyticsWarning',
                equals(false),
              )
              .having((s) => s.lastUsedVersion, 'lastUsedVersion', match.isNull)
              .having(
                (s) => s.defaultWeightUnit,
                'defaultWeightUnit',
                match.isNull,
              ),
        ),
      );
    });

    test('saveSettingsOnboarding should update onboarding settings', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      final updateCount = await database.saveSettingsOnboarding(
        true,
        true,
        true,
      );

      // Assert
      expect(updateCount, equals(1));

      final settings = await database.getSettings();
      expect(settings?.acceptedTermsAndConditions, equals(true));
      expect(settings?.onBoardingComplete, equals(true));
      expect(settings?.optIntoAnalyticsWarning, equals(true));
    });

    test('saveSettingsUser should update weight unit', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      final updateCount = await database.saveSettingsUser(
        WeightUnits.metric,
        null,
      );

      // Assert
      expect(updateCount, equals(1));

      final settings = await database.getSettings();
      expect(settings?.defaultWeightUnit, equals(WeightUnits.metric.dataValue));
      expect(settings?.optIntoAnalyticsWarning, isFalse);
    });

    test('saveSettingsUser should update analytics opt in', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      final updateCount = await database.saveSettingsUser(null, true);

      // Assert
      expect(updateCount, equals(1));

      final settings = await database.getSettings();
      expect(settings?.defaultWeightUnit, match.isNull);
      expect(settings?.optIntoAnalyticsWarning, isTrue);
    });

    test('saveSettingsUser default weight should allow null', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      var updateCount = await database.saveSettingsUser(null, null);

      // Assert
      expect(updateCount, equals(1));

      final settings = await database.getSettings();
      expect(settings?.defaultWeightUnit, match.isNull);
      expect(settings?.optIntoAnalyticsWarning, match.isFalse);
    });

    test('resetSettingsUser should set settings to null', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act
      await database.saveSettingsUser(WeightUnits.metric, true);
      var updateCount = await database.resetSettingsUser();

      // Assert
      expect(updateCount, equals(1));

      final settings = await database.getSettings();
      expect(settings?.defaultWeightUnit, match.isNull);
      expect(settings?.optIntoAnalyticsWarning, match.isFalse);
    });

    test('createDefaultSettings should replace existing settings', () async {
      // Arrange
      final original = await database.createDefaultSettings();
      await database.saveSettingsOnboarding(true, true, true);

      // Act
      final replaced = await database.createDefaultSettings();

      // Assert
      expect(replaced.settingsId, equals(original.settingsId));
      expect(replaced.acceptedTermsAndConditions, equals(false));
      expect(replaced.onBoardingComplete, equals(false));
      expect(replaced.optIntoAnalyticsWarning, equals(false));
    });

    test('watchSettings should emit updated settings after changes', () async {
      // Arrange
      await database.createDefaultSettings();

      // Act & Assert
      final stream = database.watchSettings();

      // Verify initial state
      var settings = await stream.first;
      expect(settings?.acceptedTermsAndConditions, equals(false));

      // Update settings
      await database.saveSettingsOnboarding(true, false, false);

      // Verify updated state
      settings = await stream.first;
      expect(settings?.acceptedTermsAndConditions, equals(true));
    });
  });
}
