// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetModel implements DiagnosticableTreeMixin {

 int? get petId; String get name; String get breed; String get colour; PetSex get petSex; int? get age; DateTime? get dob; bool get dobEstimate; bool get dobCalculated; String? get diet; String? get notes; String? get history; bool get isNeutered; DateTime? get neuterDate; PetStatus get status; DateTime get statusDate; SpeciesModel get species;
/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetModelCopyWith<PetModel> get copyWith => _$PetModelCopyWithImpl<PetModel>(this as PetModel, _$identity);

  /// Serializes this PetModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetModel'))
    ..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('breed', breed))..add(DiagnosticsProperty('colour', colour))..add(DiagnosticsProperty('petSex', petSex))..add(DiagnosticsProperty('age', age))..add(DiagnosticsProperty('dob', dob))..add(DiagnosticsProperty('dobEstimate', dobEstimate))..add(DiagnosticsProperty('dobCalculated', dobCalculated))..add(DiagnosticsProperty('diet', diet))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('isNeutered', isNeutered))..add(DiagnosticsProperty('neuterDate', neuterDate))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('statusDate', statusDate))..add(DiagnosticsProperty('species', species));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetModel&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.colour, colour) || other.colour == colour)&&(identical(other.petSex, petSex) || other.petSex == petSex)&&(identical(other.age, age) || other.age == age)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.dobEstimate, dobEstimate) || other.dobEstimate == dobEstimate)&&(identical(other.dobCalculated, dobCalculated) || other.dobCalculated == dobCalculated)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.history, history) || other.history == history)&&(identical(other.isNeutered, isNeutered) || other.isNeutered == isNeutered)&&(identical(other.neuterDate, neuterDate) || other.neuterDate == neuterDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDate, statusDate) || other.statusDate == statusDate)&&(identical(other.species, species) || other.species == species));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,name,breed,colour,petSex,age,dob,dobEstimate,dobCalculated,diet,notes,history,isNeutered,neuterDate,status,statusDate,species);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetModel(petId: $petId, name: $name, breed: $breed, colour: $colour, petSex: $petSex, age: $age, dob: $dob, dobEstimate: $dobEstimate, dobCalculated: $dobCalculated, diet: $diet, notes: $notes, history: $history, isNeutered: $isNeutered, neuterDate: $neuterDate, status: $status, statusDate: $statusDate, species: $species)';
}


}

/// @nodoc
abstract mixin class $PetModelCopyWith<$Res>  {
  factory $PetModelCopyWith(PetModel value, $Res Function(PetModel) _then) = _$PetModelCopyWithImpl;
@useResult
$Res call({
 int? petId, String name, String breed, String colour, PetSex petSex, int? age, DateTime? dob, bool dobEstimate, bool dobCalculated, String? diet, String? notes, String? history, bool isNeutered, DateTime? neuterDate, PetStatus status, DateTime statusDate, SpeciesModel species
});


$SpeciesModelCopyWith<$Res> get species;

}
/// @nodoc
class _$PetModelCopyWithImpl<$Res>
    implements $PetModelCopyWith<$Res> {
  _$PetModelCopyWithImpl(this._self, this._then);

  final PetModel _self;
  final $Res Function(PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petId = freezed,Object? name = null,Object? breed = null,Object? colour = null,Object? petSex = null,Object? age = freezed,Object? dob = freezed,Object? dobEstimate = null,Object? dobCalculated = null,Object? diet = freezed,Object? notes = freezed,Object? history = freezed,Object? isNeutered = null,Object? neuterDate = freezed,Object? status = null,Object? statusDate = null,Object? species = null,}) {
  return _then(_self.copyWith(
petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,colour: null == colour ? _self.colour : colour // ignore: cast_nullable_to_non_nullable
as String,petSex: null == petSex ? _self.petSex : petSex // ignore: cast_nullable_to_non_nullable
as PetSex,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,dobEstimate: null == dobEstimate ? _self.dobEstimate : dobEstimate // ignore: cast_nullable_to_non_nullable
as bool,dobCalculated: null == dobCalculated ? _self.dobCalculated : dobCalculated // ignore: cast_nullable_to_non_nullable
as bool,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as String?,isNeutered: null == isNeutered ? _self.isNeutered : isNeutered // ignore: cast_nullable_to_non_nullable
as bool,neuterDate: freezed == neuterDate ? _self.neuterDate : neuterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PetStatus,statusDate: null == statusDate ? _self.statusDate : statusDate // ignore: cast_nullable_to_non_nullable
as DateTime,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as SpeciesModel,
  ));
}
/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeciesModelCopyWith<$Res> get species {
  
  return $SpeciesModelCopyWith<$Res>(_self.species, (value) {
    return _then(_self.copyWith(species: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PetModel with DiagnosticableTreeMixin implements PetModel {
  const _PetModel({this.petId, required this.name, required this.breed, required this.colour, required this.petSex, this.age, this.dob, required this.dobEstimate, required this.dobCalculated, this.diet, this.notes, this.history, required this.isNeutered, required this.neuterDate, required this.status, required this.statusDate, required this.species});
  factory _PetModel.fromJson(Map<String, dynamic> json) => _$PetModelFromJson(json);

@override final  int? petId;
@override final  String name;
@override final  String breed;
@override final  String colour;
@override final  PetSex petSex;
@override final  int? age;
@override final  DateTime? dob;
@override final  bool dobEstimate;
@override final  bool dobCalculated;
@override final  String? diet;
@override final  String? notes;
@override final  String? history;
@override final  bool isNeutered;
@override final  DateTime? neuterDate;
@override final  PetStatus status;
@override final  DateTime statusDate;
@override final  SpeciesModel species;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetModelCopyWith<_PetModel> get copyWith => __$PetModelCopyWithImpl<_PetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PetModel'))
    ..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('breed', breed))..add(DiagnosticsProperty('colour', colour))..add(DiagnosticsProperty('petSex', petSex))..add(DiagnosticsProperty('age', age))..add(DiagnosticsProperty('dob', dob))..add(DiagnosticsProperty('dobEstimate', dobEstimate))..add(DiagnosticsProperty('dobCalculated', dobCalculated))..add(DiagnosticsProperty('diet', diet))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('isNeutered', isNeutered))..add(DiagnosticsProperty('neuterDate', neuterDate))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('statusDate', statusDate))..add(DiagnosticsProperty('species', species));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetModel&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.colour, colour) || other.colour == colour)&&(identical(other.petSex, petSex) || other.petSex == petSex)&&(identical(other.age, age) || other.age == age)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.dobEstimate, dobEstimate) || other.dobEstimate == dobEstimate)&&(identical(other.dobCalculated, dobCalculated) || other.dobCalculated == dobCalculated)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.history, history) || other.history == history)&&(identical(other.isNeutered, isNeutered) || other.isNeutered == isNeutered)&&(identical(other.neuterDate, neuterDate) || other.neuterDate == neuterDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDate, statusDate) || other.statusDate == statusDate)&&(identical(other.species, species) || other.species == species));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,name,breed,colour,petSex,age,dob,dobEstimate,dobCalculated,diet,notes,history,isNeutered,neuterDate,status,statusDate,species);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetModel(petId: $petId, name: $name, breed: $breed, colour: $colour, petSex: $petSex, age: $age, dob: $dob, dobEstimate: $dobEstimate, dobCalculated: $dobCalculated, diet: $diet, notes: $notes, history: $history, isNeutered: $isNeutered, neuterDate: $neuterDate, status: $status, statusDate: $statusDate, species: $species)';
}


}

/// @nodoc
abstract mixin class _$PetModelCopyWith<$Res> implements $PetModelCopyWith<$Res> {
  factory _$PetModelCopyWith(_PetModel value, $Res Function(_PetModel) _then) = __$PetModelCopyWithImpl;
@override @useResult
$Res call({
 int? petId, String name, String breed, String colour, PetSex petSex, int? age, DateTime? dob, bool dobEstimate, bool dobCalculated, String? diet, String? notes, String? history, bool isNeutered, DateTime? neuterDate, PetStatus status, DateTime statusDate, SpeciesModel species
});


@override $SpeciesModelCopyWith<$Res> get species;

}
/// @nodoc
class __$PetModelCopyWithImpl<$Res>
    implements _$PetModelCopyWith<$Res> {
  __$PetModelCopyWithImpl(this._self, this._then);

  final _PetModel _self;
  final $Res Function(_PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petId = freezed,Object? name = null,Object? breed = null,Object? colour = null,Object? petSex = null,Object? age = freezed,Object? dob = freezed,Object? dobEstimate = null,Object? dobCalculated = null,Object? diet = freezed,Object? notes = freezed,Object? history = freezed,Object? isNeutered = null,Object? neuterDate = freezed,Object? status = null,Object? statusDate = null,Object? species = null,}) {
  return _then(_PetModel(
petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,colour: null == colour ? _self.colour : colour // ignore: cast_nullable_to_non_nullable
as String,petSex: null == petSex ? _self.petSex : petSex // ignore: cast_nullable_to_non_nullable
as PetSex,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,dobEstimate: null == dobEstimate ? _self.dobEstimate : dobEstimate // ignore: cast_nullable_to_non_nullable
as bool,dobCalculated: null == dobCalculated ? _self.dobCalculated : dobCalculated // ignore: cast_nullable_to_non_nullable
as bool,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as String?,isNeutered: null == isNeutered ? _self.isNeutered : isNeutered // ignore: cast_nullable_to_non_nullable
as bool,neuterDate: freezed == neuterDate ? _self.neuterDate : neuterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PetStatus,statusDate: null == statusDate ? _self.statusDate : statusDate // ignore: cast_nullable_to_non_nullable
as DateTime,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as SpeciesModel,
  ));
}

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeciesModelCopyWith<$Res> get species {
  
  return $SpeciesModelCopyWith<$Res>(_self.species, (value) {
    return _then(_self.copyWith(species: value));
  });
}
}

// dart format on
