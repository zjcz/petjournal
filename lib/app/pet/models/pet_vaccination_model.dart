import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pet_vaccination_model.freezed.dart';
part 'pet_vaccination_model.g.dart';

@freezed
abstract class PetVaccinationModel with _$PetVaccinationModel {
  const factory PetVaccinationModel({
    int? petVaccinationId,
    required int petId,
    required String name,
    required DateTime administeredDate,
    DateTime? expiryDate,
    DateTime? reminderDate,
    String? notes,
    required String vaccineBatchNumber,
    required String vaccineManufacturer,
    required String administeredBy,
  }) = _PetVaccinationModel;

  factory PetVaccinationModel.fromJson(Map<String, Object?> json) =>
      _$PetVaccinationModelFromJson(json);
}
