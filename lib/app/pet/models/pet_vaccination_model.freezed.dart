// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_vaccination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetVaccinationModel implements DiagnosticableTreeMixin {

 int? get petVaccinationId; int get petId; String get name; DateTime get administeredDate; DateTime? get expiryDate; DateTime? get reminderDate; String? get notes; String get vaccineBatchNumber; String get vaccineManufacturer; String get administeredBy;
/// Create a copy of PetVaccinationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetVaccinationModelCopyWith<PetVaccinationModel> get copyWith => _$PetVaccinationModelCopyWithImpl<PetVaccinationModel>(this as PetVaccinationModel, _$identity);

  /// Serializes this PetVaccinationModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetVaccinationModel'))
    ..add(DiagnosticsProperty('petVaccinationId', petVaccinationId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('administeredDate', administeredDate))..add(DiagnosticsProperty('expiryDate', expiryDate))..add(DiagnosticsProperty('reminderDate', reminderDate))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('vaccineBatchNumber', vaccineBatchNumber))..add(DiagnosticsProperty('vaccineManufacturer', vaccineManufacturer))..add(DiagnosticsProperty('administeredBy', administeredBy));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetVaccinationModel&&(identical(other.petVaccinationId, petVaccinationId) || other.petVaccinationId == petVaccinationId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.administeredDate, administeredDate) || other.administeredDate == administeredDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.reminderDate, reminderDate) || other.reminderDate == reminderDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.vaccineBatchNumber, vaccineBatchNumber) || other.vaccineBatchNumber == vaccineBatchNumber)&&(identical(other.vaccineManufacturer, vaccineManufacturer) || other.vaccineManufacturer == vaccineManufacturer)&&(identical(other.administeredBy, administeredBy) || other.administeredBy == administeredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petVaccinationId,petId,name,administeredDate,expiryDate,reminderDate,notes,vaccineBatchNumber,vaccineManufacturer,administeredBy);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetVaccinationModel(petVaccinationId: $petVaccinationId, petId: $petId, name: $name, administeredDate: $administeredDate, expiryDate: $expiryDate, reminderDate: $reminderDate, notes: $notes, vaccineBatchNumber: $vaccineBatchNumber, vaccineManufacturer: $vaccineManufacturer, administeredBy: $administeredBy)';
}


}

/// @nodoc
abstract mixin class $PetVaccinationModelCopyWith<$Res>  {
  factory $PetVaccinationModelCopyWith(PetVaccinationModel value, $Res Function(PetVaccinationModel) _then) = _$PetVaccinationModelCopyWithImpl;
@useResult
$Res call({
 int? petVaccinationId, int petId, String name, DateTime administeredDate, DateTime? expiryDate, DateTime? reminderDate, String? notes, String vaccineBatchNumber, String vaccineManufacturer, String administeredBy
});




}
/// @nodoc
class _$PetVaccinationModelCopyWithImpl<$Res>
    implements $PetVaccinationModelCopyWith<$Res> {
  _$PetVaccinationModelCopyWithImpl(this._self, this._then);

  final PetVaccinationModel _self;
  final $Res Function(PetVaccinationModel) _then;

/// Create a copy of PetVaccinationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petVaccinationId = freezed,Object? petId = null,Object? name = null,Object? administeredDate = null,Object? expiryDate = freezed,Object? reminderDate = freezed,Object? notes = freezed,Object? vaccineBatchNumber = null,Object? vaccineManufacturer = null,Object? administeredBy = null,}) {
  return _then(_self.copyWith(
petVaccinationId: freezed == petVaccinationId ? _self.petVaccinationId : petVaccinationId // ignore: cast_nullable_to_non_nullable
as int?,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,administeredDate: null == administeredDate ? _self.administeredDate : administeredDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderDate: freezed == reminderDate ? _self.reminderDate : reminderDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,vaccineBatchNumber: null == vaccineBatchNumber ? _self.vaccineBatchNumber : vaccineBatchNumber // ignore: cast_nullable_to_non_nullable
as String,vaccineManufacturer: null == vaccineManufacturer ? _self.vaccineManufacturer : vaccineManufacturer // ignore: cast_nullable_to_non_nullable
as String,administeredBy: null == administeredBy ? _self.administeredBy : administeredBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetVaccinationModel with DiagnosticableTreeMixin implements PetVaccinationModel {
  const _PetVaccinationModel({this.petVaccinationId, required this.petId, required this.name, required this.administeredDate, this.expiryDate, this.reminderDate, this.notes, required this.vaccineBatchNumber, required this.vaccineManufacturer, required this.administeredBy});
  factory _PetVaccinationModel.fromJson(Map<String, dynamic> json) => _$PetVaccinationModelFromJson(json);

@override final  int? petVaccinationId;
@override final  int petId;
@override final  String name;
@override final  DateTime administeredDate;
@override final  DateTime? expiryDate;
@override final  DateTime? reminderDate;
@override final  String? notes;
@override final  String vaccineBatchNumber;
@override final  String vaccineManufacturer;
@override final  String administeredBy;

/// Create a copy of PetVaccinationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetVaccinationModelCopyWith<_PetVaccinationModel> get copyWith => __$PetVaccinationModelCopyWithImpl<_PetVaccinationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetVaccinationModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetVaccinationModel'))
    ..add(DiagnosticsProperty('petVaccinationId', petVaccinationId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('administeredDate', administeredDate))..add(DiagnosticsProperty('expiryDate', expiryDate))..add(DiagnosticsProperty('reminderDate', reminderDate))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('vaccineBatchNumber', vaccineBatchNumber))..add(DiagnosticsProperty('vaccineManufacturer', vaccineManufacturer))..add(DiagnosticsProperty('administeredBy', administeredBy));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetVaccinationModel&&(identical(other.petVaccinationId, petVaccinationId) || other.petVaccinationId == petVaccinationId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.administeredDate, administeredDate) || other.administeredDate == administeredDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.reminderDate, reminderDate) || other.reminderDate == reminderDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.vaccineBatchNumber, vaccineBatchNumber) || other.vaccineBatchNumber == vaccineBatchNumber)&&(identical(other.vaccineManufacturer, vaccineManufacturer) || other.vaccineManufacturer == vaccineManufacturer)&&(identical(other.administeredBy, administeredBy) || other.administeredBy == administeredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petVaccinationId,petId,name,administeredDate,expiryDate,reminderDate,notes,vaccineBatchNumber,vaccineManufacturer,administeredBy);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetVaccinationModel(petVaccinationId: $petVaccinationId, petId: $petId, name: $name, administeredDate: $administeredDate, expiryDate: $expiryDate, reminderDate: $reminderDate, notes: $notes, vaccineBatchNumber: $vaccineBatchNumber, vaccineManufacturer: $vaccineManufacturer, administeredBy: $administeredBy)';
}


}

/// @nodoc
abstract mixin class _$PetVaccinationModelCopyWith<$Res> implements $PetVaccinationModelCopyWith<$Res> {
  factory _$PetVaccinationModelCopyWith(_PetVaccinationModel value, $Res Function(_PetVaccinationModel) _then) = __$PetVaccinationModelCopyWithImpl;
@override @useResult
$Res call({
 int? petVaccinationId, int petId, String name, DateTime administeredDate, DateTime? expiryDate, DateTime? reminderDate, String? notes, String vaccineBatchNumber, String vaccineManufacturer, String administeredBy
});




}
/// @nodoc
class __$PetVaccinationModelCopyWithImpl<$Res>
    implements _$PetVaccinationModelCopyWith<$Res> {
  __$PetVaccinationModelCopyWithImpl(this._self, this._then);

  final _PetVaccinationModel _self;
  final $Res Function(_PetVaccinationModel) _then;

/// Create a copy of PetVaccinationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petVaccinationId = freezed,Object? petId = null,Object? name = null,Object? administeredDate = null,Object? expiryDate = freezed,Object? reminderDate = freezed,Object? notes = freezed,Object? vaccineBatchNumber = null,Object? vaccineManufacturer = null,Object? administeredBy = null,}) {
  return _then(_PetVaccinationModel(
petVaccinationId: freezed == petVaccinationId ? _self.petVaccinationId : petVaccinationId // ignore: cast_nullable_to_non_nullable
as int?,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,administeredDate: null == administeredDate ? _self.administeredDate : administeredDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderDate: freezed == reminderDate ? _self.reminderDate : reminderDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,vaccineBatchNumber: null == vaccineBatchNumber ? _self.vaccineBatchNumber : vaccineBatchNumber // ignore: cast_nullable_to_non_nullable
as String,vaccineManufacturer: null == vaccineManufacturer ? _self.vaccineManufacturer : vaccineManufacturer // ignore: cast_nullable_to_non_nullable
as String,administeredBy: null == administeredBy ? _self.administeredBy : administeredBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
