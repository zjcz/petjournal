// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_weight_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetWeightModel implements DiagnosticableTreeMixin {

 int? get petWeightId; int? get petId; DateTime get date; double get weight; WeightUnits get weightUnit; String? get notes;
/// Create a copy of PetWeightModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetWeightModelCopyWith<PetWeightModel> get copyWith => _$PetWeightModelCopyWithImpl<PetWeightModel>(this as PetWeightModel, _$identity);

  /// Serializes this PetWeightModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetWeightModel'))
    ..add(DiagnosticsProperty('petWeightId', petWeightId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('weight', weight))..add(DiagnosticsProperty('weightUnit', weightUnit))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetWeightModel&&(identical(other.petWeightId, petWeightId) || other.petWeightId == petWeightId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.weightUnit, weightUnit) || other.weightUnit == weightUnit)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petWeightId,petId,date,weight,weightUnit,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetWeightModel(petWeightId: $petWeightId, petId: $petId, date: $date, weight: $weight, weightUnit: $weightUnit, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PetWeightModelCopyWith<$Res>  {
  factory $PetWeightModelCopyWith(PetWeightModel value, $Res Function(PetWeightModel) _then) = _$PetWeightModelCopyWithImpl;
@useResult
$Res call({
 int? petWeightId, int? petId, DateTime date, double weight, WeightUnits weightUnit, String? notes
});




}
/// @nodoc
class _$PetWeightModelCopyWithImpl<$Res>
    implements $PetWeightModelCopyWith<$Res> {
  _$PetWeightModelCopyWithImpl(this._self, this._then);

  final PetWeightModel _self;
  final $Res Function(PetWeightModel) _then;

/// Create a copy of PetWeightModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petWeightId = freezed,Object? petId = freezed,Object? date = null,Object? weight = null,Object? weightUnit = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
petWeightId: freezed == petWeightId ? _self.petWeightId : petWeightId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,weightUnit: null == weightUnit ? _self.weightUnit : weightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnits,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetWeightModel with DiagnosticableTreeMixin implements PetWeightModel {
  const _PetWeightModel({this.petWeightId, this.petId, required this.date, required this.weight, required this.weightUnit, this.notes});
  factory _PetWeightModel.fromJson(Map<String, dynamic> json) => _$PetWeightModelFromJson(json);

@override final  int? petWeightId;
@override final  int? petId;
@override final  DateTime date;
@override final  double weight;
@override final  WeightUnits weightUnit;
@override final  String? notes;

/// Create a copy of PetWeightModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetWeightModelCopyWith<_PetWeightModel> get copyWith => __$PetWeightModelCopyWithImpl<_PetWeightModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetWeightModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetWeightModel'))
    ..add(DiagnosticsProperty('petWeightId', petWeightId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('date', date))..add(DiagnosticsProperty('weight', weight))..add(DiagnosticsProperty('weightUnit', weightUnit))..add(DiagnosticsProperty('notes', notes));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetWeightModel&&(identical(other.petWeightId, petWeightId) || other.petWeightId == petWeightId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.weightUnit, weightUnit) || other.weightUnit == weightUnit)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petWeightId,petId,date,weight,weightUnit,notes);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetWeightModel(petWeightId: $petWeightId, petId: $petId, date: $date, weight: $weight, weightUnit: $weightUnit, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PetWeightModelCopyWith<$Res> implements $PetWeightModelCopyWith<$Res> {
  factory _$PetWeightModelCopyWith(_PetWeightModel value, $Res Function(_PetWeightModel) _then) = __$PetWeightModelCopyWithImpl;
@override @useResult
$Res call({
 int? petWeightId, int? petId, DateTime date, double weight, WeightUnits weightUnit, String? notes
});




}
/// @nodoc
class __$PetWeightModelCopyWithImpl<$Res>
    implements _$PetWeightModelCopyWith<$Res> {
  __$PetWeightModelCopyWithImpl(this._self, this._then);

  final _PetWeightModel _self;
  final $Res Function(_PetWeightModel) _then;

/// Create a copy of PetWeightModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petWeightId = freezed,Object? petId = freezed,Object? date = null,Object? weight = null,Object? weightUnit = null,Object? notes = freezed,}) {
  return _then(_PetWeightModel(
petWeightId: freezed == petWeightId ? _self.petWeightId : petWeightId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,weightUnit: null == weightUnit ? _self.weightUnit : weightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnits,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
