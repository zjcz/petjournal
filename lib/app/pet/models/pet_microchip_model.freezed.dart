// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_microchip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetMicrochipModel implements DiagnosticableTreeMixin {

 int? get petMicrochipId; int? get petId; bool get isMicrochipped; DateTime? get microchipDate; String? get microchipNotes; String? get microchipNumber; String? get microchipCompany;
/// Create a copy of PetMicrochipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetMicrochipModelCopyWith<PetMicrochipModel> get copyWith => _$PetMicrochipModelCopyWithImpl<PetMicrochipModel>(this as PetMicrochipModel, _$identity);

  /// Serializes this PetMicrochipModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetMicrochipModel'))
    ..add(DiagnosticsProperty('petMicrochipId', petMicrochipId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('isMicrochipped', isMicrochipped))..add(DiagnosticsProperty('microchipDate', microchipDate))..add(DiagnosticsProperty('microchipNotes', microchipNotes))..add(DiagnosticsProperty('microchipNumber', microchipNumber))..add(DiagnosticsProperty('microchipCompany', microchipCompany));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetMicrochipModel&&(identical(other.petMicrochipId, petMicrochipId) || other.petMicrochipId == petMicrochipId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.isMicrochipped, isMicrochipped) || other.isMicrochipped == isMicrochipped)&&(identical(other.microchipDate, microchipDate) || other.microchipDate == microchipDate)&&(identical(other.microchipNotes, microchipNotes) || other.microchipNotes == microchipNotes)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipCompany, microchipCompany) || other.microchipCompany == microchipCompany));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMicrochipId,petId,isMicrochipped,microchipDate,microchipNotes,microchipNumber,microchipCompany);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMicrochipModel(petMicrochipId: $petMicrochipId, petId: $petId, isMicrochipped: $isMicrochipped, microchipDate: $microchipDate, microchipNotes: $microchipNotes, microchipNumber: $microchipNumber, microchipCompany: $microchipCompany)';
}


}

/// @nodoc
abstract mixin class $PetMicrochipModelCopyWith<$Res>  {
  factory $PetMicrochipModelCopyWith(PetMicrochipModel value, $Res Function(PetMicrochipModel) _then) = _$PetMicrochipModelCopyWithImpl;
@useResult
$Res call({
 int? petMicrochipId, int? petId, bool isMicrochipped, DateTime? microchipDate, String? microchipNotes, String? microchipNumber, String? microchipCompany
});




}
/// @nodoc
class _$PetMicrochipModelCopyWithImpl<$Res>
    implements $PetMicrochipModelCopyWith<$Res> {
  _$PetMicrochipModelCopyWithImpl(this._self, this._then);

  final PetMicrochipModel _self;
  final $Res Function(PetMicrochipModel) _then;

/// Create a copy of PetMicrochipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petMicrochipId = freezed,Object? petId = freezed,Object? isMicrochipped = null,Object? microchipDate = freezed,Object? microchipNotes = freezed,Object? microchipNumber = freezed,Object? microchipCompany = freezed,}) {
  return _then(_self.copyWith(
petMicrochipId: freezed == petMicrochipId ? _self.petMicrochipId : petMicrochipId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,isMicrochipped: null == isMicrochipped ? _self.isMicrochipped : isMicrochipped // ignore: cast_nullable_to_non_nullable
as bool,microchipDate: freezed == microchipDate ? _self.microchipDate : microchipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,microchipNotes: freezed == microchipNotes ? _self.microchipNotes : microchipNotes // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipCompany: freezed == microchipCompany ? _self.microchipCompany : microchipCompany // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetMicrochipModel with DiagnosticableTreeMixin implements PetMicrochipModel {
  const _PetMicrochipModel({this.petMicrochipId, this.petId, required this.isMicrochipped, this.microchipDate, this.microchipNotes, this.microchipNumber, this.microchipCompany});
  factory _PetMicrochipModel.fromJson(Map<String, dynamic> json) => _$PetMicrochipModelFromJson(json);

@override final  int? petMicrochipId;
@override final  int? petId;
@override final  bool isMicrochipped;
@override final  DateTime? microchipDate;
@override final  String? microchipNotes;
@override final  String? microchipNumber;
@override final  String? microchipCompany;

/// Create a copy of PetMicrochipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetMicrochipModelCopyWith<_PetMicrochipModel> get copyWith => __$PetMicrochipModelCopyWithImpl<_PetMicrochipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetMicrochipModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetMicrochipModel'))
    ..add(DiagnosticsProperty('petMicrochipId', petMicrochipId))..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('isMicrochipped', isMicrochipped))..add(DiagnosticsProperty('microchipDate', microchipDate))..add(DiagnosticsProperty('microchipNotes', microchipNotes))..add(DiagnosticsProperty('microchipNumber', microchipNumber))..add(DiagnosticsProperty('microchipCompany', microchipCompany));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetMicrochipModel&&(identical(other.petMicrochipId, petMicrochipId) || other.petMicrochipId == petMicrochipId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.isMicrochipped, isMicrochipped) || other.isMicrochipped == isMicrochipped)&&(identical(other.microchipDate, microchipDate) || other.microchipDate == microchipDate)&&(identical(other.microchipNotes, microchipNotes) || other.microchipNotes == microchipNotes)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipCompany, microchipCompany) || other.microchipCompany == microchipCompany));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petMicrochipId,petId,isMicrochipped,microchipDate,microchipNotes,microchipNumber,microchipCompany);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetMicrochipModel(petMicrochipId: $petMicrochipId, petId: $petId, isMicrochipped: $isMicrochipped, microchipDate: $microchipDate, microchipNotes: $microchipNotes, microchipNumber: $microchipNumber, microchipCompany: $microchipCompany)';
}


}

/// @nodoc
abstract mixin class _$PetMicrochipModelCopyWith<$Res> implements $PetMicrochipModelCopyWith<$Res> {
  factory _$PetMicrochipModelCopyWith(_PetMicrochipModel value, $Res Function(_PetMicrochipModel) _then) = __$PetMicrochipModelCopyWithImpl;
@override @useResult
$Res call({
 int? petMicrochipId, int? petId, bool isMicrochipped, DateTime? microchipDate, String? microchipNotes, String? microchipNumber, String? microchipCompany
});




}
/// @nodoc
class __$PetMicrochipModelCopyWithImpl<$Res>
    implements _$PetMicrochipModelCopyWith<$Res> {
  __$PetMicrochipModelCopyWithImpl(this._self, this._then);

  final _PetMicrochipModel _self;
  final $Res Function(_PetMicrochipModel) _then;

/// Create a copy of PetMicrochipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petMicrochipId = freezed,Object? petId = freezed,Object? isMicrochipped = null,Object? microchipDate = freezed,Object? microchipNotes = freezed,Object? microchipNumber = freezed,Object? microchipCompany = freezed,}) {
  return _then(_PetMicrochipModel(
petMicrochipId: freezed == petMicrochipId ? _self.petMicrochipId : petMicrochipId // ignore: cast_nullable_to_non_nullable
as int?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,isMicrochipped: null == isMicrochipped ? _self.isMicrochipped : isMicrochipped // ignore: cast_nullable_to_non_nullable
as bool,microchipDate: freezed == microchipDate ? _self.microchipDate : microchipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,microchipNotes: freezed == microchipNotes ? _self.microchipNotes : microchipNotes // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipCompany: freezed == microchipCompany ? _self.microchipCompany : microchipCompany // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
