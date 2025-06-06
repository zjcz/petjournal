---
mode: "agent"
tools: ["githubRepo", "codebase"]
description: "Riverpod Controller Unit Testing Guidelines"
---

# Unit Testing Guidelines for Riverpod Controllers

- Use the Dart programming language.
- Use the latest stable version of Dart and Flutter.
- Follow Effective Dart rules for naming, structure, and documentation.
- Use Riverpod for state management if relevant.
- Use Drift for local database storage if relevant.
- Place all tests in the `/test` directory, mirroring the structure of the `lib` directory.
- Use the AAA (Arrange, Act, Assert) pattern for all test cases, with comments separating each section.
- Use verbose class names that clearly state the test case.
- For any mocks required, use the mockito library and generate mocks as per best practices.
- If using matchers from `matcher.dart`, use the `match` prefix (e.g., `match.isNull`).
- For each test, use the description format: `[method name] should [expected behaviour] when [condition]`.
- Use `test` names that describe the test case, e.g., `"MapUserToEntity should return correct Entity when User is valid"`.
- Write unit tests for business logic only; do not include widget or integration tests here.
- Do not mock data models if they can be constructed with stubbed data.
- Prefer real or fake objects over mocks unless interaction verification is required.
- Ensure good test coverage for all code paths.
- Format code using `dart format`.
- Add doc comments for each test group and main test class.
- Do not include any code outside the test file.
- Do not include explanations or comments outside the code.

## Required Dependencies

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

## Test Structure

```dart
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
  group('AllPetsController Tests', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      testWidgets('Should emit empty list When no pets exist', (tester) async {
        // ARRANGE
        when(
          mockDatabaseService.getAllPets(),
        ).thenAnswer((_) => Stream.value([]));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final pets = await container.read(allPetsControllerProvider.future);

        // ASSERT
        expect(pets, isEmpty);
        verify(mockDatabaseService.getAllPets()).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });
  });
}
```

## Test Cases Requirements

1. Test state transitions
2. Test error handling
3. Test loading states
4. Test edge cases (empty data, null values)
5. Test async operations completion

## Mock Configuration

- Mock only external dependencies (DatabaseService)
- Configure precise mock behaviors
- Verify mock interactions
- Use meaningful test data constants

## Documentation

Include link to implementation file and Riverpod testing docs:
https://riverpod.dev/docs/essentials/testing

# Controller Under Test

Write comprehensive unit tests for the [controller name] controller.

# Output

Output only the Dart test code for the `/test` directory, mirroring the structure of the `lib` directory. Do not include explanations or extra text.