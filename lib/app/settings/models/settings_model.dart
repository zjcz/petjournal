import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:petjournal/constants/weight_units.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

/// All settings for the app.
@freezed
abstract class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required bool acceptedTermsAndConditions,
    required bool optIntoAnalyticsWarning,
    required bool onBoardingComplete,
    required String? lastUsedVersion,
    required WeightUnits defaultWeightUnit,
    required bool createLinkedJournalEntries,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, Object?> json) =>
      _$SettingsModelFromJson(json);
}
