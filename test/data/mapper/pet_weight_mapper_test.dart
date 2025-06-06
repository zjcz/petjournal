import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/weight_units.dart';
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
            weight: 12.5,
            weightUnit: WeightUnits.imperial.dataValue,
            notes: 'Healthy',
          );

          // Act
          final result = PetWeightMapper.mapToModel(petWeight);

          // Assert
          expect(result.petWeightId, 1);
          expect(result.petId, 2);
          expect(result.date, DateTime(2024, 5, 28));
          expect(result.weight, 12.5);
          expect(result.weightUnit, WeightUnits.imperial);
          expect(result.notes, 'Healthy');
        },
      );

      test('mapToModel should map WeightUnits.metric correctly', () {
        // Arrange
        final petWeight = PetWeight(
          petWeightId: 10,
          pet: 20,
          date: DateTime(2023, 1, 1),
          weight: 5.0,
          weightUnit: WeightUnits.metric.dataValue,
          notes: 'Metric',
        );

        // Act
        final result = PetWeightMapper.mapToModel(petWeight);

        // Assert
        expect(result.weightUnit, WeightUnits.metric);
      });

      test(
        'mapToModel should set notes to null when PetWeight notes is null',
        () {
          // Arrange
          final petWeight = PetWeight(
            petWeightId: 3,
            pet: 4,
            date: DateTime(2022, 2, 2),
            weight: 7.7,
            weightUnit: WeightUnits.metric.dataValue,
            notes: null,
          );

          // Act
          final result = PetWeightMapper.mapToModel(petWeight);

          // Assert
          expect(result.notes, match.isNull);
        },
      );

      test(
        'mapToModel should map unknown weightUnit to WeightUnits.unknown',
        () {
          // Arrange
          final petWeight = PetWeight(
            petWeightId: 5,
            pet: 6,
            date: DateTime(2021, 3, 3),
            weight: 8.8,
            weightUnit: 999, // invalid value
            notes: 'Unknown',
          );

          // Act & Assert
          expect(
            () => PetWeightMapper.mapToModel(petWeight),
            throwsA(match.isA<Exception>()),
          );
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
              weight: 12.5,
              weightUnit: WeightUnits.imperial.dataValue,
              notes: 'Healthy',
            ),
            PetWeight(
              petWeightId: 3,
              pet: 4,
              date: DateTime(2022, 2, 2),
              weight: 7.7,
              weightUnit: WeightUnits.metric.dataValue,
              notes: null,
            ),
          ];

          // Act
          final result = PetWeightMapper.mapToModelList(petWeights);

          // Assert
          expect(result.length, 2);
          expect(result[0].petWeightId, 1);
          expect(result[1].petWeightId, 3);
          expect(result[0].weightUnit, WeightUnits.imperial);
          expect(result[1].weightUnit, WeightUnits.metric);
        },
      );
    });
  });
}
