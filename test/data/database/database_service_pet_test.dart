import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;

void main() {
  late DatabaseService database;

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    database = DatabaseService(inMemory);
    // Create a species type that will be used by all tests
    await database
        .into(database.speciesTypes)
        .insert(SpeciesTypesCompanion.insert(name: 'Dog'));
  });

  tearDown(() => database.close());

  group('Pet CRUD Operations', () {
    test('create a new pet object', () async {
      const testName = 'Rex';
      const testBreed = 'German Shepherd';
      const testColour = 'Black and Tan';
      const testSex = PetSex.male;
      const testDiet = 'Test food';
      const testNotes = 'Test notes';
      const testHistory = 'Test history';
      final testDob = DateTime(2020, 1, 1);
      const dobEstimate = false;
      const testIsNeutered = true;
      final testNeuterDate = DateTime(2021, 1, 1);
      final testIsMicrochipped = true;
      final testMicrochipDate = DateTime(2021, 1, 1);
      final testMicrochipNumber = '12345';
      final testMicrochipNotes = 'Test notes';
      final testMicrochipCompany = 'Test company';
      final testImageUrl = 'https://example.com/image.jpg';

      final pet = await database.createPet(
        testName,
        1,
        testBreed,
        testColour,
        testSex,
        testDob,
        dobEstimate,
        testDiet,
        testNotes,
        testHistory,
        testIsNeutered,
        testNeuterDate,
        PetStatus.active,
        testIsMicrochipped,
        testMicrochipDate,
        testMicrochipNumber,
        testMicrochipCompany,
        testMicrochipNotes,
        testImageUrl,
      );

      expect(pet, match.isNotNull);
      expect(pet?.name, equals(testName));
      expect(pet?.breed, equals(testBreed));
      expect(pet?.colour, equals(testColour));
      expect(pet?.sex, equals(testSex.dataValue));
      expect(pet?.dob, equals(testDob));
      expect(pet?.dobEstimate, equals(dobEstimate));
      expect(pet?.diet, equals(testDiet));
      expect(pet?.notes, equals(testNotes));
      expect(pet?.history, equals(testHistory));
      expect(pet?.isNeutered, equals(testIsNeutered));
      expect(pet?.neuterDate, equals(testNeuterDate));
      expect(pet?.status, equals(PetStatus.active.dataValue));
      expect(pet?.statusDate, match.isNotNull);
      expect(pet?.isMicrochipped, equals(testIsMicrochipped));
      expect(pet?.microchipDate, equals(testMicrochipDate));
      expect(pet?.microchipNumber, equals(testMicrochipNumber));
      expect(pet?.microchipCompany, equals(testMicrochipCompany));
      expect(pet?.microchipNotes, equals(testMicrochipNotes));
      expect(pet?.imageUrl, equals(testImageUrl));
    });

    test('create pet with minimal required fields', () async {
      final pet = await database.createPet(
        'Rex',
        1,
        'Mixed',
        'Brown',
        PetSex.male,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(pet, match.isNotNull);
      expect(pet?.name, equals('Rex'));
      expect(pet?.breed, equals('Mixed'));
      expect(pet?.colour, equals('Brown'));
      expect(pet?.sex, equals(PetSex.male.dataValue));
      expect(pet?.dob, match.isNull);
      expect(pet?.dobEstimate, equals(false));
      expect(pet?.diet, isEmpty);
      expect(pet?.notes, isEmpty);
      expect(pet?.history, isEmpty);
      expect(pet?.isNeutered, equals(false));
      expect(pet?.neuterDate, match.isNull);
      expect(pet?.status, equals(PetStatus.active.dataValue));
      expect(pet?.statusDate, match.isNotNull);
      expect(pet?.isMicrochipped, equals(false));
      expect(pet?.microchipDate, match.isNull);
      expect(pet?.microchipNumber, match.isNull);
      expect(pet?.microchipCompany, match.isNull);
      expect(pet?.microchipNotes, match.isNull);
      expect(pet?.imageUrl, match.isNull);
    });

    test('get pet by id returns correct pet', () async {
      // First create a pet
      final createdPet = await database.createPet(
        'Luna',
        1,
        'Mixed',
        'White',
        PetSex.female,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(createdPet, match.isNotNull);
      final petId = createdPet!.petId;

      // Then retrieve it
      final retrievedPet = await database.getPet(petId);

      expect(retrievedPet, match.isNotNull);
      expect(retrievedPet?.petId, equals(petId));
      expect(retrievedPet?.name, equals('Luna'));
      expect(retrievedPet?.breed, equals('Mixed'));
    });

    test('get non-existent pet returns null', () async {
      final pet = await database.getPet(999);
      expect(pet, match.isNull);
    });

    test('get all pets returns correct list', () async {
      // Create multiple pets
      await database.createPet(
        'Luna',
        1,
        'Mixed',
        'White',
        PetSex.female,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      await database.createPet(
        'Max',
        1,
        'Mixed',
        'Black',
        PetSex.male,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      // Get all pets and verify
      final pets = await database.getAllPets().first;
      expect(pets.length, equals(2));
      expect(pets.map((p) => p.name).toList()..sort(), equals(['Luna', 'Max']));
    });

    test('update pet updates all fields correctly', () async {
      // First create a pet
      final pet = await database.createPet(
        'Luna',
        1,
        'Mixed',
        'White',
        PetSex.female,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(pet, match.isNotNull);
      final petId = pet!.petId;

      final updateDate = DateTime.now();
      final dob = DateTime(2020, 1, 1);
      final neuterDate = DateTime(2021, 1, 1);
      final microchipDate = DateTime(2025, 2, 2);

      // Update the pet
      final updatedCount = await database.updatePet(
        petId,
        'Luna Updated',
        1,
        'Poodle',
        'Brown',
        PetSex.female,
        dob,
        true,
        'New Diet',
        'New Notes',
        'New History',
        true,
        neuterDate,
        PetStatus.deceased,
        updateDate,
        true,
        microchipDate,
        '12345',
        'New Microchip Company',
        'New Microchip Notes',
        'https://example.com/image.jpg',
      );

      expect(updatedCount, equals(1));

      // Verify the update
      final updatedPet = await database.getPet(petId);
      expect(updatedPet?.name, equals('Luna Updated'));
      expect(updatedPet?.breed, equals('Poodle'));
      expect(updatedPet?.colour, equals('Brown'));
      expect(updatedPet?.dob, equals(dob));
      expect(updatedPet?.dobEstimate, equals(true));
      expect(updatedPet?.diet, equals('New Diet'));
      expect(updatedPet?.notes, equals('New Notes'));
      expect(updatedPet?.history, equals('New History'));
      expect(updatedPet?.isNeutered, equals(true));
      expect(updatedPet?.neuterDate, equals(neuterDate));
      expect(updatedPet?.status, equals(PetStatus.deceased.dataValue));
      expect(updatedPet?.statusDate, equals(updateDate));
      expect(updatedPet?.isMicrochipped, equals(true));
      expect(updatedPet?.microchipDate, equals(microchipDate));
      expect(updatedPet?.microchipNumber, equals('12345'));
      expect(updatedPet?.microchipCompany, equals('New Microchip Company'));
      expect(updatedPet?.microchipNotes, equals('New Microchip Notes'));
      expect(updatedPet?.imageUrl, equals('https://example.com/image.jpg'));
    });

    test('update non-existent pet returns zero', () async {
      final updateDate = DateTime.now();
      final updateCount = await database.updatePet(
        999,
        'NonExistent',
        1,
        'Mixed',
        'Brown',
        PetSex.male,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        updateDate,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(updateCount, equals(0));
    });

    test('delete existing pet returns 1', () async {
      // First create a pet
      final pet = await database.createPet(
        'ToDelete',
        1,
        'Mixed',
        'White',
        PetSex.female,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(pet, match.isNotNull);
      final petId = pet!.petId;

      // Delete the pet
      final deleteCount = await database.deletePet(petId);
      expect(deleteCount, equals(1));

      // Verify the pet is deleted
      final deletedPet = await database.getPet(petId);
      expect(deletedPet, match.isNull);
    });

    test('delete non-existent pet returns 0', () async {
      final deleteCount = await database.deletePet(999);
      expect(deleteCount, equals(0));
    });

    test('watch pet emits updates', () async {
      // Create a pet
      final pet = await database.createPet(
        'Luna',
        1,
        'Mixed',
        'White',
        PetSex.female,
        null,
        null,
        '',
        '',
        '',
        null,
        null,
        PetStatus.active,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(pet, match.isNotNull);
      final petId = pet!.petId;

      // Start watching the pet
      final stream = database.watchPet(petId);

      // Update the pet
      final updateDate = DateTime.now();
      await database.updatePet(
        petId,
        'Luna Updated',
        1,
        'Poodle',
        'Brown',
        PetSex.female,
        null,
        null,
        'New Diet',
        'New Notes',
        'New History',
        true,
        null,
        PetStatus.deceased,
        updateDate,
        true,
        null,
        '12345',
        'New Microchip Company',
        'New Microchip Notes',
        'https://example.com/image.jpg',
      );

      // Verify the stream emits the updated pet
      final updatedPet = await stream.first;
      expect(updatedPet?.name, equals('Luna Updated'));
      expect(updatedPet?.breed, equals('Poodle'));
      expect(updatedPet?.microchipNumber, equals('12345'));
      expect(updatedPet?.imageUrl, equals('https://example.com/image.jpg'));
    });
  });
}
