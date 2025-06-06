import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_vaccination_mapper.dart';
import 'package:matcher/matcher.dart' as match;

/// Unit tests for [PetVaccinationMapper].
void main() {
  group('PetVaccinationMapper', () {
    /// Tests for mapToModel
    group('mapToModel', () {
      test(
        'mapToModel should return correct PetVaccinationModel when PetVaccination is valid',
        () {
          // Arrange
          final petVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: 2,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2025, 5, 28),
            reminderDate: DateTime(2025, 5, 1),
            notes: 'Annual',
            vaccineBatchNumber: 'B123',
            vaccineManufacturer: 'VetPharma',
            administeredBy: 'Dr. Smith',
          );

          // Act
          final result = PetVaccinationMapper.mapToModel(petVaccination);

          // Assert
          expect(result.petVaccinationId, 1);
          expect(result.petId, 2);
          expect(result.name, 'Rabies');
          expect(result.administeredDate, DateTime(2024, 5, 28));
          expect(result.expiryDate, DateTime(2025, 5, 28));
          expect(result.reminderDate, DateTime(2025, 5, 1));
          expect(result.notes, 'Annual');
          expect(result.vaccineBatchNumber, 'B123');
          expect(result.vaccineManufacturer, 'VetPharma');
          expect(result.administeredBy, 'Dr. Smith');
        },
      );

      test(
        'mapToModel should set notes, reminderDate to null when PetVaccination fields are null',
        () {
          // Arrange
          final petVaccination = PetVaccination(
            petVaccinationId: 3,
            pet: 4,
            name: 'Distemper',
            administeredDate: DateTime(2023, 1, 1),
            expiryDate: DateTime(2024, 1, 1),
            reminderDate: null,
            notes: null,
            vaccineBatchNumber: 'A678',
            vaccineManufacturer: 'Test Meds',
            administeredBy: 'Dr. Jones',
          );

          // Act
          final result = PetVaccinationMapper.mapToModel(petVaccination);

          // Assert
          expect(result.reminderDate, match.isNull);
          expect(result.notes, match.isNull);
        },
      );

      /// Tests for mapToModelList
      group('mapToModelList', () {
        test('mapToModelList should return empty list when input is empty', () {
          // Arrange
          final petVaccinations = <PetVaccination>[];

          // Act
          final result = PetVaccinationMapper.mapToModelList(petVaccinations);

          // Assert
          expect(result, isA<List<PetVaccinationModel>>());
          expect(result, isEmpty);
        });

        test(
          'mapToModelList should return correct list when input has multiple PetVaccination objects',
          () {
            // Arrange
            final petVaccinations = [
              PetVaccination(
                petVaccinationId: 1,
                pet: 2,
                name: 'Rabies',
                administeredDate: DateTime(2024, 5, 28),
                expiryDate: DateTime(2025, 5, 28),
                reminderDate: DateTime(2025, 5, 1),
                notes: 'Annual',
                vaccineBatchNumber: 'B123',
                vaccineManufacturer: 'VetPharma',
                administeredBy: 'Dr. Smith',
              ),
              PetVaccination(
                petVaccinationId: 3,
                pet: 4,
                name: 'Distemper',
                administeredDate: DateTime(2023, 1, 1),
                expiryDate: DateTime(2024, 1, 1),
                reminderDate: null,
                notes: null,
                vaccineBatchNumber: 'A678',
                vaccineManufacturer: 'Test Meds',
                administeredBy: 'Dr. Jones',
              ),
            ];

            // Act
            final result = PetVaccinationMapper.mapToModelList(petVaccinations);

            // Assert
            expect(result.length, 2);
            expect(result[0].petVaccinationId, 1);
            expect(result[1].petVaccinationId, 3);
            expect(result[0].petId, 2);
            expect(result[1].petId, 4);
            expect(result[0].name, 'Rabies');
            expect(result[1].name, 'Distemper');
            expect(result[0].administeredDate, DateTime(2024, 5, 28));
            expect(result[1].administeredDate, DateTime(2023, 1, 1));
            expect(result[0].expiryDate, DateTime(2025, 5, 28));
            expect(result[1].expiryDate, DateTime(2024, 1, 1));
            expect(result[0].reminderDate, DateTime(2025, 5, 1));
            expect(result[1].reminderDate, isNull);
            expect(result[0].notes, 'Annual');
            expect(result[1].notes, isNull);
            expect(result[0].vaccineBatchNumber, 'B123');
            expect(result[1].vaccineBatchNumber, 'A678');
            expect(result[0].vaccineManufacturer, 'VetPharma');
            expect(result[1].vaccineManufacturer, 'Test Meds');
            expect(result[0].administeredBy, 'Dr. Smith');
            expect(result[1].administeredBy, 'Dr. Jones');
          },
        );
      });
    });
  });
}
