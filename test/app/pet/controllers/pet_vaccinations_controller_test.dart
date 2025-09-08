import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_vaccinations_controller.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/app/settings/models/settings_model.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/lookups/settings_lookup.dart';
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

    setupMockDatabaseForJournalEntry(bool createLinkedJournalEntries) {
      SettingsLookup().refreshSettings(
        SettingsModel(
          lastUsedVersion: '1.0.0',
          acceptedTermsAndConditions: true,
          optIntoAnalyticsWarning: true,
          onBoardingComplete: true,
          defaultWeightUnit: WeightUnits.metric,
          createLinkedJournalEntries: createLinkedJournalEntries,
        ),
      );

      when(
        mockDatabaseService.createJournalEntryForPet(
          entryText: anyNamed('entryText'),
          petIdList: anyNamed('petIdList'),
          tags: anyNamed('tags'),
          linkedRecordId: anyNamed('linkedRecordId'),
          linkedRecordType: anyNamed('linkedRecordType'),
          linkedRecordTitle: anyNamed('linkedRecordTitle'),
        ),
      ).thenAnswer((_) => Future.value());

      when(
        mockDatabaseService.updateLinkedJournalEntry(
          linkedRecordId: anyNamed('linkedRecordId'),
          linkedRecordType: anyNamed('linkedRecordType'),
          linkedRecordTitle: anyNamed('linkedRecordTitle'),
        ),
      ).thenAnswer((_) => Future.value(1));
    }

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
            petVaccinationsControllerProvider(petId).future,
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
            petVaccinationsControllerProvider(petId).future,
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
          () => container.read(petVaccinationsControllerProvider(petId).future),
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
            petVaccinationsControllerProvider(petId).future,
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

    group('save', () {
      testWidgets(
        'Should call createPetVaccination When petVaccinationId is null',
        (tester) async {
          int petId = 7;
          final initialPetVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: petId,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2024, 6, 1),
            reminderDate: DateTime(2024, 5, 1),
            notes: 'All went well',
            vaccineBatchNumber: 'batch 123',
            vaccineManufacturer: 'Vaccine Manufacturer',
            administeredBy: 'Dr. Smith',
          );

          final initialPetVaccinationModel = PetVaccinationModel(
            petId: initialPetVaccination.pet,
            name: initialPetVaccination.name,
            administeredDate: initialPetVaccination.administeredDate,
            expiryDate: initialPetVaccination.expiryDate,
            reminderDate: initialPetVaccination.reminderDate,
            notes: initialPetVaccination.notes,
            vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
            vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
            administeredBy: initialPetVaccination.administeredBy,
          );

          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.createPetVaccination(
              initialPetVaccinationModel.petId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).thenAnswer((_) => Future.value(initialPetVaccination));
          setupMockDatabaseForJournalEntry(false);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          PetVaccinationModel? savedPetVaccination = await provider.save(
            initialPetVaccinationModel,
          );

          // ASSERT
          expect(savedPetVaccination, isNotNull);
          expect(
            savedPetVaccination!.petVaccinationId,
            initialPetVaccination.petVaccinationId,
          );

          verify(
            mockDatabaseService.createPetVaccination(
              initialPetVaccinationModel.petId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets('Should call updatePetWeight When petWeightId is not null', (
        tester,
      ) async {
        int petId = 7;
        final initialPetVaccination = PetVaccination(
          petVaccinationId: 1,
          pet: petId,
          name: 'Rabies',
          administeredDate: DateTime(2024, 5, 28),
          expiryDate: DateTime(2024, 6, 1),
          reminderDate: DateTime(2024, 5, 1),
          notes: 'All went well',
          vaccineBatchNumber: 'batch 123',
          vaccineManufacturer: 'Vaccine Manufacturer',
          administeredBy: 'Dr. Smith',
        );

        final initialPetVaccinationModel = PetVaccinationModel(
          petVaccinationId: initialPetVaccination.petVaccinationId,
          petId: initialPetVaccination.pet,
          name: initialPetVaccination.name,
          administeredDate: initialPetVaccination.administeredDate,
          expiryDate: initialPetVaccination.expiryDate,
          reminderDate: initialPetVaccination.reminderDate,
          notes: initialPetVaccination.notes,
          vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
          vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
          administeredBy: initialPetVaccination.administeredBy,
        );

        when(
          mockDatabaseService.getAllPetVaccinationsForPet(petId),
        ).thenAnswer((_) => Stream.empty());
        when(
          mockDatabaseService.updatePetVaccination(
            initialPetVaccinationModel.petVaccinationId,
            initialPetVaccinationModel.name,
            initialPetVaccinationModel.administeredDate,
            initialPetVaccinationModel.expiryDate,
            initialPetVaccinationModel.reminderDate,
            initialPetVaccinationModel.notes,
            initialPetVaccinationModel.vaccineBatchNumber,
            initialPetVaccinationModel.vaccineManufacturer,
            initialPetVaccinationModel.administeredBy,
          ),
        ).thenAnswer((_) => Future.value(1));
        setupMockDatabaseForJournalEntry(false);

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final provider = container.read(
          petVaccinationsControllerProvider(petId).notifier,
        );
        PetVaccinationModel? savedPetVaccination = await provider.save(
          initialPetVaccinationModel,
        );

        // ASSERT
        expect(savedPetVaccination, isNotNull);
        expect(
          savedPetVaccination!.petVaccinationId,
          initialPetVaccination.petVaccinationId,
        );

        verify(
          mockDatabaseService.updatePetVaccination(
            initialPetVaccinationModel.petVaccinationId,
            initialPetVaccinationModel.name,
            initialPetVaccinationModel.administeredDate,
            initialPetVaccinationModel.expiryDate,
            initialPetVaccinationModel.reminderDate,
            initialPetVaccinationModel.notes,
            initialPetVaccinationModel.vaccineBatchNumber,
            initialPetVaccinationModel.vaccineManufacturer,
            initialPetVaccinationModel.administeredBy,
          ),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('delete', () {
      testWidgets(
        'Should call deletePetVaccination When petVaccinationId is not null',
        (tester) async {
          int petId = 1;
          int petVaccinationId = 5;
          final databaseService = MockDatabaseService();
          when(
            databaseService.deletePetVaccination(petVaccinationId),
          ).thenAnswer((_) async => petVaccinationId);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(databaseService),
            ],
          );
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          int result = await provider.deletePetVaccination(petVaccinationId);

          expect(result, petVaccinationId);
          verify(
            databaseService.deletePetVaccination(petVaccinationId),
          ).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });

    group('create / update linked Journal Entries', () {
      testWidgets(
        'Should create a linked journal entry when call createPetMed with setting createLinkedJournalEntries = true',
        (tester) async {
          int petId = 7;
          final initialPetVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: petId,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2024, 6, 1),
            reminderDate: DateTime(2024, 5, 1),
            notes: 'All went well',
            vaccineBatchNumber: 'batch 123',
            vaccineManufacturer: 'Vaccine Manufacturer',
            administeredBy: 'Dr. Smith',
          );

          final initialPetVaccinationModel = PetVaccinationModel(
            petId: initialPetVaccination.pet,
            name: initialPetVaccination.name,
            administeredDate: initialPetVaccination.administeredDate,
            expiryDate: initialPetVaccination.expiryDate,
            reminderDate: initialPetVaccination.reminderDate,
            notes: initialPetVaccination.notes,
            vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
            vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
            administeredBy: initialPetVaccination.administeredBy,
          );

          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.createPetVaccination(
              initialPetVaccinationModel.petId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).thenAnswer((_) => Future.value(initialPetVaccination));
          setupMockDatabaseForJournalEntry(true);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          PetVaccinationModel? savedPetVaccination = await provider.save(
            initialPetVaccinationModel,
          );

          // ASSERT
          verify(
            mockDatabaseService.createJournalEntryForPet(
              entryText: anyNamed('entryText'),
              petIdList: anyNamed('petIdList'),
              tags: anyNamed('tags'),
              linkedRecordId: savedPetVaccination!.petVaccinationId!,
              linkedRecordType: LinkedRecordType.vaccination,
              linkedRecordTitle: 'Vaccination ${savedPetVaccination.name} administered',
            ),
          ).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should not create a linked journal entry when call createPetMed with setting createLinkedJournalEntries = false',
        (tester) async {
          int petId = 7;
          final initialPetVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: petId,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2024, 6, 1),
            reminderDate: DateTime(2024, 5, 1),
            notes: 'All went well',
            vaccineBatchNumber: 'batch 123',
            vaccineManufacturer: 'Vaccine Manufacturer',
            administeredBy: 'Dr. Smith',
          );

          final initialPetVaccinationModel = PetVaccinationModel(
            petId: initialPetVaccination.pet,
            name: initialPetVaccination.name,
            administeredDate: initialPetVaccination.administeredDate,
            expiryDate: initialPetVaccination.expiryDate,
            reminderDate: initialPetVaccination.reminderDate,
            notes: initialPetVaccination.notes,
            vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
            vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
            administeredBy: initialPetVaccination.administeredBy,
          );

          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.createPetVaccination(
              initialPetVaccinationModel.petId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).thenAnswer((_) => Future.value(initialPetVaccination));
          setupMockDatabaseForJournalEntry(false);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          await provider.save(initialPetVaccinationModel);

          // ASSERT
          verifyNever(
            mockDatabaseService.createJournalEntryForPet(
              entryText: anyNamed('entryText'),
              petIdList: anyNamed('petIdList'),
              tags: anyNamed('tags'),
              linkedRecordId: anyNamed('linkedRecordId'),
              linkedRecordType: anyNamed('linkedRecordType'),
              linkedRecordTitle: anyNamed('linkedRecordTitle'),
            ),
          );

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'Should update a linked journal entry when call updatePetMed with setting createLinkedJournalEntries = true',
        (tester) async {
          int petId = 7;
          final initialPetVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: petId,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2024, 6, 1),
            reminderDate: DateTime(2024, 5, 1),
            notes: 'All went well',
            vaccineBatchNumber: 'batch 123',
            vaccineManufacturer: 'Vaccine Manufacturer',
            administeredBy: 'Dr. Smith',
          );

          final initialPetVaccinationModel = PetVaccinationModel(
            petVaccinationId: initialPetVaccination.petVaccinationId,
            petId: initialPetVaccination.pet,
            name: initialPetVaccination.name,
            administeredDate: initialPetVaccination.administeredDate,
            expiryDate: initialPetVaccination.expiryDate,
            reminderDate: initialPetVaccination.reminderDate,
            notes: initialPetVaccination.notes,
            vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
            vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
            administeredBy: initialPetVaccination.administeredBy,
          );

          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.updatePetVaccination(
              initialPetVaccinationModel.petVaccinationId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).thenAnswer((_) => Future.value(1));
          setupMockDatabaseForJournalEntry(true);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          PetVaccinationModel? savedPetVaccination = await provider.save(
            initialPetVaccinationModel,
          );

          // ASSERT
          verify(
            mockDatabaseService.updateLinkedJournalEntry(
              linkedRecordId: savedPetVaccination!.petVaccinationId,
              linkedRecordType: LinkedRecordType.vaccination,
              linkedRecordTitle:
                  'Vaccination ${savedPetVaccination.name} administered (updated)',
            ),
          ).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'Should not update a linked journal entry when call updatePetMed with setting createLinkedJournalEntries = false',
        (tester) async {
          int petId = 7;
          final initialPetVaccination = PetVaccination(
            petVaccinationId: 1,
            pet: petId,
            name: 'Rabies',
            administeredDate: DateTime(2024, 5, 28),
            expiryDate: DateTime(2024, 6, 1),
            reminderDate: DateTime(2024, 5, 1),
            notes: 'All went well',
            vaccineBatchNumber: 'batch 123',
            vaccineManufacturer: 'Vaccine Manufacturer',
            administeredBy: 'Dr. Smith',
          );

          final initialPetVaccinationModel = PetVaccinationModel(
            petVaccinationId: initialPetVaccination.petVaccinationId,
            petId: initialPetVaccination.pet,
            name: initialPetVaccination.name,
            administeredDate: initialPetVaccination.administeredDate,
            expiryDate: initialPetVaccination.expiryDate,
            reminderDate: initialPetVaccination.reminderDate,
            notes: initialPetVaccination.notes,
            vaccineBatchNumber: initialPetVaccination.vaccineBatchNumber,
            vaccineManufacturer: initialPetVaccination.vaccineManufacturer,
            administeredBy: initialPetVaccination.administeredBy,
          );

          when(
            mockDatabaseService.getAllPetVaccinationsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.updatePetVaccination(
              initialPetVaccinationModel.petVaccinationId,
              initialPetVaccinationModel.name,
              initialPetVaccinationModel.administeredDate,
              initialPetVaccinationModel.expiryDate,
              initialPetVaccinationModel.reminderDate,
              initialPetVaccinationModel.notes,
              initialPetVaccinationModel.vaccineBatchNumber,
              initialPetVaccinationModel.vaccineManufacturer,
              initialPetVaccinationModel.administeredBy,
            ),
          ).thenAnswer((_) => Future.value(1));
          setupMockDatabaseForJournalEntry(false);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petVaccinationsControllerProvider(petId).notifier,
          );
          await provider.save(initialPetVaccinationModel);

          // ASSERT
          verifyNever(
            mockDatabaseService.updateLinkedJournalEntry(
              linkedRecordId: anyNamed('linkedRecordId'),
              linkedRecordType: anyNamed('linkedRecordType'),
              linkedRecordTitle: anyNamed('linkedRecordTitle'),
            ),
          );

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });
  });
}
