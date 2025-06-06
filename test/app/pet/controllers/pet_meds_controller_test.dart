import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/controller/pet_meds_controller.dart';
import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_med_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matcher/matcher.dart' as match;

import 'pet_meds_controller_test.mocks.dart';

/// See implementation: lib/app/pet/controller/pet_meds_controller.dart
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
  group('PetMedsController', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      test(
        'build should emit PetMedModel list when database returns data',
        () async {
          // ARRANGE
          const petId = 1;
          final petMeds = [
            PetMed(
              petMedId: 1,
              pet: petId,
              name: 'Antibiotic',
              dose: '5mg',
              startDate: DateTime(2024, 5, 28),
              endDate: DateTime(2024, 6, 1),
              notes: 'Take with food',
            ),
          ];
          when(
            mockDatabaseService.getAllPetMedsForPet(petId),
          ).thenAnswer((_) => Stream.value(petMeds));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petMedsControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetMedModel>>());
          expect(result?.length, 1);
          expect(result?.first.petMedId, 1);
          verify(mockDatabaseService.getAllPetMedsForPet(petId)).called(1);
        },
      );

      test(
        'build should emit empty list when database returns empty',
        () async {
          // ARRANGE
          const petId = 2;
          when(
            mockDatabaseService.getAllPetMedsForPet(petId),
          ).thenAnswer((_) => Stream.value([]));

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final result = await container.read(
            petMedsControllerProvider(petId).future,
          );

          // ASSERT
          expect(result, isA<List<PetMedModel>>());
          expect(result, isEmpty);
          verify(mockDatabaseService.getAllPetMedsForPet(petId)).called(1);
        },
      );

      test('build should emit error when database throws', () async {
        // ARRANGE
        const petId = 4;
        when(
          mockDatabaseService.getAllPetMedsForPet(petId),
        ).thenAnswer((_) => Stream.error(Exception('db error')));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(petMedsControllerProvider(petId).future),
          throwsA(match.isA<Exception>()),
        );
        verify(mockDatabaseService.getAllPetMedsForPet(petId)).called(1);
      });

      test(
        'build should emit updated values when database emits multiple events',
        () async {
          // ARRANGE
          const petId = 5;
          final petMeds1 = [
            PetMed(
              petMedId: 1,
              pet: petId,
              name: 'Antibiotic',
              dose: '5mg',
              startDate: DateTime(2024, 5, 28),
              endDate: DateTime(2024, 6, 1),
              notes: 'Take with food',
            ),
          ];
          final petMeds2 = [
            PetMed(
              petMedId: 2,
              pet: petId,
              name: 'Painkiller',
              dose: '10mg',
              startDate: DateTime(2024, 7, 1),
              endDate: null,
              notes: null,
            ),
          ];
          final controller = StreamController<List<PetMed>>();
          when(
            mockDatabaseService.getAllPetMedsForPet(petId),
          ).thenAnswer((_) => controller.stream);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT
          final stream = container.listen(
            petMedsControllerProvider(petId).future,
            (_, __) {},
          );

          controller.add(petMeds1);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(await stream.read(), PetMedMapper.mapToModelList(petMeds1));

          controller.add(petMeds2);
          await Future.delayed(const Duration(milliseconds: 10));
          expect(await stream.read(), PetMedMapper.mapToModelList(petMeds2));

          await controller.close();
        },
      );
    });
  });
}
