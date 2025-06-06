import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_weights_controller.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
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

    group('build', () {
      test('build should emit PetWeightModel list when database returns data', () async {
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
        when(mockDatabaseService.getAllPetWeightsForPet(petId))
            .thenAnswer((_) => Stream.value(petWeights));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final result = await container.read(petWeightsControllerProvider(petId).future);

        // ASSERT
        expect(result, isA<List<PetWeightModel>>());
        expect(result.length, 1);
        expect(result.first.petWeightId, 1);
        verify(mockDatabaseService.getAllPetWeightsForPet(petId)).called(1);
      });

      test('build should emit empty list when database returns empty', () async {
        // ARRANGE
        const petId = 2;
        when(mockDatabaseService.getAllPetWeightsForPet(petId))
            .thenAnswer((_) => Stream.value([]));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final result = await container.read(petWeightsControllerProvider(petId).future);

        // ASSERT
        expect(result, isA<List<PetWeightModel>>());
        expect(result, isEmpty);
        verify(mockDatabaseService.getAllPetWeightsForPet(petId)).called(1);
      });

      test('build should emit error when database throws', () async {
        // ARRANGE
        const petId = 3;
        when(mockDatabaseService.getAllPetWeightsForPet(petId))
            .thenAnswer((_) => Stream.error(Exception('db error')));

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

      test('build should emit updated values when database emits multiple events', () async {
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
        when(mockDatabaseService.getAllPetWeightsForPet(petId))
            .thenAnswer((_) => controller.stream);

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
        expect(await stream.read(), PetWeightMapper.mapToModelList(petWeights1));

        controller.add(petWeights2);
        await Future.delayed(const Duration(milliseconds: 10));
        expect(await stream.read(), PetWeightMapper.mapToModelList(petWeights2));

        await controller.close();
      });
    });
  });
}