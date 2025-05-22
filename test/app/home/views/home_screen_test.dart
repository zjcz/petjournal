import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:petjournal/app/home/views/home_screen.dart';
import 'package:petjournal/data/database/database_service.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([DatabaseService])
Widget createScreen(MockDatabaseService db) {
  return ProviderScope(
    overrides: [DatabaseService.provider.overrideWithValue(db)],
    child: const MaterialApp(home: HomeScreen()),
  );
}

void main() {
  late MockDatabaseService mockDb;

  setUp(() {
    mockDb = MockDatabaseService();
  });

  group('HomeScreen', () {
    // Setup placeholder tests for now... screen functionality to be added later
    test('placeholder test', () {});
  });
}
