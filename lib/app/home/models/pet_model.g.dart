// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetModel _$PetModelFromJson(Map<String, dynamic> json) => _PetModel(
  petId: (json['petId'] as num?)?.toInt(),
  name: json['name'] as String,
  breed: json['breed'] as String,
  colour: json['colour'] as String,
  petSex: $enumDecode(_$PetSexEnumMap, json['petSex']),
  age: (json['age'] as num?)?.toInt(),
  dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
  dobEstimate: json['dobEstimate'] as bool,
  dobCalculated: json['dobCalculated'] as bool,
  diet: json['diet'] as String?,
  notes: json['notes'] as String?,
  history: json['history'] as String?,
  isNeutered: json['isNeutered'] as bool,
  neuterDate:
      json['neuterDate'] == null
          ? null
          : DateTime.parse(json['neuterDate'] as String),
  status: $enumDecode(_$PetStatusEnumMap, json['status']),
  statusDate: DateTime.parse(json['statusDate'] as String),
  species: SpeciesModel.fromJson(json['species'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PetModelToJson(_PetModel instance) => <String, dynamic>{
  'petId': instance.petId,
  'name': instance.name,
  'breed': instance.breed,
  'colour': instance.colour,
  'petSex': _$PetSexEnumMap[instance.petSex]!,
  'age': instance.age,
  'dob': instance.dob?.toIso8601String(),
  'dobEstimate': instance.dobEstimate,
  'dobCalculated': instance.dobCalculated,
  'diet': instance.diet,
  'notes': instance.notes,
  'history': instance.history,
  'isNeutered': instance.isNeutered,
  'neuterDate': instance.neuterDate?.toIso8601String(),
  'status': _$PetStatusEnumMap[instance.status]!,
  'statusDate': instance.statusDate.toIso8601String(),
  'species': instance.species,
};

const _$PetSexEnumMap = {
  PetSex.female: 'female',
  PetSex.male: 'male',
  PetSex.unknown: 'unknown',
};

const _$PetStatusEnumMap = {
  PetStatus.active: 'active',
  PetStatus.deceased: 'deceased',
  PetStatus.rehomed: 'rehomed',
  PetStatus.missing: 'missing',
};
