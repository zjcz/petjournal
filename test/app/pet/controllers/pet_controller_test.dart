import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/controller/all_pets_controller.dart';
import 'package:petjournal/app/pet/controller/pet_controller.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/database_service.dart';

import '../../../testhelpers/stream_helper.dart';
import 'pet_controller_test.mocks.dart';

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
  group('PetController Tests', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      testWidgets('Should emit null When pet does not exist', (tester) async {
        // ARRANGE
        when(
          mockDatabaseService.watchPet(1),
        ).thenAnswer((_) => Stream.value(null));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final pet = await container.read(petControllerProvider(1).future);

        // ASSERT
        expect(pet, isNull);
        verify(mockDatabaseService.watchPet(1)).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should emit mapped pet When pet exist', (tester) async {
        // ARRANGE
        final now = DateTime.now();
        final databasePet = Pet(
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

        when(
          mockDatabaseService.watchPet(1),
        ).thenAnswer((_) => Stream.value(databasePet));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final pet = await container.read(petControllerProvider(1).future);

        // ASSERT
        expect(pet, isNotNull);

        // Verify first pet
        expect(pet!.petId, 1);
        expect(pet.name, 'Max');
        expect(pet.species.speciesId, 1);
        expect(pet.breed, 'Labrador');
        expect(pet.colour, 'Black');
        expect(pet.petSex, PetSex.male);
        expect(pet.age, 3);
        expect(pet.dob, isNull);
        expect(pet.diet, 'Regular');
        expect(pet.notes, 'Good boy');
        expect(pet.history, 'Adopted');
        expect(pet.isNeutered, true);
        expect(pet.status, PetStatus.active);

        verify(mockDatabaseService.watchPet(1)).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should handle error When database stream fails', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.watchPet(1),
        ).thenAnswer((_) => Stream.error('Database error'));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(petControllerProvider(1).future),
          throwsA(isA<String>()),
        );

        verify(mockDatabaseService.watchPet(1)).called(1);

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

          final updatedPet = Pet(
            petId: 1,
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
          );

          when(mockDatabaseService.watchPet(1)).thenAnswer(
            (_) => streamWithUpdate(
              initialPet,
              updatedPet,
              const Duration(milliseconds: 100),
            ),
          );

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT & ASSERT
          final petSubscription = container.listen(
            petControllerProvider(1).future,
            (_, __) {},
          );
          var pet = await petSubscription.read();
          expect(pet, isNotNull);
          expect(pet!.petId, 1);
          expect(pet.name, 'Max');

          // wait 100 milliseconds
          await tester.pump(const Duration(milliseconds: 100));

          pet = await petSubscription.read();
          expect(pet, isNotNull);
          expect(pet!.petId, 1);
          expect(pet.name, 'Luna');

          verify(mockDatabaseService.watchPet(1)).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });
  });
}
