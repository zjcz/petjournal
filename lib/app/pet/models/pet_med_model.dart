import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:petjournal/constants/frequency_type.dart';
import 'package:petjournal/constants/med_type.dart';

part 'pet_med_model.freezed.dart';
part 'pet_med_model.g.dart';

@freezed
abstract class PetMedModel with _$PetMedModel {
  const factory PetMedModel({
    int? petMedId,
    required int petId,
    required String name,
    required int frequency,
    required FrequencyType frequencyType,
    required double doseUnit,
    required MedType medType,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) = _PetMedModel;

  factory PetMedModel.fromJson(Map<String, Object?> json) =>
      _$PetMedModelFromJson(json);
}
