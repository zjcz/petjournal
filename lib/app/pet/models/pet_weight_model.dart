import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:petjournal/helpers/imperial_weight.dart';

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
    required double weightKg,
    String? notes,
  }) = _PetWeightModel;

  factory PetWeightModel.fromJson(Map<String, Object?> json) =>
      _$PetWeightModelFromJson(json);

  String niceName(bool isMetric) {
    if (isMetric) {
      if (weightKg - weightKg.truncate() == 0.0) {
        return '${weightKg.toStringAsFixed(0)} kg';
      } else {
        return '${weightKg.toStringAsFixed(3)} kg';
      }
    } else {
      return imperialWeight.toString();
    }
  }

  ImperialWeight get imperialWeight {
    return ImperialWeight.fromKg(weightKg);
  }
}
