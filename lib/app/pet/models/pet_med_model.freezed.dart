// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_med_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetMedModel implements DiagnosticableTreeMixin {

 int? get petMedId; int get petId; String get name; int get frequency; FrequencyType get frequencyType; double get doseUnit; MedType get medType; DateTime get startDate; DateTime? get endDate; String? get notes;
/// Create a copy of PetMedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetMedModelCopyWith<PetMedModel> get copyWith => _$PetMedModelCopyWithImpl<PetMedModel>(this as PetMedModel, _$identity);

  /// Serializes this PetMedModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetMedModel'))
    ..add(DiagnosticsProperty('petMedId', petMedId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('frequency', frequency))..add(DiagnosticsProperty('frequencyType', frequencyType))..add(DiagnosticsProperty('doseUnit', doseUnit))..add(DiagnosticsProperty('medType', medType))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('endDate', endDate))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetMedModel&&(identical(other.petMedId, petMedId) || other.petMedId == petMedId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.frequencyType, frequencyType) || other.frequencyType == frequencyType)&&(identical(other.doseUnit, doseUnit) || other.doseUnit == doseUnit)&&(identical(other.medType, medType) || other.medType == medType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMedId,petId,name,frequency,frequencyType,doseUnit,medType,startDate,endDate,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMedModel(petMedId: $petMedId, petId: $petId, name: $name, frequency: $frequency, frequencyType: $frequencyType, doseUnit: $doseUnit, medType: $medType, startDate: $startDate, endDate: $endDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PetMedModelCopyWith<$Res>  {
  factory $PetMedModelCopyWith(PetMedModel value, $Res Function(PetMedModel) _then) = _$PetMedModelCopyWithImpl;
@useResult
$Res call({
 int? petMedId, int petId, String name, int frequency, FrequencyType frequencyType, double doseUnit, MedType medType, DateTime startDate, DateTime? endDate, String? notes
});




}
/// @nodoc
class _$PetMedModelCopyWithImpl<$Res>
    implements $PetMedModelCopyWith<$Res> {
  _$PetMedModelCopyWithImpl(this._self, this._then);

  final PetMedModel _self;
  final $Res Function(PetMedModel) _then;

/// Create a copy of PetMedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petMedId = freezed,Object? petId = null,Object? name = null,Object? frequency = null,Object? frequencyType = null,Object? doseUnit = null,Object? medType = null,Object? startDate = null,Object? endDate = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
petMedId: freezed == petMedId ? _self.petMedId : petMedId // ignore: cast_nullable_to_non_nullable
as int?,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as int,frequencyType: null == frequencyType ? _self.frequencyType : frequencyType // ignore: cast_nullable_to_non_nullable
as FrequencyType,doseUnit: null == doseUnit ? _self.doseUnit : doseUnit // ignore: cast_nullable_to_non_nullable
as double,medType: null == medType ? _self.medType : medType // ignore: cast_nullable_to_non_nullable
as MedType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetMedModel with DiagnosticableTreeMixin implements PetMedModel {
  const _PetMedModel({this.petMedId, required this.petId, required this.name, required this.frequency, required this.frequencyType, required this.doseUnit, required this.medType, required this.startDate, this.endDate, this.notes});
  factory _PetMedModel.fromJson(Map<String, dynamic> json) => _$PetMedModelFromJson(json);

@override final  int? petMedId;
@override final  int petId;
@override final  String name;
@override final  int frequency;
@override final  FrequencyType frequencyType;
@override final  double doseUnit;
@override final  MedType medType;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  String? notes;

/// Create a copy of PetMedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetMedModelCopyWith<_PetMedModel> get copyWith => __$PetMedModelCopyWithImpl<_PetMedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetMedModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetMedModel'))
    ..add(DiagnosticsProperty('petMedId', petMedId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('frequency', frequency))..add(DiagnosticsProperty('frequencyType', frequencyType))..add(DiagnosticsProperty('doseUnit', doseUnit))..add(DiagnosticsProperty('medType', medType))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('endDate', endDate))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetMedModel&&(identical(other.petMedId, petMedId) || other.petMedId == petMedId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.frequencyType, frequencyType) || other.frequencyType == frequencyType)&&(identical(other.doseUnit, doseUnit) || other.doseUnit == doseUnit)&&(identical(other.medType, medType) || other.medType == medType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMedId,petId,name,frequency,frequencyType,doseUnit,medType,startDate,endDate,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMedModel(petMedId: $petMedId, petId: $petId, name: $name, frequency: $frequency, frequencyType: $frequencyType, doseUnit: $doseUnit, medType: $medType, startDate: $startDate, endDate: $endDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PetMedModelCopyWith<$Res> implements $PetMedModelCopyWith<$Res> {
  factory _$PetMedModelCopyWith(_PetMedModel value, $Res Function(_PetMedModel) _then) = __$PetMedModelCopyWithImpl;
@override @useResult
$Res call({
 int? petMedId, int petId, String name, int frequency, FrequencyType frequencyType, double doseUnit, MedType medType, DateTime startDate, DateTime? endDate, String? notes
});




}
/// @nodoc
class __$PetMedModelCopyWithImpl<$Res>
    implements _$PetMedModelCopyWith<$Res> {
  __$PetMedModelCopyWithImpl(this._self, this._then);

  final _PetMedModel _self;
  final $Res Function(_PetMedModel) _then;

/// Create a copy of PetMedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petMedId = freezed,Object? petId = null,Object? name = null,Object? frequency = null,Object? frequencyType = null,Object? doseUnit = null,Object? medType = null,Object? startDate = null,Object? endDate = freezed,Object? notes = freezed,}) {
  return _then(_PetMedModel(
petMedId: freezed == petMedId ? _self.petMedId : petMedId // ignore: cast_nullable_to_non_nullable
as int?,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as int,frequencyType: null == frequencyType ? _self.frequencyType : frequencyType // ignore: cast_nullable_to_non_nullable
as FrequencyType,doseUnit: null == doseUnit ? _self.doseUnit : doseUnit // ignore: cast_nullable_to_non_nullable
as double,medType: null == medType ? _self.medType : medType // ignore: cast_nullable_to_non_nullable
as MedType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
