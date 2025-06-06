// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetWeightModel _$PetWeightModelFromJson(Map<String, dynamic> json) =>
    _PetWeightModel(
      petWeightId: (json['petWeightId'] as num?)?.toInt(),
      petId: (json['petId'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num).toDouble(),
      weightUnit: $enumDecode(_$WeightUnitsEnumMap, json['weightUnit']),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PetWeightModelToJson(_PetWeightModel instance) =>
    <String, dynamic>{
      'petWeightId': instance.petWeightId,
      'petId': instance.petId,
      'date': instance.date.toIso8601String(),
      'weight': instance.weight,
      'weightUnit': _$WeightUnitsEnumMap[instance.weightUnit]!,
      'notes': instance.notes,
    };

const _$WeightUnitsEnumMap = {
  WeightUnits.metric: 'metric',
  WeightUnits.imperial: 'imperial',
};
