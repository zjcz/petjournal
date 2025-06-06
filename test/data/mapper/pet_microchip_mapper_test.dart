import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/pet_microchip_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_microchip_mapper.dart';

/// Unit tests for [PetMicrochipMapper].
void main() {
  group('PetMicrochipMapper', () {
    /// Tests for mapToModel
    group('mapToModel', () {
      test(
        'mapToModel should return correct PetMicrochipModel when PetMicrochip is valid',
        () {
          // Arrange
          final petMicrochip = PetMicrochip(
            petMicrochipId: 1,
            pet: 2,
            isMicrochipped: true,
            microchipDate: DateTime(2024, 5, 28),
            microchipNotes: 'Healthy',
            microchipNumber: '123456789',
            microchipCompany: 'PetSafe',
          );

          // Act
          final result = PetMicrochipMapper.mapToModel(petMicrochip);

          // Assert
          expect(result.petMicrochipId, 1);
          expect(result.petId, 2);
          expect(result.isMicrochipped, true);
          expect(result.microchipDate, DateTime(2024, 5, 28));
          expect(result.microchipNotes, 'Healthy');
          expect(result.microchipNumber, '123456789');
          expect(result.microchipCompany, 'PetSafe');
        },
      );

      test(
        'mapToModel should set isMicrochipped to false when PetMicrochip.isMicrochipped is null',
        () {
          // Arrange
          final petMicrochip = PetMicrochip(
            petMicrochipId: 3,
            pet: 4,
            isMicrochipped: null,
            microchipDate: DateTime(2023, 1, 1),
            microchipNotes: 'No chip',
            microchipNumber: null,
            microchipCompany: null,
          );

          // Act
          final result = PetMicrochipMapper.mapToModel(petMicrochip);

          // Assert
          expect(result.isMicrochipped, false);
        },
      );

      test(
        'mapToModel should set microchipNotes, microchipNumber, microchipCompany to null when PetMicrochip fields are null',
        () {
          // Arrange
          final petMicrochip = PetMicrochip(
            petMicrochipId: 5,
            pet: 6,
            isMicrochipped: false,
            microchipDate: null,
            microchipNotes: null,
            microchipNumber: null,
            microchipCompany: null,
          );

          // Act
          final result = PetMicrochipMapper.mapToModel(petMicrochip);

          // Assert
          expect(result.microchipDate, isNull);
          expect(result.microchipNotes, isNull);
          expect(result.microchipNumber, isNull);
          expect(result.microchipCompany, isNull);
        },
      );
    });

    /// Tests for mapToModelList
    group('mapToModelList', () {
      test(
        'mapToModelList should return empty list when input is empty',
        () {
          // Arrange
          final petMicrochips = <PetMicrochip>[];

          // Act
          final result = PetMicrochipMapper.mapToModelList(petMicrochips);

          // Assert
          expect(result, isA<List<PetMicrochipModel>>());
          expect(result, isEmpty);
        },
      );

      test(
        'mapToModelList should return correct list when input has multiple PetMicrochip objects',
        () {
          // Arrange
          final petMicrochips = [
            PetMicrochip(
              petMicrochipId: 1,
              pet: 2,
              isMicrochipped: true,
              microchipDate: DateTime(2024, 5, 28),
              microchipNotes: 'Healthy',
              microchipNumber: '123456789',
              microchipCompany: 'PetSafe',
            ),
            PetMicrochip(
              petMicrochipId: 3,
              pet: 4,
              isMicrochipped: null,
              microchipDate: null,
              microchipNotes: null,
              microchipNumber: null,
              microchipCompany: null,
            ),
          ];

          // Act
          final result = PetMicrochipMapper.mapToModelList(petMicrochips);

          // Assert
          expect(result.length, 2);
          expect(result[0].petMicrochipId, 1);
          expect(result[1].petMicrochipId, 3);
          expect(result[0].isMicrochipped, true);
          expect(result[1].isMicrochipped, false);
          expect(result[0].microchipCompany, 'PetSafe');
          expect(result[1].microchipCompany, isNull);
        },
      );
    });
  });
}