// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    _SettingsModel(
      acceptedTermsAndConditions: json['acceptedTermsAndConditions'] as bool,
      optIntoAnalyticsWarning: json['optIntoAnalyticsWarning'] as bool,
      onBoardingComplete: json['onBoardingComplete'] as bool,
      lastUsedVersion: json['lastUsedVersion'] as String?,
      defaultWeightUnit: $enumDecodeNullable(
        _$WeightUnitsEnumMap,
        json['defaultWeightUnit'],
      ),
    );

Map<String, dynamic> _$SettingsModelToJson(_SettingsModel instance) =>
    <String, dynamic>{
      'acceptedTermsAndConditions': instance.acceptedTermsAndConditions,
      'optIntoAnalyticsWarning': instance.optIntoAnalyticsWarning,
      'onBoardingComplete': instance.onBoardingComplete,
      'lastUsedVersion': instance.lastUsedVersion,
      'defaultWeightUnit': _$WeightUnitsEnumMap[instance.defaultWeightUnit],
    };

const _$WeightUnitsEnumMap = {
  WeightUnits.metric: 'metric',
  WeightUnits.imperial: 'imperial',
};
