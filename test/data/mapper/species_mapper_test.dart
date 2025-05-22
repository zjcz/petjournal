import 'package:test/test.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/mapper/species_mapper.dart';

void main() {
  group('SpeciesMapper Tests', () {
    test('mapToModel should correctly map all SpeciesType fields to SpeciesModel', () {
      // Arrange
      final speciesType = SpeciesType(
        speciesId: 1,
        name: 'Dog',
        userAdded: false,
      );

      // Act
      final model = SpeciesMapper.mapToModel(speciesType);

      // Assert
      expect(model.speciesId, equals(1));
      expect(model.name, equals('Dog'));
      expect(model.userAdded, equals(false));
    });

    test('mapToModel should correctly map user-added species', () {
      // Arrange
      final speciesType = SpeciesType(
        speciesId: 2,
        name: 'Dragon',
        userAdded: true,
      );

      // Act
      final model = SpeciesMapper.mapToModel(speciesType);

      // Assert
      expect(model.speciesId, equals(2));
      expect(model.name, equals('Dragon'));
      expect(model.userAdded, equals(true));
    });

    test('mapToModelList should correctly map empty list', () {
      // Arrange
      final speciesTypes = <SpeciesType>[];

      // Act
      final models = SpeciesMapper.mapToModelList(speciesTypes);

      // Assert
      expect(models, isEmpty);
    });

    test('mapToModelList should correctly map multiple species', () {
      // Arrange
      final speciesTypes = [
        SpeciesType(
          speciesId: 1,
          name: 'Dog',
          userAdded: false,
        ),
        SpeciesType(
          speciesId: 2,
          name: 'Cat',
          userAdded: false,
        ),
        SpeciesType(
          speciesId: 3,
          name: 'Hamster',
          userAdded: true,
        ),
      ];

      // Act
      final models = SpeciesMapper.mapToModelList(speciesTypes);

      // Assert
      expect(models.length, equals(3));
      
      // Verify first species
      expect(models[0].speciesId, equals(1));
      expect(models[0].name, equals('Dog'));
      expect(models[0].userAdded, equals(false));
      
      // Verify second species
      expect(models[1].speciesId, equals(2));
      expect(models[1].name, equals('Cat'));
      expect(models[1].userAdded, equals(false));
      
      // Verify third species
      expect(models[2].speciesId, equals(3));
      expect(models[2].name, equals('Hamster'));
      expect(models[2].userAdded, equals(true));
    });
  });
}
