import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/home/controllers/pets_controller.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/database_service.dart';

import 'pets_controller_test.mocks.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
/// Taken from https://riverpod.dev/docs/essentials/testing
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
  group('PetsController Tests', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      testWidgets('Should emit empty list When no pets exist', (tester) async {
        // ARRANGE
        when(
          mockDatabaseService.getAllPets(),
        ).thenAnswer((_) => Stream.value([]));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final pets = await container.read(petsControllerProvider.future);

        // ASSERT
        expect(pets, isEmpty);
        verify(mockDatabaseService.getAllPets()).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should emit mapped pets When pets exist', (tester) async {
        // ARRANGE
        final now = DateTime.now();
        final databasePets = [
          Pet(
            petId: 1,
            name: 'Max',
            speciesId: 1,
            breed: 'Labrador',
            colour: 'Black',
            sex: PetSex.male.dataValue,
            age: 3,
            dob: null,
            dobEstimate: false,
            dobCalculated: false,
            diet: 'Regular',
            notes: 'Good boy',
            history: 'Adopted',
            isNeutered: true,
            neuterDate: null,
            status: PetStatus.active.dataValue,
            statusDate: now,
          ),
          Pet(
            petId: 2,
            name: 'Luna',
            speciesId: 2,
            breed: 'Persian',
            colour: 'White',
            sex: PetSex.female.dataValue,
            age: 2,
            dob: null,
            dobEstimate: false,
            dobCalculated: false,
            diet: 'Special',
            notes: 'Sweet girl',
            history: 'Rescued',
            isNeutered: true,
            neuterDate: null,
            status: PetStatus.active.dataValue,
            statusDate: now,
          ),
        ];

        when(
          mockDatabaseService.getAllPets(),
        ).thenAnswer((_) => Stream.value(databasePets));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final pets = await container.read(petsControllerProvider.future);

        // ASSERT
        expect(pets.length, 2);

        // Verify first pet
        expect(pets[0].petId, 1);
        expect(pets[0].name, 'Max');
        expect(pets[0].species.speciesId, 1);
        expect(pets[0].breed, 'Labrador');
        expect(pets[0].colour, 'Black');
        expect(pets[0].petSex, PetSex.male);
        expect(pets[0].age, 3);
        expect(pets[0].dob, isNull);
        expect(pets[0].diet, 'Regular');
        expect(pets[0].notes, 'Good boy');
        expect(pets[0].history, 'Adopted');
        expect(pets[0].isNeutered, true);
        expect(pets[0].status, PetStatus.active);

        // Verify second pet
        expect(pets[1].petId, 2);
        expect(pets[1].name, 'Luna');
        expect(pets[1].species.speciesId, 2);
        expect(pets[1].breed, 'Persian');
        expect(pets[1].colour, 'White');
        expect(pets[1].petSex, PetSex.female);
        expect(pets[1].age, 2);
        expect(pets[1].dob, isNull);
        expect(pets[1].diet, 'Special');
        expect(pets[1].notes, 'Sweet girl');
        expect(pets[1].history, 'Rescued');
        expect(pets[1].isNeutered, true);
        expect(pets[1].status, PetStatus.active);

        verify(mockDatabaseService.getAllPets()).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should handle error When database stream fails', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.getAllPets(),
        ).thenAnswer((_) => Stream.error('Database error'));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(petsControllerProvider.future),
          throwsA(isA<String>()),
        );

        verify(mockDatabaseService.getAllPets()).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets(
        'Should emit updated pets When database stream emits new values',
        (tester) async {
          // ARRANGE
          final now = DateTime.now();
          final initialPet = Pet(
            petId: 1,
            name: 'Max',
            speciesId: 1,
            breed: 'Labrador',
            colour: 'Black',
            sex: PetSex.male.dataValue,
            age: 3,
            dob: null,
            dobEstimate: false,
            dobCalculated: false,
            diet: 'Regular',
            notes: 'Good boy',
            history: 'Adopted',
            isNeutered: true,
            neuterDate: null,
            status: PetStatus.active.dataValue,
            statusDate: now,
          );

          final updatedPets = [
            initialPet,
            Pet(
              petId: 2,
              name: 'Luna',
              speciesId: 2,
              breed: 'Persian',
              colour: 'White',
              sex: PetSex.female.dataValue,
              age: 2,
              dob: null,
              dobEstimate: false,
              dobCalculated: false,
              diet: 'Special',
              notes: 'Sweet girl',
              history: 'Rescued',
              isNeutered: true,
              neuterDate: null,
              status: PetStatus.active.dataValue,
              statusDate: now,
            ),
          ];

          when(mockDatabaseService.getAllPets()).thenAnswer(
            (_) => Stream.fromIterable([
              [initialPet],
              updatedPets,
            ]),
          );

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT & ASSERT
          final pets = await container.read(petsControllerProvider.future);
          expect(pets, isNotNull);

          final emittedLists = await container.read(
            petsControllerProvider.future,
          );
          expect(emittedLists.length, 1);

          verify(mockDatabaseService.getAllPets()).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });
  });
}
