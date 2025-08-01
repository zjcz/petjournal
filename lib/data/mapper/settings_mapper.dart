import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/app/settings/models/settings_model.dart';

class SettingsMapper {
  static SettingsModel mapToModel(Setting? settings) {
    if (settings == null) {
      return SettingsModel(
        acceptedTermsAndConditions: false,
        optIntoAnalyticsWarning: false,
        onBoardingComplete: false,
        lastUsedVersion: null,
        defaultWeightUnit: WeightUnits.metric,
        createLinkedJournalEntries: true,
      );
    }

    // Map the Setting object to SettingsModel
    return SettingsModel(
      acceptedTermsAndConditions: settings.acceptedTermsAndConditions,
      optIntoAnalyticsWarning: settings.optIntoAnalyticsWarning,
      onBoardingComplete: settings.onBoardingComplete,
      lastUsedVersion: settings.lastUsedVersion,
      defaultWeightUnit: settings.defaultWeightUnit,
      createLinkedJournalEntries: settings.createLinkedJournalEntries,
    );
  }
}
