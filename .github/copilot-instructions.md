### General

Rules:
-Use the Dart programming language.
-Use the Flutter framework.
-Use the latest stable version of Dart and Flutter.
-For any changes you make, summarize in the /changelog.md file.
-Use Riverpod for state management.
-Use Drift for local database storage.

### UI

Rules:
-Make any UI you generate beautiful and user-friendly.

### Context 7

Rules:
-Always use the Context7 MCP server to reference documentation for libraries like Flutter, Riverpod, Drift, and Mockito.
-For the tokens, start with 5000 but increase them to 20000 if you need to.
-Only search three times maximum for any specific piece of documentation.

### Tests

Rules:
-Write unit tests for any code you generate.
-Write integration tests for any code you generate.
-If mocks are required, use the mockito library.
-Tests should be generated in the /test directory.
-Use the test directory structure to mirror the lib directory structure.
-Rather than mocking the provider we mock the database service the provider gets its data from, as advised in the Riverpod documentation https://riverpod.dev/docs/essentials/testing#mocking-notifiers
-If using any matchers from the matcher.dart library (for example isNull, isNotNull), use the match prefix to avoid ambiguous_import errors. For example, use match.isNull instead of isNull.
-When writing tests to get, list or delete a record, write additional tests to check that the records not found are handled correctly.
-When writing tests to check that a record is created, updated or deleted, test all the fields of a record that have been updated or set in the test contain the expected values.
-Use "[method name] should [expected behaviour] when [condition]" for the test description.
-Use the test name to describe the test case. For example, "GetUserById Should return User When user exists" instead of "testGetUserById".  
-Use the AAA pattern for test cases. Arrange, Act, Assert. Use comments to separate the sections of the test.
