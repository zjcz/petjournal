import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:petjournal/app/pet/views/edit_pet_screen.dart';
import 'package:petjournal/data/database/database_service.dart';

import 'edit_pet_screen_test.mocks.dart';

@GenerateMocks([DatabaseService])
Widget createScreen(MockDatabaseService db) {
  return ProviderScope(
    overrides: [DatabaseService.provider.overrideWithValue(db)],
    child: const MaterialApp(home: EditPetScreen()),
  );
}

void main() {
  late MockDatabaseService mockDb;

  setUp(() {
    mockDb = MockDatabaseService();
  });

  group('EditPetScreen', () {
    // Setup placeholder tests for now... screen functionality to be added later
    test('placeholder test', () {});
  });
}
