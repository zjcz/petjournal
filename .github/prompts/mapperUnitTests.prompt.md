---
mode: 'agent'
tools: ['githubRepo', 'codebase']
description: 'Generating Unit Tests for Data Mappers'
---

# Instructions

You are to generate comprehensive unit tests for the specified data mapper in a Dart/Flutter project. Follow these requirements:

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
- Write tests for all public methods of the mapper, including:
    - Mapping from model to entity and vice versa.
    - Handling of null, empty, and invalid values.
    - Edge cases and error handling.
    - All fields and possible value combinations.
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

# Mapper Under Test

Write comprehensive unit tests for the [mapper name] data mapper.

# Output

Output only the Dart test code for the `/test` directory, mirroring the structure of the `lib` directory. Do not include explanations or extra text.