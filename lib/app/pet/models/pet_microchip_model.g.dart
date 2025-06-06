// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_microchip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetMicrochipModel _$PetMicrochipModelFromJson(Map<String, dynamic> json) =>
    _PetMicrochipModel(
      petMicrochipId: (json['petMicrochipId'] as num?)?.toInt(),
      petId: (json['petId'] as num?)?.toInt(),
      isMicrochipped: json['isMicrochipped'] as bool,
      microchipDate:
          json['microchipDate'] == null
              ? null
              : DateTime.parse(json['microchipDate'] as String),
      microchipNotes: json['microchipNotes'] as String?,
      microchipNumber: json['microchipNumber'] as String?,
      microchipCompany: json['microchipCompany'] as String?,
    );

Map<String, dynamic> _$PetMicrochipModelToJson(_PetMicrochipModel instance) =>
    <String, dynamic>{
      'petMicrochipId': instance.petMicrochipId,
      'petId': instance.petId,
      'isMicrochipped': instance.isMicrochipped,
      'microchipDate': instance.microchipDate?.toIso8601String(),
      'microchipNotes': instance.microchipNotes,
      'microchipNumber': instance.microchipNumber,
      'microchipCompany': instance.microchipCompany,
    };
