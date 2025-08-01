import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:petjournal/constants/weight_units.dart';

part 'pet_weight_model.freezed.dart';
part 'pet_weight_model.g.dart';

@freezed
abstract class PetWeightModel with _$PetWeightModel {
  // Added constructor. Must not have any parameter
  const PetWeightModel._();

  const factory PetWeightModel({
    int? petWeightId,
    required int petId,
    required DateTime date,
    required double weight,
    required WeightUnits weightUnit,
    String? notes,
  }) = _PetWeightModel;

  factory PetWeightModel.fromJson(Map<String, Object?> json) =>
      _$PetWeightModelFromJson(json);

  String niceName() {
    return '$weight ${weightUnit.unitName}';
  }
}
