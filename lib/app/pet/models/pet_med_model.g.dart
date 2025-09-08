// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_med_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetMedModel _$PetMedModelFromJson(Map<String, dynamic> json) => _PetMedModel(
  petMedId: (json['petMedId'] as num?)?.toInt(),
  petId: (json['petId'] as num).toInt(),
  name: json['name'] as String,
  frequency: (json['frequency'] as num).toInt(),
  frequencyType: $enumDecode(_$FrequencyTypeEnumMap, json['frequencyType']),
  doseUnit: (json['doseUnit'] as num).toDouble(),
  medType: $enumDecode(_$MedTypeEnumMap, json['medType']),
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
      'frequency': instance.frequency,
      'frequencyType': _$FrequencyTypeEnumMap[instance.frequencyType]!,
      'doseUnit': instance.doseUnit,
      'medType': _$MedTypeEnumMap[instance.medType]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'notes': instance.notes,
    };

const _$FrequencyTypeEnumMap = {
  FrequencyType.daily: 'daily',
  FrequencyType.weekly: 'weekly',
  FrequencyType.monthly: 'monthly',
  FrequencyType.yearly: 'yearly',
};

const _$MedTypeEnumMap = {
  MedType.cream: 'cream',
  MedType.injection: 'injection',
  MedType.oral: 'oral',
  MedType.tablet: 'tablet',
};
