// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_med_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetMedModel _$PetMedModelFromJson(Map<String, dynamic> json) => _PetMedModel(
  petMedId: (json['petMedId'] as num?)?.toInt(),
  petId: (json['petId'] as num?)?.toInt(),
  name: json['name'] as String,
  dose: json['dose'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$PetMedModelToJson(_PetMedModel instance) =>
    <String, dynamic>{
      'petMedId': instance.petMedId,
      'petId': instance.petId,
      'name': instance.name,
      'dose': instance.dose,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'notes': instance.notes,
    };
