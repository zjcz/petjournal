import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';

part 'pet_model.freezed.dart';
part 'pet_model.g.dart';

@freezed
abstract class PetModel with _$PetModel {
  const factory PetModel({
    int? petId,
    required String name,
    required String breed,
    required String colour,
    required PetSex petSex,
    int? age,
    DateTime? dob,
    required bool dobEstimate,
    required bool dobCalculated,
    String? diet,
    String? notes,
    String? history,
    required bool isNeutered,
    required DateTime? neuterDate,
    required PetStatus status,
    required DateTime statusDate,
    required SpeciesModel species,
    required bool isMicrochipped,
    DateTime? microchipDate,
    String? microchipNotes,
    String? microchipNumber,
    String? microchipCompany,
  }) = _PetModel;

  factory PetModel.fromJson(Map<String, Object?> json) =>
      _$PetModelFromJson(json);
}
