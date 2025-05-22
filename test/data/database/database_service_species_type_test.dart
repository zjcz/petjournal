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
  });

  tearDown(() => database.close());

  group('SpeciesType CRUD Operations', () {
    test(
      'createSpeciesType should create new record when valid data provided',
      () async {
        const testName = 'Dog';
        const testUserAdded = true;

        final speciesType = await database.createSpeciesType(
          name: testName,
          userAdded: testUserAdded,
        );

        expect(speciesType, match.isNotNull);
        expect(speciesType?.speciesId, match.isNonZero);
        expect(speciesType?.name, equals(testName));
        expect(speciesType?.userAdded, equals(testUserAdded));
      },
    );

    test(
      'createSpeciesType should throw when name exceeds max length',
      () async {
        final longName = 'A' * 101; // Max length is 100

        expect(
          () => database.createSpeciesType(
            name: longName,
            userAdded: true,
          ),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'createSpeciesType should enforce case-sensitive unique names',
      () async {
        // Create first species type
        await database.createSpeciesType(
          name: 'Dog',
          userAdded: true,
        );

        // Should allow different case
        final differentCase = await database.createSpeciesType(
          name: 'DOG',
          userAdded: true,
        );
        expect(differentCase, match.isNotNull);
        expect(differentCase?.name, equals('DOG'));
      },
    );

    test('getSpeciesType should return species type when exists', () async {
      // Create a species type
      final created = await database.createSpeciesType(
        name: 'Dog',
        userAdded: true,
      );
      expect(created, match.isNotNull);

      // Retrieve the species type
      final retrieved = await database.getSpeciesType(created!.speciesId);

      expect(retrieved, match.isNotNull);
      expect(retrieved?.speciesId, equals(created.speciesId));
      expect(retrieved?.name, equals('Dog'));
      expect(retrieved?.userAdded, equals(true));
    });

    test(
      'getSpeciesType should return null when species type does not exist',
      () async {
        final speciesType = await database.getSpeciesType(999);
        expect(speciesType, match.isNull);
      },
    );

    test(
      'getAllSpeciesTypes should return correctly ordered list of species types',
      () async {
        // Create multiple species types
        await database.createSpeciesType(
          name: 'Dog',
          userAdded: true,
        );

        await database.createSpeciesType(
          name: 'Cat',
          userAdded: true,
        );

        await database.createSpeciesType(
          name: 'Bird',
          userAdded: true,
        );

        // Get all species types and verify
        final speciesTypes = await database.getAllSpeciesTypes().first;
        expect(speciesTypes.length, equals(3));
        expect(
          speciesTypes.map((s) => s.name).toList(),
          equals(['Bird', 'Cat', 'Dog']), // Should be alphabetically ordered
        );
      },
    );

    test(
      'getAllSpeciesTypes should return empty list when no species exist',
      () async {
        final speciesTypes = await database.getAllSpeciesTypes().first;
        expect(speciesTypes, isEmpty);
      },
    );

    test('getAllSpeciesTypes should handle large number of species', () async {
      // Create 100 species types
      for (var i = 1; i <= 100; i++) {
        await database.createSpeciesType(
          name: 'Species $i',
          userAdded: true,
        );
      }

      final speciesTypes = await database.getAllSpeciesTypes().first;
      expect(speciesTypes.length, equals(100));
      expect(
        speciesTypes.map((s) => s.name),
        everyElement(matches(RegExp(r'^Species \d+$'))),
      );
    });

    test('updateSpeciesType should update all fields correctly', () async {
      // Create initial species type
      final speciesType = await database.createSpeciesType(
        name: 'Dog',
        userAdded: true,
      );
      expect(speciesType, match.isNotNull);

      // Update the species type
      final updatedCount = await database.updateSpeciesType(
        id: speciesType!.speciesId,
        name: 'Canine',
        userAdded: false,
      );

      expect(updatedCount, equals(1));

      // Verify the update
      final updated = await database.getSpeciesType(1);
      expect(updated?.name, equals('Canine'));
      expect(updated?.userAdded, equals(false));
    });

    test(
      'updateSpeciesType should return 0 when species type does not exist',
      () async {
        final updateCount = await database.updateSpeciesType(
          id: 999,
          name: 'NonExistent',
          userAdded: true,
        );

        expect(updateCount, equals(0));
      },
    );

    test(
      'updateSpeciesType should throw when name exceeds max length',
      () async {
        // Create initial species type
        final speciesType = await database.createSpeciesType(
          name: 'Dog',
          userAdded: true,
        );
        expect(speciesType, match.isNotNull);

        final longName = 'A' * 101; // Max length is 100

        // Update attempt should throw
        expect(
          () => database.updateSpeciesType(
            id: 1,
            name: longName,
            userAdded: false,
          ),
          throwsA(isA<Exception>()),
        );

        // Verify original data was not changed
        final unchanged = await database.getSpeciesType(1);
        expect(unchanged?.name, equals('Dog'));
      },
    );

    test('updateSpeciesType should enforce unique names', () async {
      // Create two species types
      await database.createSpeciesType(
        name: 'Dog',
        userAdded: true,
      );
      final cat = await database.createSpeciesType(
        name: 'Cat',
        userAdded: true,
      );

      // Attempt to update second species to use first species name
      expect(
        () => database.updateSpeciesType(id: cat!.speciesId, name: 'Dog', userAdded: true),
        throwsA(isA<Exception>()),
      );
    });

    test('deleteSpeciesType should delete existing species type', () async {
      // Create a species type
      final speciesType = await database.createSpeciesType(
        name: 'Dog',
        userAdded: true,
      );
      expect(speciesType, match.isNotNull);

      // Delete the species type
      final deleteCount = await database.deleteSpeciesType(speciesType!.speciesId);
      expect(deleteCount, equals(1));

      // Verify the species type is deleted
      final deleted = await database.getSpeciesType(speciesType.speciesId);
      expect(deleted, match.isNull);
    });

    test(
      'deleteSpeciesType should return 0 when species type does not exist',
      () async {
        final deleteCount = await database.deleteSpeciesType(999);
        expect(deleteCount, equals(0));
      },
    );

    test(
      'deleteSpeciesType should throw when species has associated pets',
      () async {
        // Create a species type
        final speciesType = await database.createSpeciesType(
          name: 'Dog',
          userAdded: true,
        );
        expect(speciesType, match.isNotNull);

        // Create a pet associated with the species type
        await database.createPet(
          'Rex',
          speciesType!.speciesId,
          'German Shepherd',
          'Black',
          PetSex.male,
          null,
          null,
          null,
          null,
          '',
          '',
          '',
          null,
          null,
          PetStatus.active,
        );

        // Attempt to delete the species type should throw an exception
        expect(() => database.deleteSpeciesType(speciesType.speciesId), throwsA(isA<Exception>()));
      },
    );

    test('watchSpeciesType should emit updates', () async {
      // Create a species type
      final speciesType = await database.createSpeciesType(
        name: 'Dog',
        userAdded: true,
      );
      expect(speciesType, match.isNotNull);

      // Start watching the species type
      final stream = database.watchSpeciesType(speciesType!.speciesId);

      // Update the species type
      await database.updateSpeciesType(id: speciesType.speciesId, name: 'Canine', userAdded: false);

      // Verify the stream emits the updated species type
      final updated = await stream.first;
      expect(updated?.name, equals('Canine'));
      expect(updated?.userAdded, equals(false));
    });

    test(
      'watchSpeciesType should emit null after species type is deleted',
      () async {
        // Create a species type
        final speciesType = await database.createSpeciesType(
          name: 'Dog',
          userAdded: true,
        );
        expect(speciesType, match.isNotNull);

        // Start watching the species type
        final stream = database.watchSpeciesType(speciesType!.speciesId);

        // Delete the species type
        await database.deleteSpeciesType(speciesType.speciesId);

        // Verify the stream emits null
        final deleted = await stream.first;
        expect(deleted, match.isNull);
      },
    );
  });
}
