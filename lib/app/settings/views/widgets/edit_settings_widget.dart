import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/widgets/analytics_opt_in.dart';
import 'package:petjournal/widgets/custom_switch.dart';
import 'package:petjournal/widgets/weight_units_dropdown.dart';

class EditSettingsWidget extends ConsumerStatefulWidget {
  static const editDefaultWeightUnit = Key('weightUnit');
  static const editSettingOptIntoAnalyticsKey = Key('optIntoAnalytics');
  static const editSettingCreateLinkedJournalEntriesKey = Key(
    'createLinkedJournalEntries',
  );

  final EditSettingsData userSettings;
  final Function(EditSettingsData) onChanged;

  const EditSettingsWidget({
    super.key,
    required this.userSettings,
    required this.onChanged,
  });

  @override
  ConsumerState<EditSettingsWidget> createState() => _EditSettingsWidgetState();
}

class _EditSettingsWidgetState extends ConsumerState<EditSettingsWidget> {
  WeightUnits? _weightUnits;
  bool _optIntoAnalyticsWarning = false;
  bool _createLinkedJournalEntries = true;

  @override
  void initState() {
    super.initState();

    _weightUnits = widget.userSettings.weightUnits;
    _optIntoAnalyticsWarning = widget.userSettings.optIntoAnalyticsWarning;
    _createLinkedJournalEntries =
        widget.userSettings.createLinkedJournalEntries;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20.0,
      children: [
        WeightUnitsDropdown(
          value: _weightUnits,
          labelText: 'Default Weight Units',
          onChanged: (val) {
            _weightUnits = val;
            _triggerOnChange();
          },
        ),
        AnalyticsOptIn(
          key: EditSettingsWidget.editSettingOptIntoAnalyticsKey,
          optIntoAnalyticsValue: _optIntoAnalyticsWarning,
          onChanged: (newValue) {
            setState(() {
              _optIntoAnalyticsWarning = newValue;
            });
            _triggerOnChange();
          },
        ),
        CustomSwitch(
          key: EditSettingsWidget.editSettingCreateLinkedJournalEntriesKey,
          switchValue: _createLinkedJournalEntries,
          labelText: 'Create Linked Journal Entries',
          onChanged: (newValue) {
            setState(() {
              _createLinkedJournalEntries = newValue;
            });
            _triggerOnChange();
          },
        ),
      ],
    );
  }

  void _triggerOnChange() {
    widget.onChanged(
      EditSettingsData(
        weightUnits: _weightUnits,
        optIntoAnalyticsWarning: _optIntoAnalyticsWarning,
        createLinkedJournalEntries: _createLinkedJournalEntries,
      ),
    );
  }
}

class EditSettingsData {
  final WeightUnits? weightUnits;
  final bool optIntoAnalyticsWarning;
  final bool createLinkedJournalEntries;

  EditSettingsData({
    required this.weightUnits,
    required this.optIntoAnalyticsWarning,
    required this.createLinkedJournalEntries,
  });
}
