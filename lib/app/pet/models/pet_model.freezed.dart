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

 int? get petId; String get name; String get breed; String get colour; PetSex get petSex; DateTime? get dob; bool get dobEstimate; String? get diet; String? get notes; String? get history; bool get isNeutered; DateTime? get neuterDate; PetStatus get status; DateTime get statusDate; int get speciesId; bool get isMicrochipped; DateTime? get microchipDate; String? get microchipNotes; String? get microchipNumber; String? get microchipCompany; String? get imageUrl;
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
    ..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('breed', breed))..add(DiagnosticsProperty('colour', colour))..add(DiagnosticsProperty('petSex', petSex))..add(DiagnosticsProperty('dob', dob))..add(DiagnosticsProperty('dobEstimate', dobEstimate))..add(DiagnosticsProperty('diet', diet))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('isNeutered', isNeutered))..add(DiagnosticsProperty('neuterDate', neuterDate))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('statusDate', statusDate))..add(DiagnosticsProperty('speciesId', speciesId))..add(DiagnosticsProperty('isMicrochipped', isMicrochipped))..add(DiagnosticsProperty('microchipDate', microchipDate))..add(DiagnosticsProperty('microchipNotes', microchipNotes))..add(DiagnosticsProperty('microchipNumber', microchipNumber))..add(DiagnosticsProperty('microchipCompany', microchipCompany))..add(DiagnosticsProperty('imageUrl', imageUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetModel&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.colour, colour) || other.colour == colour)&&(identical(other.petSex, petSex) || other.petSex == petSex)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.dobEstimate, dobEstimate) || other.dobEstimate == dobEstimate)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.history, history) || other.history == history)&&(identical(other.isNeutered, isNeutered) || other.isNeutered == isNeutered)&&(identical(other.neuterDate, neuterDate) || other.neuterDate == neuterDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDate, statusDate) || other.statusDate == statusDate)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.isMicrochipped, isMicrochipped) || other.isMicrochipped == isMicrochipped)&&(identical(other.microchipDate, microchipDate) || other.microchipDate == microchipDate)&&(identical(other.microchipNotes, microchipNotes) || other.microchipNotes == microchipNotes)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipCompany, microchipCompany) || other.microchipCompany == microchipCompany)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,petId,name,breed,colour,petSex,dob,dobEstimate,diet,notes,history,isNeutered,neuterDate,status,statusDate,speciesId,isMicrochipped,microchipDate,microchipNotes,microchipNumber,microchipCompany,imageUrl]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetModel(petId: $petId, name: $name, breed: $breed, colour: $colour, petSex: $petSex, dob: $dob, dobEstimate: $dobEstimate, diet: $diet, notes: $notes, history: $history, isNeutered: $isNeutered, neuterDate: $neuterDate, status: $status, statusDate: $statusDate, speciesId: $speciesId, isMicrochipped: $isMicrochipped, microchipDate: $microchipDate, microchipNotes: $microchipNotes, microchipNumber: $microchipNumber, microchipCompany: $microchipCompany, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $PetModelCopyWith<$Res>  {
  factory $PetModelCopyWith(PetModel value, $Res Function(PetModel) _then) = _$PetModelCopyWithImpl;
@useResult
$Res call({
 int? petId, String name, String breed, String colour, PetSex petSex, DateTime? dob, bool dobEstimate, String? diet, String? notes, String? history, bool isNeutered, DateTime? neuterDate, PetStatus status, DateTime statusDate, int speciesId, bool isMicrochipped, DateTime? microchipDate, String? microchipNotes, String? microchipNumber, String? microchipCompany, String? imageUrl
});




}
/// @nodoc
class _$PetModelCopyWithImpl<$Res>
    implements $PetModelCopyWith<$Res> {
  _$PetModelCopyWithImpl(this._self, this._then);

  final PetModel _self;
  final $Res Function(PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petId = freezed,Object? name = null,Object? breed = null,Object? colour = null,Object? petSex = null,Object? dob = freezed,Object? dobEstimate = null,Object? diet = freezed,Object? notes = freezed,Object? history = freezed,Object? isNeutered = null,Object? neuterDate = freezed,Object? status = null,Object? statusDate = null,Object? speciesId = null,Object? isMicrochipped = null,Object? microchipDate = freezed,Object? microchipNotes = freezed,Object? microchipNumber = freezed,Object? microchipCompany = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,colour: null == colour ? _self.colour : colour // ignore: cast_nullable_to_non_nullable
as String,petSex: null == petSex ? _self.petSex : petSex // ignore: cast_nullable_to_non_nullable
as PetSex,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,dobEstimate: null == dobEstimate ? _self.dobEstimate : dobEstimate // ignore: cast_nullable_to_non_nullable
as bool,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as String?,isNeutered: null == isNeutered ? _self.isNeutered : isNeutered // ignore: cast_nullable_to_non_nullable
as bool,neuterDate: freezed == neuterDate ? _self.neuterDate : neuterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PetStatus,statusDate: null == statusDate ? _self.statusDate : statusDate // ignore: cast_nullable_to_non_nullable
as DateTime,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,isMicrochipped: null == isMicrochipped ? _self.isMicrochipped : isMicrochipped // ignore: cast_nullable_to_non_nullable
as bool,microchipDate: freezed == microchipDate ? _self.microchipDate : microchipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,microchipNotes: freezed == microchipNotes ? _self.microchipNotes : microchipNotes // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipCompany: freezed == microchipCompany ? _self.microchipCompany : microchipCompany // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PetModel extends PetModel with DiagnosticableTreeMixin {
  const _PetModel({this.petId, required this.name, required this.breed, required this.colour, required this.petSex, this.dob, required this.dobEstimate, this.diet, this.notes, this.history, required this.isNeutered, required this.neuterDate, required this.status, required this.statusDate, required this.speciesId, required this.isMicrochipped, this.microchipDate, this.microchipNotes, this.microchipNumber, this.microchipCompany, this.imageUrl}): super._();
  factory _PetModel.fromJson(Map<String, dynamic> json) => _$PetModelFromJson(json);

@override final  int? petId;
@override final  String name;
@override final  String breed;
@override final  String colour;
@override final  PetSex petSex;
@override final  DateTime? dob;
@override final  bool dobEstimate;
@override final  String? diet;
@override final  String? notes;
@override final  String? history;
@override final  bool isNeutered;
@override final  DateTime? neuterDate;
@override final  PetStatus status;
@override final  DateTime statusDate;
@override final  int speciesId;
@override final  bool isMicrochipped;
@override final  DateTime? microchipDate;
@override final  String? microchipNotes;
@override final  String? microchipNumber;
@override final  String? microchipCompany;
@override final  String? imageUrl;

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
    ..add(DiagnosticsProperty('petId', petId))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('breed', breed))..add(DiagnosticsProperty('colour', colour))..add(DiagnosticsProperty('petSex', petSex))..add(DiagnosticsProperty('dob', dob))..add(DiagnosticsProperty('dobEstimate', dobEstimate))..add(DiagnosticsProperty('diet', diet))..add(DiagnosticsProperty('notes', notes))..add(DiagnosticsProperty('history', history))..add(DiagnosticsProperty('isNeutered', isNeutered))..add(DiagnosticsProperty('neuterDate', neuterDate))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('statusDate', statusDate))..add(DiagnosticsProperty('speciesId', speciesId))..add(DiagnosticsProperty('isMicrochipped', isMicrochipped))..add(DiagnosticsProperty('microchipDate', microchipDate))..add(DiagnosticsProperty('microchipNotes', microchipNotes))..add(DiagnosticsProperty('microchipNumber', microchipNumber))..add(DiagnosticsProperty('microchipCompany', microchipCompany))..add(DiagnosticsProperty('imageUrl', imageUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetModel&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.colour, colour) || other.colour == colour)&&(identical(other.petSex, petSex) || other.petSex == petSex)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.dobEstimate, dobEstimate) || other.dobEstimate == dobEstimate)&&(identical(other.diet, diet) || other.diet == diet)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.history, history) || other.history == history)&&(identical(other.isNeutered, isNeutered) || other.isNeutered == isNeutered)&&(identical(other.neuterDate, neuterDate) || other.neuterDate == neuterDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusDate, statusDate) || other.statusDate == statusDate)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.isMicrochipped, isMicrochipped) || other.isMicrochipped == isMicrochipped)&&(identical(other.microchipDate, microchipDate) || other.microchipDate == microchipDate)&&(identical(other.microchipNotes, microchipNotes) || other.microchipNotes == microchipNotes)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipCompany, microchipCompany) || other.microchipCompany == microchipCompany)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,petId,name,breed,colour,petSex,dob,dobEstimate,diet,notes,history,isNeutered,neuterDate,status,statusDate,speciesId,isMicrochipped,microchipDate,microchipNotes,microchipNumber,microchipCompany,imageUrl]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PetModel(petId: $petId, name: $name, breed: $breed, colour: $colour, petSex: $petSex, dob: $dob, dobEstimate: $dobEstimate, diet: $diet, notes: $notes, history: $history, isNeutered: $isNeutered, neuterDate: $neuterDate, status: $status, statusDate: $statusDate, speciesId: $speciesId, isMicrochipped: $isMicrochipped, microchipDate: $microchipDate, microchipNotes: $microchipNotes, microchipNumber: $microchipNumber, microchipCompany: $microchipCompany, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$PetModelCopyWith<$Res> implements $PetModelCopyWith<$Res> {
  factory _$PetModelCopyWith(_PetModel value, $Res Function(_PetModel) _then) = __$PetModelCopyWithImpl;
@override @useResult
$Res call({
 int? petId, String name, String breed, String colour, PetSex petSex, DateTime? dob, bool dobEstimate, String? diet, String? notes, String? history, bool isNeutered, DateTime? neuterDate, PetStatus status, DateTime statusDate, int speciesId, bool isMicrochipped, DateTime? microchipDate, String? microchipNotes, String? microchipNumber, String? microchipCompany, String? imageUrl
});




}
/// @nodoc
class __$PetModelCopyWithImpl<$Res>
    implements _$PetModelCopyWith<$Res> {
  __$PetModelCopyWithImpl(this._self, this._then);

  final _PetModel _self;
  final $Res Function(_PetModel) _then;

/// Create a copy of PetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petId = freezed,Object? name = null,Object? breed = null,Object? colour = null,Object? petSex = null,Object? dob = freezed,Object? dobEstimate = null,Object? diet = freezed,Object? notes = freezed,Object? history = freezed,Object? isNeutered = null,Object? neuterDate = freezed,Object? status = null,Object? statusDate = null,Object? speciesId = null,Object? isMicrochipped = null,Object? microchipDate = freezed,Object? microchipNotes = freezed,Object? microchipNumber = freezed,Object? microchipCompany = freezed,Object? imageUrl = freezed,}) {
  return _then(_PetModel(
petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,colour: null == colour ? _self.colour : colour // ignore: cast_nullable_to_non_nullable
as String,petSex: null == petSex ? _self.petSex : petSex // ignore: cast_nullable_to_non_nullable
as PetSex,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,dobEstimate: null == dobEstimate ? _self.dobEstimate : dobEstimate // ignore: cast_nullable_to_non_nullable
as bool,diet: freezed == diet ? _self.diet : diet // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as String?,isNeutered: null == isNeutered ? _self.isNeutered : isNeutered // ignore: cast_nullable_to_non_nullable
as bool,neuterDate: freezed == neuterDate ? _self.neuterDate : neuterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PetStatus,statusDate: null == statusDate ? _self.statusDate : statusDate // ignore: cast_nullable_to_non_nullable
as DateTime,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,isMicrochipped: null == isMicrochipped ? _self.isMicrochipped : isMicrochipped // ignore: cast_nullable_to_non_nullable
as bool,microchipDate: freezed == microchipDate ? _self.microchipDate : microchipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,microchipNotes: freezed == microchipNotes ? _self.microchipNotes : microchipNotes // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipCompany: freezed == microchipCompany ? _self.microchipCompany : microchipCompany // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
