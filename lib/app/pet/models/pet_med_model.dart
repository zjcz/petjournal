import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pet_med_model.freezed.dart';
part 'pet_med_model.g.dart';

@freezed
abstract class PetMedModel with _$PetMedModel {
  const factory PetMedModel({
    int? petMedId,
    required int petId,
    required String name,
    required String dose,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) = _PetMedModel;

  factory PetMedModel.fromJson(Map<String, Object?> json) =>
      _$PetMedModelFromJson(json);
}
