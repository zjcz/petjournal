import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/helpers/date_helper.dart';

part 'pet_model.freezed.dart';
part 'pet_model.g.dart';

@freezed
abstract class PetModel with _$PetModel {
  const PetModel._();

  const factory PetModel({
    int? petId,
    required String name,
    required String breed,
    required String colour,
    required PetSex petSex,
    DateTime? dob,
    required bool dobEstimate,
    String? diet,
    String? notes,
    String? history,
    required bool isNeutered,
    required DateTime? neuterDate,
    required PetStatus status,
    required DateTime statusDate,
    required int speciesId,
    required bool isMicrochipped,
    DateTime? microchipDate,
    String? microchipNotes,
    String? microchipNumber,
    String? microchipCompany,
    String? imageUrl,
  }) = _PetModel;

  factory PetModel.fromJson(Map<String, Object?> json) =>
      _$PetModelFromJson(json);

  ///
  /// Get the age of the pet in years / months / days
  /// longFormat: if true and age is over 1 year, return years and months
  ///
  String? getAge({bool longFormat = true}) {
    if (dob == null) {
      return null;
    }
    return DateHelper.formatDifference(
      dob!,
      endDate: DateTime.now(),
      showMonthsWithYears: longFormat,
    );
  }
}
