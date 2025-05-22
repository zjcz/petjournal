// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeciesModel _$SpeciesModelFromJson(Map<String, dynamic> json) =>
    _SpeciesModel(
      speciesId: (json['speciesId'] as num?)?.toInt(),
      name: json['name'] as String,
      userAdded: json['userAdded'] as bool,
    );

Map<String, dynamic> _$SpeciesModelToJson(_SpeciesModel instance) =>
    <String, dynamic>{
      'speciesId': instance.speciesId,
      'name': instance.name,
      'userAdded': instance.userAdded,
    };
