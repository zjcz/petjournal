import 'package:petjournal/constants/defaults.dart' as defaults;
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/lookups/settings_lookup.dart';

class SettingsHelper {
  static bool isMetric() {
    var currentWeightUnit = SettingsLookup().getSettings()?.defaultWeightUnit;
    currentWeightUnit ??= defaults.getDefaultWeightUnit();
    return currentWeightUnit == WeightUnits.metric;
  }

  static bool createLinkedJournalEntries() {
    var settings = SettingsLookup().getSettings();
    return settings?.createLinkedJournalEntries ?? true;
  }
}
