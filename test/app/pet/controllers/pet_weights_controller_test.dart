import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_weights_controller.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/defaults.dart' as defaults;
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_weight_mapper.dart';
import 'package:matcher/matcher.dart' as match;

import 'pet_weights_controller_test.mocks.dart';

/// See implementation: lib/app/pet/controller/pet_weights_controller.dart
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
  group('PetWeightsController', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    setupMockDatabaseForJournalEntry(bool createLinkedJournalEntries) {
      when(mockDatabaseService.watchSettings()).thenAnswer(
        (_) => Stream.value(
          Setting(
            settingsId: defaults.defaultSettingsId,
            acceptedTermsAndConditions: true,
            optIntoAnalyticsWarning: true,
            onBoardingComplete: true,
            defaultWeightUnit: WeightUnits.metric.dataValue,
            createLinkedJournalEntries: createLinkedJournalEntries,
          ),
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
        'build should emit PetWeightModel list when database returns data',
        () async {
          // ARRANGE
          const petId = 1;
          final petWeights = [
            PetWeight(
              petWeightId: 1,
              pet: petId,
              date: DateTime(2024, 5, 28),
              weight: 12.5,
              weightUnit: 1,
              notes: 'Healthy',
            ),
          ];
          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.value(petWeights));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petWeightsControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetWeightModel>>());
          expect(result.length, 1);
          expect(result.first.petWeightId, 1);
          verify(mockDatabaseService.getAllPetWeightsForPet(petId)).called(1);
        },
      );

      test(
        'build should emit empty list when database returns empty',
        () async {
          // ARRANGE
          const petId = 2;
          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.value([]));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petWeightsControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetWeightModel>>());
          expect(result, isEmpty);
          verify(mockDatabaseService.getAllPetWeightsForPet(petId)).called(1);
        },
      );

      test('build should emit error when database throws', () async {
        // ARRANGE
        const petId = 3;
        when(
          mockDatabaseService.getAllPetWeightsForPet(petId),
        ).thenAnswer((_) => Stream.error(Exception('db error')));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(petWeightsControllerProvider(petId).future),
          throwsA(match.isA<Exception>()),
        );
        verify(mockDatabaseService.getAllPetWeightsForPet(petId)).called(1);
      });

      test(
        'build should emit updated values when database emits multiple events',
        () async {
          // ARRANGE
          const petId = 4;
          final petWeights1 = [
            PetWeight(
              petWeightId: 1,
              pet: petId,
              date: DateTime(2024, 5, 28),
              weight: 12.5,
              weightUnit: 1,
              notes: 'Healthy',
            ),
          ];
          final petWeights2 = [
            PetWeight(
              petWeightId: 2,
              pet: petId,
              date: DateTime(2024, 6, 1),
              weight: 13.0,
              weightUnit: 1,
              notes: 'Gained weight',
            ),
          ];
          final controller = StreamController<List<PetWeight>>();
          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => controller.stream);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final stream = container.listen(
            petWeightsControllerProvider(petId).future,
            (_, __) {},
          );

          controller.add(petWeights1);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(
            await stream.read(),
            PetWeightMapper.mapToModelList(petWeights1),
          );

          controller.add(petWeights2);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(
            await stream.read(),
            PetWeightMapper.mapToModelList(petWeights2),
          );

          await controller.close();
        },
      );
    });

    group('save', () {
      testWidgets('Should call createPetWeight When petWeightId is null', (
        tester,
      ) async {
        int petId = 7;
        final initialPetWeight = PetWeight(
          petWeightId: 1,
          pet: petId,
          date: DateTime(2024, 5, 28),
          weight: 12.5,
          weightUnit: 1,
          notes: 'Test Weight',
        );

        final initialPetWeightModel = PetWeightModel(
          petId: initialPetWeight.pet,
          date: initialPetWeight.date,
          weight: initialPetWeight.weight,
          weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
          notes: initialPetWeight.notes,
        );

        when(
          mockDatabaseService.getAllPetWeightsForPet(petId),
        ).thenAnswer((_) => Stream.empty());
        when(
          mockDatabaseService.createPetWeight(
            initialPetWeightModel.petId,
            initialPetWeightModel.date,
            initialPetWeightModel.weight,
            initialPetWeightModel.weightUnit,
            initialPetWeightModel.notes,
          ),
        ).thenAnswer((_) => Future.value(initialPetWeight));
        setupMockDatabaseForJournalEntry(false);

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final provider = container.read(
          petWeightsControllerProvider(petId).notifier,
        );
        PetWeightModel? savedPetWeight = await provider.save(
          initialPetWeightModel,
        );

        // ASSERT
        expect(savedPetWeight, isNotNull);
        expect(savedPetWeight!.petWeightId, initialPetWeight.petWeightId);

        verify(
          mockDatabaseService.createPetWeight(
            initialPetWeightModel.petId,
            initialPetWeightModel.date,
            initialPetWeightModel.weight,
            initialPetWeightModel.weightUnit,
            initialPetWeightModel.notes,
          ),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should call updatePetWeight When petWeightId is not null', (
        tester,
      ) async {
        int petId = 7;
        final initialPetWeight = PetWeight(
          petWeightId: 1,
          pet: petId,
          date: DateTime(2024, 5, 28),
          weight: 12.5,
          weightUnit: 1,
          notes: 'Test Weight',
        );

        final initialPetWeightModel = PetWeightModel(
          petWeightId: initialPetWeight.petWeightId,
          petId: initialPetWeight.pet,
          date: initialPetWeight.date,
          weight: initialPetWeight.weight,
          weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
          notes: initialPetWeight.notes,
        );

        when(
          mockDatabaseService.getAllPetWeightsForPet(petId),
        ).thenAnswer((_) => Stream.empty());
        when(
          mockDatabaseService.updatePetWeight(
            initialPetWeightModel.petWeightId,
            initialPetWeightModel.date,
            initialPetWeightModel.weight,
            initialPetWeightModel.weightUnit,
            initialPetWeightModel.notes,
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
          petWeightsControllerProvider(petId).notifier,
        );
        PetWeightModel? savedPetWeight = await provider.save(
          initialPetWeightModel,
        );

        // ASSERT
        expect(savedPetWeight, isNotNull);
        expect(savedPetWeight!.petWeightId, initialPetWeight.petWeightId);

        verify(
          mockDatabaseService.updatePetWeight(
            initialPetWeightModel.petWeightId,
            initialPetWeightModel.date,
            initialPetWeightModel.weight,
            initialPetWeightModel.weightUnit,
            initialPetWeightModel.notes,
          ),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('delete', () {
      testWidgets('Should call deletePetWeight When petWeightId is not null', (
        tester,
      ) async {
        int petId = 1;
        int petWeightId = 5;
        final databaseService = MockDatabaseService();
        when(
          databaseService.deletePetWeight(petWeightId),
        ).thenAnswer((_) async => petWeightId);

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(databaseService),
          ],
        );
        final provider = container.read(
          petWeightsControllerProvider(petId).notifier,
        );
        int result = await provider.deletePetWeight(petWeightId);

        expect(result, petWeightId);
        verify(databaseService.deletePetWeight(petWeightId)).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('create / update linked Journal Entries', () {
      testWidgets(
        'Should create a linked journal entry when call createPetMed with setting createLinkedJournalEntries = true',
        (tester) async {
          int petId = 7;
          final initialPetWeight = PetWeight(
            petWeightId: 1,
            pet: petId,
            date: DateTime(2024, 5, 28),
            weight: 12.5,
            weightUnit: 1,
            notes: 'Test Weight',
          );

          final initialPetWeightModel = PetWeightModel(
            petId: initialPetWeight.pet,
            date: initialPetWeight.date,
            weight: initialPetWeight.weight,
            weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
            notes: initialPetWeight.notes,
          );

          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.createPetWeight(
              initialPetWeightModel.petId,
              initialPetWeightModel.date,
              initialPetWeightModel.weight,
              initialPetWeightModel.weightUnit,
              initialPetWeightModel.notes,
            ),
          ).thenAnswer((_) => Future.value(initialPetWeight));
          setupMockDatabaseForJournalEntry(true);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petWeightsControllerProvider(petId).notifier,
          );
          PetWeightModel? savedPetWeight = await provider.save(
            initialPetWeightModel,
          );

          // ASSERT
          verify(
            mockDatabaseService.createJournalEntryForPet(
              entryText: anyNamed('entryText'),
              petIdList: anyNamed('petIdList'),
              tags: anyNamed('tags'),
              linkedRecordId: savedPetWeight!.petWeightId!,
              linkedRecordType: LinkedRecordType.weight,
              linkedRecordTitle: 'Weight ${savedPetWeight.niceName()} recorded',
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
          final initialPetWeight = PetWeight(
            petWeightId: 1,
            pet: petId,
            date: DateTime(2024, 5, 28),
            weight: 12.5,
            weightUnit: 1,
            notes: 'Test Weight',
          );

          final initialPetWeightModel = PetWeightModel(
            petId: initialPetWeight.pet,
            date: initialPetWeight.date,
            weight: initialPetWeight.weight,
            weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
            notes: initialPetWeight.notes,
          );

          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.createPetWeight(
              initialPetWeightModel.petId,
              initialPetWeightModel.date,
              initialPetWeightModel.weight,
              initialPetWeightModel.weightUnit,
              initialPetWeightModel.notes,
            ),
          ).thenAnswer((_) => Future.value(initialPetWeight));
          setupMockDatabaseForJournalEntry(false);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final provider = container.read(
            petWeightsControllerProvider(petId).notifier,
          );
          await provider.save(initialPetWeightModel);

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
          final initialPetWeight = PetWeight(
            petWeightId: 1,
            pet: petId,
            date: DateTime(2024, 5, 28),
            weight: 12.5,
            weightUnit: 1,
            notes: 'Test Weight',
          );

          final initialPetWeightModel = PetWeightModel(
            petWeightId: initialPetWeight.petWeightId,
            petId: initialPetWeight.pet,
            date: initialPetWeight.date,
            weight: initialPetWeight.weight,
            weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
            notes: initialPetWeight.notes,
          );

          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.updatePetWeight(
              initialPetWeightModel.petWeightId,
              initialPetWeightModel.date,
              initialPetWeightModel.weight,
              initialPetWeightModel.weightUnit,
              initialPetWeightModel.notes,
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
            petWeightsControllerProvider(petId).notifier,
          );
          PetWeightModel? savedPetWeight = await provider.save(
            initialPetWeightModel,
          );

          // ASSERT
          verify(
            mockDatabaseService.updateLinkedJournalEntry(
              linkedRecordId: savedPetWeight!.petWeightId,
              linkedRecordType: LinkedRecordType.weight,
              linkedRecordTitle:
                  'Weight ${savedPetWeight.niceName()} recorded (updated)',
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
          final initialPetWeight = PetWeight(
            petWeightId: 1,
            pet: petId,
            date: DateTime(2024, 5, 28),
            weight: 12.5,
            weightUnit: 1,
            notes: 'Test Weight',
          );

          final initialPetWeightModel = PetWeightModel(
            petWeightId: initialPetWeight.petWeightId,
            petId: initialPetWeight.pet,
            date: initialPetWeight.date,
            weight: initialPetWeight.weight,
            weightUnit: WeightUnits.fromDataValue(initialPetWeight.weightUnit),
            notes: initialPetWeight.notes,
          );

          when(
            mockDatabaseService.getAllPetWeightsForPet(petId),
          ).thenAnswer((_) => Stream.empty());
          when(
            mockDatabaseService.updatePetWeight(
              initialPetWeightModel.petWeightId,
              initialPetWeightModel.date,
              initialPetWeightModel.weight,
              initialPetWeightModel.weightUnit,
              initialPetWeightModel.notes,
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
            petWeightsControllerProvider(petId).notifier,
          );
          await provider.save(initialPetWeightModel);

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
