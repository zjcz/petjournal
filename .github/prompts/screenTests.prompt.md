---
mode: 'agent'
tools: ['githubRepo', 'codebase']
description: 'Generating Unit Tests for Screen Components'
---

Write comprehensive unit tests for the [widget name] screen widget. Use the following as a template for the test file. Use a single wrapper method 'createScreen()' to create the screen widget which can then be called by each test:
`
Widget createScreen(MockDatabaseService db) {
return StatefulBuilder(
builder: (BuildContext context, StateSetter setState) {
return ProviderScope(
overrides: [DatabaseService.provider.overrideWithValue(db)],
child: MaterialApp.router(
routerConfig: setupRouter(initialLocation: RouteDefs.welcome),
),
);
},
);
}

@GenerateMocks([DatabaseService])
void main() {

group('WelcomeScreen', () {
testWidgets('renders welcome text', (WidgetTester tester) async {
await tester.pumpWidget(
createScreen(
MockDatabaseService(),
),
);

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('to PetJournal'), findsOneWidget);
    });

});
}
`

Do not mock the Riverpod provider, instead mock the database service the provider gets its data from, as advised in the Riverpod documentation https://riverpod.dev/docs/essentials/testing#mocking-notifiers

Adhering to these requirements:

1. Test Coverage:

   - Core functionality and business logic
   - User interaction flows
   - Edge cases and error states
   - Component lifecycle methods

2. Test Scenarios:

   - Initial state validation
   - User input handling
   - State updates and transitions
   - API integration points
   - Error handling and recovery
   - Navigation flows
   - Data persistence

3. Technical Requirements:

   - Use appropriate testing framework
   - Use Mockito for mocking dependencies
   - Follow AAA pattern (Arrange-Act-Assert)
   - Implement test doubles (mocks/stubs) for dependencies
   - Maintain test isolation
   - Clear test naming convention
   - Setup and teardown procedures

4. Documentation:
   - Purpose of each test case
   - Test coverage metrics
   - Dependencies and mock setup
   - Known limitations or exclusions
