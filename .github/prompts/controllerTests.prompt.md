---
mode: 'agent'
tools: ['githubRepo', 'codebase']
description: 'Unit Testing Guidelines for Riverpod Controller Components'
---

Write comprehensive unit tests for the specified Riverpod controller (notifier) following these requirements:

1. Test Structure:

   - Use a single test file per controller
   - Implement the provided `createContainer()` utility method
   - Group related tests using `group()` statements
   - Use descriptive test names that explain the scenario being tested

2. Test Setup:

   - Mock only the `DatabaseService` dependencies
   - Use `MockDatabaseService` generated via `@GenerateMocks`
   - Configure mock behavior using `when()` statements
   - Initialize test data with clear, meaningful variable names

3. Test Implementation:

   - Create a test container using `createContainer()` with appropriate overrides
   - Access the controller using `container.read()` or `container.listen()`
   - Verify expected states and behaviors
   - Include error scenarios and edge cases
   - Test state transitions and async operations

4. Test Cleanup:

   - Include the Flutter workaround for FakeTimer errors:
     ```dart
     await tester.pumpWidget(Container());
     await tester.pumpAndSettle();
     ```
   - Verify mock interactions using `verify()`
   - Clean up resources in `tearDown` blocks if needed

5. Documentation:
   - Add comments for complex test scenarios
   - Reference the Riverpod testing documentation
   - Document any custom test utilities or helpers

Required Template Structure:

```dart
@GenerateMocks([DatabaseService])
void main() {
  group('Test [ControllerName]', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    testWidgets('test scenario description', (tester) async {
      // Test implementation
    });
  });
}
```

Reference: https://riverpod.dev/docs/essentials/testing#mocking-notifiers
