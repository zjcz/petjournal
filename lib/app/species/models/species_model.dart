import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'species_model.freezed.dart';
part 'species_model.g.dart';

@freezed
abstract class SpeciesModel with _$SpeciesModel {
  const factory SpeciesModel({
    int? speciesId,
    required String name,
    required bool userAdded,
  }) = _SpeciesModel;

  factory SpeciesModel.fromJson(Map<String, Object?> json) =>
      _$SpeciesModelFromJson(json);
}
