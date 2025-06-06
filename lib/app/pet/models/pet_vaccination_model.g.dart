// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_vaccination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetVaccinationModel _$PetVaccinationModelFromJson(Map<String, dynamic> json) =>
    _PetVaccinationModel(
      petVaccinationId: (json['petVaccinationId'] as num?)?.toInt(),
      petId: (json['petId'] as num?)?.toInt(),
      name: json['name'] as String,
      administeredDate: DateTime.parse(json['administeredDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      reminderDate:
          json['reminderDate'] == null
              ? null
              : DateTime.parse(json['reminderDate'] as String),
      notes: json['notes'] as String?,
      vaccineBatchNumber: json['vaccineBatchNumber'] as String?,
      vaccineManufacturer: json['vaccineManufacturer'] as String?,
      administeredBy: json['administeredBy'] as String?,
    );

Map<String, dynamic> _$PetVaccinationModelToJson(
  _PetVaccinationModel instance,
) => <String, dynamic>{
  'petVaccinationId': instance.petVaccinationId,
  'petId': instance.petId,
  'name': instance.name,
  'administeredDate': instance.administeredDate.toIso8601String(),
  'expiryDate': instance.expiryDate.toIso8601String(),
  'reminderDate': instance.reminderDate?.toIso8601String(),
  'notes': instance.notes,
  'vaccineBatchNumber': instance.vaccineBatchNumber,
  'vaccineManufacturer': instance.vaccineManufacturer,
  'administeredBy': instance.administeredBy,
};
