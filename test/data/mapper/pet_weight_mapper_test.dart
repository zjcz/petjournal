import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/pet_weight_mapper.dart';
import 'package:matcher/matcher.dart' as match;

/// Unit tests for [PetWeightMapper].
void main() {
  group('PetWeightMapper', () {
    /// Tests for mapToModel
    group('mapToModel', () {
      test(
        'mapToModel should return correct PetWeightModel when PetWeight is valid',
        () {
          // Arrange
          final petWeight = PetWeight(
            petWeightId: 1,
            pet: 2,
            date: DateTime(2024, 5, 28),
            weightKg: 12.5,
            notes: 'Healthy',
          );

          // Act
          final result = PetWeightMapper.mapToModel(petWeight);

          // Assert
          expect(result.petWeightId, 1);
          expect(result.petId, 2);
          expect(result.date, DateTime(2024, 5, 28));
          expect(result.weightKg, 12.5);
          expect(result.notes, 'Healthy');
        },
      );

      test(
        'mapToModel should set notes to null when PetWeight notes is null',
        () {
          // Arrange
          final petWeight = PetWeight(
            petWeightId: 3,
            pet: 4,
            date: DateTime(2022, 2, 2),
            weightKg: 7.7,
            notes: null,
          );

          // Act
          final result = PetWeightMapper.mapToModel(petWeight);

          // Assert
          expect(result.notes, match.isNull);
        },
      );
    });

    /// Tests for mapToModelList
    group('mapToModelList', () {
      test('mapToModelList should return empty list when input is empty', () {
        // Arrange
        final petWeights = <PetWeight>[];

        // Act
        final result = PetWeightMapper.mapToModelList(petWeights);

        // Assert
        expect(result, isA<List<PetWeightModel>>());
        expect(result, isEmpty);
      });

      test(
        'mapToModelList should return correct list when input has multiple PetWeight objects',
        () {
          // Arrange
          final petWeights = [
            PetWeight(
              petWeightId: 1,
              pet: 2,
              date: DateTime(2024, 5, 28),
              weightKg: 12.5,
              notes: 'Healthy',
            ),
            PetWeight(
              petWeightId: 3,
              pet: 4,
              date: DateTime(2022, 2, 2),
              weightKg: 7.7,
              notes: null,
            ),
          ];

          // Act
          final result = PetWeightMapper.mapToModelList(petWeights);

          // Assert
          expect(result.length, 2);
          expect(result[0].petWeightId, 1);
          expect(result[1].petWeightId, 3);
        },
      );
    });
  });
}
