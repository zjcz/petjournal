// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'species_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeciesModel implements DiagnosticableTreeMixin {

 int? get speciesId; String get name; bool get userAdded;
/// Create a copy of SpeciesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeciesModelCopyWith<SpeciesModel> get copyWith => _$SpeciesModelCopyWithImpl<SpeciesModel>(this as SpeciesModel, _$identity);

  /// Serializes this SpeciesModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SpeciesModel'))
    ..add(DiagnosticsProperty('speciesId', speciesId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('userAdded', userAdded));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeciesModel&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.name, name) || other.name == name)&&(identical(other.userAdded, userAdded) || other.userAdded == userAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,name,userAdded);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SpeciesModel(speciesId: $speciesId, name: $name, userAdded: $userAdded)';
}


}

/// @nodoc
abstract mixin class $SpeciesModelCopyWith<$Res>  {
  factory $SpeciesModelCopyWith(SpeciesModel value, $Res Function(SpeciesModel) _then) = _$SpeciesModelCopyWithImpl;
@useResult
$Res call({
 int? speciesId, String name, bool userAdded
});




}
/// @nodoc
class _$SpeciesModelCopyWithImpl<$Res>
    implements $SpeciesModelCopyWith<$Res> {
  _$SpeciesModelCopyWithImpl(this._self, this._then);

  final SpeciesModel _self;
  final $Res Function(SpeciesModel) _then;

/// Create a copy of SpeciesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speciesId = freezed,Object? name = null,Object? userAdded = null,}) {
  return _then(_self.copyWith(
speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userAdded: null == userAdded ? _self.userAdded : userAdded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SpeciesModel with DiagnosticableTreeMixin implements SpeciesModel {
  const _SpeciesModel({this.speciesId, required this.name, required this.userAdded});
  factory _SpeciesModel.fromJson(Map<String, dynamic> json) => _$SpeciesModelFromJson(json);

@override final  int? speciesId;
@override final  String name;
@override final  bool userAdded;

/// Create a copy of SpeciesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeciesModelCopyWith<_SpeciesModel> get copyWith => __$SpeciesModelCopyWithImpl<_SpeciesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeciesModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SpeciesModel'))
    ..add(DiagnosticsProperty('speciesId', speciesId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('userAdded', userAdded));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeciesModel&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.name, name) || other.name == name)&&(identical(other.userAdded, userAdded) || other.userAdded == userAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,name,userAdded);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SpeciesModel(speciesId: $speciesId, name: $name, userAdded: $userAdded)';
}


}

/// @nodoc
abstract mixin class _$SpeciesModelCopyWith<$Res> implements $SpeciesModelCopyWith<$Res> {
  factory _$SpeciesModelCopyWith(_SpeciesModel value, $Res Function(_SpeciesModel) _then) = __$SpeciesModelCopyWithImpl;
@override @useResult
$Res call({
 int? speciesId, String name, bool userAdded
});




}
/// @nodoc
class __$SpeciesModelCopyWithImpl<$Res>
    implements _$SpeciesModelCopyWith<$Res> {
  __$SpeciesModelCopyWithImpl(this._self, this._then);

  final _SpeciesModel _self;
  final $Res Function(_SpeciesModel) _then;

/// Create a copy of SpeciesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speciesId = freezed,Object? name = null,Object? userAdded = null,}) {
  return _then(_SpeciesModel(
speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userAdded: null == userAdded ? _self.userAdded : userAdded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
