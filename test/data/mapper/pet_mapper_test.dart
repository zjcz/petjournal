import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;
import 'package:petjournal/data/mapper/pet_mapper.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';

void main() {
  group('PetMapper Tests', () {
    test('mapToModel should correctly map all Pet fields to PetModel', () {
      // Arrange
      final testDate = DateTime(2023, 1, 1);
      final pet = Pet(
        petId: 1,
        name: 'Rex',
        speciesId: 2,
        breed: 'German Shepherd',
        colour: 'Black and Tan',
        sex: PetSex.male.dataValue,
        dob: testDate,
        dobEstimate: true,
        diet: 'Premium Dog Food',
        notes: 'Friendly dog',
        history: 'Rescued',
        isNeutered: true,
        neuterDate: testDate,
        status: PetStatus.active.dataValue,
        statusDate: testDate,
        isMicrochipped: true,
        microchipDate: DateTime(2024, 5, 28),
        microchipNotes: 'Healthy',
        microchipNumber: '123456789',
        microchipCompany: 'PetSafe',
      );

      // Act
      final model = PetMapper.mapToModel(pet);

      // Assert
      expect(model.petId, equals(1));
      expect(model.name, equals('Rex'));
      expect(model.species.speciesId, equals(2));
      expect(model.breed, equals('German Shepherd'));
      expect(model.colour, equals('Black and Tan'));
      expect(model.petSex, equals(PetSex.male));
      expect(model.dob, equals(testDate));
      expect(model.dobEstimate, equals(true));
      expect(model.diet, equals('Premium Dog Food'));
      expect(model.notes, equals('Friendly dog'));
      expect(model.history, equals('Rescued'));
      expect(model.isNeutered, equals(true));
      expect(model.neuterDate, equals(testDate));
      expect(model.status, equals(PetStatus.active));
      expect(model.statusDate, equals(testDate));
      expect(model.isMicrochipped, equals(true));
      expect(model.microchipDate, equals(DateTime(2024, 5, 28)));
      expect(model.microchipNotes, equals('Healthy'));
      expect(model.microchipNumber, equals('123456789'));
      expect(model.microchipCompany, equals('PetSafe'));
    });

    test('mapToModel should handle null optional fields', () {
      // Arrange
      final pet = Pet(
        petId: 1,
        name: 'Rex',
        speciesId: 2,
        breed: 'Mixed',
        colour: 'Brown',
        sex: PetSex.male.dataValue,
        dob: null,
        dobEstimate: false,
        diet: '',
        notes: '',
        history: '',
        isNeutered: false,
        neuterDate: null,
        status: PetStatus.active.dataValue,
        statusDate: DateTime.now(),
        isMicrochipped: null,
        microchipDate: null,
        microchipNotes: null,
        microchipNumber: null,
        microchipCompany: null,
      );

      // Act
      final model = PetMapper.mapToModel(pet);

      // Assert
      expect(model.dob, match.isNull);
      expect(model.dobEstimate, equals(false));
      expect(model.diet, isEmpty);
      expect(model.notes, isEmpty);
      expect(model.history, isEmpty);
      expect(model.isNeutered, equals(false));
      expect(model.neuterDate, match.isNull);
      expect(model.isMicrochipped, match.isFalse);
      expect(model.microchipDate, match.isNull);
      expect(model.microchipNotes, match.isNull);
      expect(model.microchipNumber, match.isNull);
      expect(model.microchipCompany, match.isNull);
    });

    test('mapToModelList should correctly map a list of Pets to PetModels', () {
      // Arrange
      final pets = [
        Pet(
          petId: 1,
          name: 'Rex',
          speciesId: 2,
          breed: 'German Shepherd',
          colour: 'Black',
          sex: PetSex.male.dataValue,
          dob: null,
          dobEstimate: false,
          diet: '',
          notes: '',
          history: '',
          isNeutered: false,
          neuterDate: null,
          status: PetStatus.active.dataValue,
          statusDate: DateTime.now(),
          isMicrochipped: null,
          microchipDate: null,
          microchipNotes: null,
          microchipNumber: null,
          microchipCompany: null,
        ),
        Pet(
          petId: 2,
          name: 'Luna',
          speciesId: 2,
          breed: 'Labrador',
          colour: 'White',
          sex: PetSex.female.dataValue,
          dob: null,
          dobEstimate: false,
          diet: '',
          notes: '',
          history: '',
          isNeutered: false,
          neuterDate: null,
          status: PetStatus.active.dataValue,
          statusDate: DateTime.now(),
          isMicrochipped: true,
          microchipDate: DateTime(2024, 5, 28),
          microchipNotes: 'Healthy',
          microchipNumber: '123456789',
          microchipCompany: 'PetSafe',
        ),
      ];

      // Act
      final models = PetMapper.mapToModelList(pets);

      // Assert
      expect(models.length, equals(2));
      expect(models[0].name, equals('Rex'));
      expect(models[0].breed, equals('German Shepherd'));
      expect(models[0].isMicrochipped, match.isFalse);
      expect(models[1].name, equals('Luna'));
      expect(models[1].breed, equals('Labrador'));
      expect(models[1].isMicrochipped, match.isTrue);
    });

    test('mapToModelList should return empty list for empty input', () {
      // Arrange
      final pets = <Pet>[];

      // Act
      final models = PetMapper.mapToModelList(pets);

      // Assert
      expect(models, isEmpty);
    });
  });
}
