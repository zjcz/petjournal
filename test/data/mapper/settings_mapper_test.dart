import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/settings_mapper.dart';

void main() {
  group('SettingsMapper Tests', () {
    test('mapToModel should return default settings when input is null', () {
      // Arrange
      const Setting? settings = null;

      // Act
      final model = SettingsMapper.mapToModel(settings);

      // Assert
      expect(model.acceptedTermsAndConditions, equals(false));
      expect(model.optIntoAnalyticsWarning, equals(false));
      expect(model.onBoardingComplete, equals(false));
      expect(model.lastUsedVersion, match.isNull);
      expect(model.defaultWeightUnit, match.isNull);
    });

    test('mapToModel should correctly map all Setting fields to SettingsModel', () {
      // Arrange
      final settings = Setting(
        settingsId: 1,
        acceptedTermsAndConditions: true,
        optIntoAnalyticsWarning: true,
        onBoardingComplete: true,
        lastUsedVersion: '1.0.0',
        defaultWeightUnit: WeightUnits.metric.dataValue,
      );

      // Act
      final model = SettingsMapper.mapToModel(settings);

      // Assert
      expect(model.acceptedTermsAndConditions, equals(true));
      expect(model.optIntoAnalyticsWarning, equals(true));
      expect(model.onBoardingComplete, equals(true));
      expect(model.lastUsedVersion, equals('1.0.0'));
      expect(model.defaultWeightUnit, equals(WeightUnits.metric));
    });

    test('mapToModel should handle null weight unit', () {
      // Arrange
      final settings = Setting(
        settingsId: 1,
        acceptedTermsAndConditions: true,
        optIntoAnalyticsWarning: true,
        onBoardingComplete: true,
        lastUsedVersion: '1.0.0',
        defaultWeightUnit: null,
      );

      // Act
      final model = SettingsMapper.mapToModel(settings);

      // Assert
      expect(model.defaultWeightUnit, match.isNull);
    });

    test('mapToModel should correctly map all weight unit values', () {
      // Arrange & Act & Assert
      for (final weightUnit in WeightUnits.values) {
        final settings = Setting(
          settingsId: 1,
          acceptedTermsAndConditions: false,
          optIntoAnalyticsWarning: false,
          onBoardingComplete: false,
          lastUsedVersion: null,
          defaultWeightUnit: weightUnit.dataValue,
        );

        final model = SettingsMapper.mapToModel(settings);
        expect(model.defaultWeightUnit, equals(weightUnit));
      }
    });

    test('mapToModel should preserve empty string in lastUsedVersion', () {
      // Arrange
      final settings = Setting(
        settingsId: 1,
        acceptedTermsAndConditions: false,
        optIntoAnalyticsWarning: false,
        onBoardingComplete: false,
        lastUsedVersion: '',
        defaultWeightUnit: null,
      );

      // Act
      final model = SettingsMapper.mapToModel(settings);

      // Assert
      expect(model.lastUsedVersion, equals(''));
    });
  });
}
