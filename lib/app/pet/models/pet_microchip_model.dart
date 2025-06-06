import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pet_microchip_model.freezed.dart';
part 'pet_microchip_model.g.dart';

@freezed
abstract class PetMicrochipModel with _$PetMicrochipModel {
  const factory PetMicrochipModel({
    int? petMicrochipId,
    int? petId,
    required bool isMicrochipped,
    DateTime? microchipDate,
    String? microchipNotes,
    String? microchipNumber,
    String? microchipCompany,
  }) = _PetMicrochipModel;

  factory PetMicrochipModel.fromJson(Map<String, Object?> json) =>
      _$PetMicrochipModelFromJson(json);
}
