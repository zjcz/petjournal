import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_vaccinations_controller.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_vaccination_mapper.dart';
import 'package:matcher/matcher.dart' as match;

import 'pet_vaccinations_controller_test.mocks.dart';

/// See implementation: lib/app/pet/controller/pet_vaccinations_controller.dart
/// Riverpod testing docs: https://riverpod.dev/docs/essentials/testing

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

@GenerateMocks([DatabaseService])
void main() {
  group('PetVaccinationController', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      test(
        'build should emit PetVaccinationModel list when database returns data',
        () async {
          // ARRANGE
          const petId = 1;
          final petVaccinations = [
            PetVaccination(
              petVaccinationId: 1,
              pet: petId,
              name: 'Rabies',
              administeredDate: DateTime(2024, 5, 28),
              expiryDate: DateTime(2025, 5, 28),
              reminderDate: DateTime(2025, 5, 1),
              notes: 'Annual',
              vaccineBatchNumber: 'B123',
              vaccineManufacturer: 'VetPharma',
              administeredBy: 'Dr. Smith',
            ),
          ];
          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.value(petVaccinations));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petVaccinationControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetVaccinationModel>>());
          expect(result.length, 1);
          expect(result.first.petVaccinationId, 1);
          verify(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).called(1);
        },
      );

      test(
        'build should emit empty list when database returns empty',
        () async {
          // ARRANGE
          const petId = 2;
          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.value([]));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petVaccinationControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetVaccinationModel>>());
          expect(result, isEmpty);
          verify(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).called(1);
        },
      );

      test('build should emit error when database throws', () async {
        // ARRANGE
        const petId = 3;
        when(
          mockDatabaseService.getAllPetVaccinationsForPet(petId),
        ).thenAnswer((_) => Stream.error(Exception('db error')));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(petVaccinationControllerProvider(petId).future),
          throwsA(match.isA<Exception>()),
        );
        verify(
          mockDatabaseService.getAllPetVaccinationsForPet(petId),
        ).called(1);
      });

      test(
        'build should emit updated values when database emits multiple events',
        () async {
          // ARRANGE
          const petId = 4;
          final petVaccinations1 = [
            PetVaccination(
              petVaccinationId: 1,
              pet: petId,
              name: 'Rabies',
              administeredDate: DateTime(2024, 5, 28),
              expiryDate: DateTime(2025, 5, 28),
              reminderDate: DateTime(2025, 5, 1),
              notes: 'Annual',
              vaccineBatchNumber: 'B123',
              vaccineManufacturer: 'VetPharma',
              administeredBy: 'Dr. Smith',
            ),
          ];
          final petVaccinations2 = [
            PetVaccination(
              petVaccinationId: 2,
              pet: petId,
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
          final controller = StreamController<List<PetVaccination>>();
          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => controller.stream);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final stream = container.listen(
            petVaccinationControllerProvider(petId).future,
            (_, __) {},
          );

          controller.add(petVaccinations1);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(
            await stream.read(),
            PetVaccinationMapper.mapToModelList(petVaccinations1),
          );

          controller.add(petVaccinations2);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(
            await stream.read(),
            PetVaccinationMapper.mapToModelList(petVaccinations2),
          );

          await controller.close();
        },
      );
    });
  });
}
