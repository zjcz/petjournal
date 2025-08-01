// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsModel implements DiagnosticableTreeMixin {

 bool get acceptedTermsAndConditions; bool get optIntoAnalyticsWarning; bool get onBoardingComplete; String? get lastUsedVersion; WeightUnits get defaultWeightUnit; bool get createLinkedJournalEntries;
/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsModelCopyWith<SettingsModel> get copyWith => _$SettingsModelCopyWithImpl<SettingsModel>(this as SettingsModel, _$identity);

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettingsModel'))
    ..add(DiagnosticsProperty('acceptedTermsAndConditions', acceptedTermsAndConditions))..add(DiagnosticsProperty('optIntoAnalyticsWarning', optIntoAnalyticsWarning))..add(DiagnosticsProperty('onBoardingComplete', onBoardingComplete))..add(DiagnosticsProperty('lastUsedVersion', lastUsedVersion))..add(DiagnosticsProperty('defaultWeightUnit', defaultWeightUnit))..add(DiagnosticsProperty('createLinkedJournalEntries', createLinkedJournalEntries));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsModel&&(identical(other.acceptedTermsAndConditions, acceptedTermsAndConditions) || other.acceptedTermsAndConditions == acceptedTermsAndConditions)&&(identical(other.optIntoAnalyticsWarning, optIntoAnalyticsWarning) || other.optIntoAnalyticsWarning == optIntoAnalyticsWarning)&&(identical(other.onBoardingComplete, onBoardingComplete) || other.onBoardingComplete == onBoardingComplete)&&(identical(other.lastUsedVersion, lastUsedVersion) || other.lastUsedVersion == lastUsedVersion)&&(identical(other.defaultWeightUnit, defaultWeightUnit) || other.defaultWeightUnit == defaultWeightUnit)&&(identical(other.createLinkedJournalEntries, createLinkedJournalEntries) || other.createLinkedJournalEntries == createLinkedJournalEntries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,acceptedTermsAndConditions,optIntoAnalyticsWarning,onBoardingComplete,lastUsedVersion,defaultWeightUnit,createLinkedJournalEntries);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettingsModel(acceptedTermsAndConditions: $acceptedTermsAndConditions, optIntoAnalyticsWarning: $optIntoAnalyticsWarning, onBoardingComplete: $onBoardingComplete, lastUsedVersion: $lastUsedVersion, defaultWeightUnit: $defaultWeightUnit, createLinkedJournalEntries: $createLinkedJournalEntries)';
}


}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res>  {
  factory $SettingsModelCopyWith(SettingsModel value, $Res Function(SettingsModel) _then) = _$SettingsModelCopyWithImpl;
@useResult
$Res call({
 bool acceptedTermsAndConditions, bool optIntoAnalyticsWarning, bool onBoardingComplete, String? lastUsedVersion, WeightUnits defaultWeightUnit, bool createLinkedJournalEntries
});




}
/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  final SettingsModel _self;
  final $Res Function(SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? acceptedTermsAndConditions = null,Object? optIntoAnalyticsWarning = null,Object? onBoardingComplete = null,Object? lastUsedVersion = freezed,Object? defaultWeightUnit = null,Object? createLinkedJournalEntries = null,}) {
  return _then(_self.copyWith(
acceptedTermsAndConditions: null == acceptedTermsAndConditions ? _self.acceptedTermsAndConditions : acceptedTermsAndConditions // ignore: cast_nullable_to_non_nullable
as bool,optIntoAnalyticsWarning: null == optIntoAnalyticsWarning ? _self.optIntoAnalyticsWarning : optIntoAnalyticsWarning // ignore: cast_nullable_to_non_nullable
as bool,onBoardingComplete: null == onBoardingComplete ? _self.onBoardingComplete : onBoardingComplete // ignore: cast_nullable_to_non_nullable
as bool,lastUsedVersion: freezed == lastUsedVersion ? _self.lastUsedVersion : lastUsedVersion // ignore: cast_nullable_to_non_nullable
as String?,defaultWeightUnit: null == defaultWeightUnit ? _self.defaultWeightUnit : defaultWeightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnits,createLinkedJournalEntries: null == createLinkedJournalEntries ? _self.createLinkedJournalEntries : createLinkedJournalEntries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SettingsModel with DiagnosticableTreeMixin implements SettingsModel {
  const _SettingsModel({required this.acceptedTermsAndConditions, required this.optIntoAnalyticsWarning, required this.onBoardingComplete, required this.lastUsedVersion, required this.defaultWeightUnit, required this.createLinkedJournalEntries});
  factory _SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

@override final  bool acceptedTermsAndConditions;
@override final  bool optIntoAnalyticsWarning;
@override final  bool onBoardingComplete;
@override final  String? lastUsedVersion;
@override final  WeightUnits defaultWeightUnit;
@override final  bool createLinkedJournalEntries;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsModelCopyWith<_SettingsModel> get copyWith => __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettingsModel'))
    ..add(DiagnosticsProperty('acceptedTermsAndConditions', acceptedTermsAndConditions))..add(DiagnosticsProperty('optIntoAnalyticsWarning', optIntoAnalyticsWarning))..add(DiagnosticsProperty('onBoardingComplete', onBoardingComplete))..add(DiagnosticsProperty('lastUsedVersion', lastUsedVersion))..add(DiagnosticsProperty('defaultWeightUnit', defaultWeightUnit))..add(DiagnosticsProperty('createLinkedJournalEntries', createLinkedJournalEntries));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsModel&&(identical(other.acceptedTermsAndConditions, acceptedTermsAndConditions) || other.acceptedTermsAndConditions == acceptedTermsAndConditions)&&(identical(other.optIntoAnalyticsWarning, optIntoAnalyticsWarning) || other.optIntoAnalyticsWarning == optIntoAnalyticsWarning)&&(identical(other.onBoardingComplete, onBoardingComplete) || other.onBoardingComplete == onBoardingComplete)&&(identical(other.lastUsedVersion, lastUsedVersion) || other.lastUsedVersion == lastUsedVersion)&&(identical(other.defaultWeightUnit, defaultWeightUnit) || other.defaultWeightUnit == defaultWeightUnit)&&(identical(other.createLinkedJournalEntries, createLinkedJournalEntries) || other.createLinkedJournalEntries == createLinkedJournalEntries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,acceptedTermsAndConditions,optIntoAnalyticsWarning,onBoardingComplete,lastUsedVersion,defaultWeightUnit,createLinkedJournalEntries);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettingsModel(acceptedTermsAndConditions: $acceptedTermsAndConditions, optIntoAnalyticsWarning: $optIntoAnalyticsWarning, onBoardingComplete: $onBoardingComplete, lastUsedVersion: $lastUsedVersion, defaultWeightUnit: $defaultWeightUnit, createLinkedJournalEntries: $createLinkedJournalEntries)';
}


}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res> implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(_SettingsModel value, $Res Function(_SettingsModel) _then) = __$SettingsModelCopyWithImpl;
@override @useResult
$Res call({
 bool acceptedTermsAndConditions, bool optIntoAnalyticsWarning, bool onBoardingComplete, String? lastUsedVersion, WeightUnits defaultWeightUnit, bool createLinkedJournalEntries
});




}
/// @nodoc
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? acceptedTermsAndConditions = null,Object? optIntoAnalyticsWarning = null,Object? onBoardingComplete = null,Object? lastUsedVersion = freezed,Object? defaultWeightUnit = null,Object? createLinkedJournalEntries = null,}) {
  return _then(_SettingsModel(
acceptedTermsAndConditions: null == acceptedTermsAndConditions ? _self.acceptedTermsAndConditions : acceptedTermsAndConditions // ignore: cast_nullable_to_non_nullable
as bool,optIntoAnalyticsWarning: null == optIntoAnalyticsWarning ? _self.optIntoAnalyticsWarning : optIntoAnalyticsWarning // ignore: cast_nullable_to_non_nullable
as bool,onBoardingComplete: null == onBoardingComplete ? _self.onBoardingComplete : onBoardingComplete // ignore: cast_nullable_to_non_nullable
as bool,lastUsedVersion: freezed == lastUsedVersion ? _self.lastUsedVersion : lastUsedVersion // ignore: cast_nullable_to_non_nullable
as String?,defaultWeightUnit: null == defaultWeightUnit ? _self.defaultWeightUnit : defaultWeightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnits,createLinkedJournalEntries: null == createLinkedJournalEntries ? _self.createLinkedJournalEntries : createLinkedJournalEntries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
