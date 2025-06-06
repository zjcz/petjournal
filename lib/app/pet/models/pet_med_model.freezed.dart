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

 int? get petMedId; int? get petId; String get name; String get dose; DateTime get startDate; DateTime? get endDate; String? get notes;
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
    ..add(DiagnosticsProperty('petMedId', petMedId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('dose', dose))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('endDate', endDate))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetMedModel&&(identical(other.petMedId, petMedId) || other.petMedId == petMedId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMedId,petId,name,dose,startDate,endDate,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMedModel(petMedId: $petMedId, petId: $petId, name: $name, dose: $dose, startDate: $startDate, endDate: $endDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PetMedModelCopyWith<$Res>  {
  factory $PetMedModelCopyWith(PetMedModel value, $Res Function(PetMedModel) _then) = _$PetMedModelCopyWithImpl;
@useResult
$Res call({
 int? petMedId, int? petId, String name, String dose, DateTime startDate, DateTime? endDate, String? notes
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
@pragma('vm:prefer-inline') @override $Res call({Object? petMedId = freezed,Object? petId = freezed,Object? name = null,Object? dose = null,Object? startDate = null,Object? endDate = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
petMedId: freezed == petMedId ? _self.petMedId : petMedId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetMedModel with DiagnosticableTreeMixin implements PetMedModel {
  const _PetMedModel({this.petMedId, this.petId, required this.name, required this.dose, required this.startDate, this.endDate, this.notes});
  factory _PetMedModel.fromJson(Map<String, dynamic> json) => _$PetMedModelFromJson(json);

@override final  int? petMedId;
@override final  int? petId;
@override final  String name;
@override final  String dose;
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
    ..add(DiagnosticsProperty('petMedId', petMedId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('dose', dose))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('endDate', endDate))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetMedModel&&(identical(other.petMedId, petMedId) || other.petMedId == petMedId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMedId,petId,name,dose,startDate,endDate,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMedModel(petMedId: $petMedId, petId: $petId, name: $name, dose: $dose, startDate: $startDate, endDate: $endDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PetMedModelCopyWith<$Res> implements $PetMedModelCopyWith<$Res> {
  factory _$PetMedModelCopyWith(_PetMedModel value, $Res Function(_PetMedModel) _then) = __$PetMedModelCopyWithImpl;
@override @useResult
$Res call({
 int? petMedId, int? petId, String name, String dose, DateTime startDate, DateTime? endDate, String? notes
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
@override @pragma('vm:prefer-inline') $Res call({Object? petMedId = freezed,Object? petId = freezed,Object? name = null,Object? dose = null,Object? startDate = null,Object? endDate = freezed,Object? notes = freezed,}) {
  return _then(_PetMedModel(
petMedId: freezed == petMedId ? _self.petMedId : petMedId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
