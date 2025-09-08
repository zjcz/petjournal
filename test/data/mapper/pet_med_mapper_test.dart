import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/constants/frequency_type.dart';
import 'package:petjournal/constants/med_type.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_med_mapper.dart';
import 'package:matcher/matcher.dart' as match;

/// Unit tests for [PetMedMapper].
void main() {
  group('PetMedMapper', () {
    /// Tests for mapToModel
    group('mapToModel', () {
      test(
        'mapToModel should return correct PetMedModel when PetMed is valid',
        () {
          // Arrange
          final petMed = PetMed(
            petMedId: 1,
            pet: 2,
            name: 'Antibiotic',
            frequency: 1,
            frequencyType: FrequencyType.daily,
            doseUnit: 1.5,
            medType: MedType.oral,
            startDate: DateTime(2024, 5, 28),
            endDate: DateTime(2024, 6, 1),
            notes: 'Take with food',
          );

          // Act
          final result = PetMedMapper.mapToModel(petMed);

          // Assert
          expect(result.petMedId, 1);
          expect(result.petId, 2);
          expect(result.name, 'Antibiotic');
          expect(result.frequency, 1);
          expect(result.frequencyType, FrequencyType.daily);
          expect(result.doseUnit, 1.5);
          expect(result.medType, MedType.oral);
          expect(result.startDate, DateTime(2024, 5, 28));
          expect(result.endDate, DateTime(2024, 6, 1));
          expect(result.notes, 'Take with food');
        },
      );

      test('mapToModel should set notes to null when PetMed notes is null', () {
        // Arrange
        final petMed = PetMed(
          petMedId: 3,
          pet: 4,
          name: 'Painkiller',
          frequency: 1,
          frequencyType: FrequencyType.daily,
          doseUnit: 1.5,
          medType: MedType.oral,
          startDate: DateTime(2023, 1, 1),
          endDate: DateTime(2023, 1, 10),
          notes: null,
        );

        // Act
        final result = PetMedMapper.mapToModel(petMed);

        // Assert
        expect(result.notes, match.isNull);
      });

      test(
        'mapToModel should set endDate to null when PetMed endDate is null',
        () {
          // Arrange
          final petMed = PetMed(
            petMedId: 5,
            pet: 6,
            name: 'Vaccine',
            frequency: 1,
            frequencyType: FrequencyType.daily,
            doseUnit: 1.5,
            medType: MedType.oral,
            startDate: DateTime(2022, 2, 2),
            endDate: null,
            notes: 'Annual',
          );

          // Act
          final result = PetMedMapper.mapToModel(petMed);

          // Assert
          expect(result.endDate, match.isNull);
        },
      );

      /// Tests for mapToModelList
      group('mapToModelList', () {
        test('mapToModelList should return empty list when input is empty', () {
          // Arrange
          final petMeds = <PetMed>[];

          // Act
          final result = PetMedMapper.mapToModelList(petMeds);

          // Assert
          expect(result, isA<List<PetMedModel>>());
          expect(result, isEmpty);
        });

        test(
          'mapToModelList should return correct list when input has multiple PetMed objects',
          () {
            // Arrange
            final petMeds = [
              PetMed(
                petMedId: 1,
                pet: 2,
                name: 'Antibiotic',
                frequency: 1,
                frequencyType: FrequencyType.daily,
                doseUnit: 1.5,
                medType: MedType.oral,
                startDate: DateTime(2024, 5, 28),
                endDate: DateTime(2024, 6, 1),
                notes: 'Take with food',
              ),
              PetMed(
                petMedId: 3,
                pet: 4,
                name: 'Painkiller',
                frequency: 4,
                frequencyType: FrequencyType.weekly,
                doseUnit: 7.2,
                medType: MedType.injection,
                startDate: DateTime(2023, 1, 1),
                endDate: null,
                notes: null,
              ),
            ];

            // Act
            final result = PetMedMapper.mapToModelList(petMeds);

            // Assert
            expect(result.length, 2);
            expect(result[0].petMedId, 1);
            expect(result[1].petMedId, 3);
            expect(result[0].name, 'Antibiotic');
            expect(result[1].name, 'Painkiller');
            expect(result[0].endDate, DateTime(2024, 6, 1));
            expect(result[1].endDate, match.isNull);
          },
        );
      });
    });
  });
}
