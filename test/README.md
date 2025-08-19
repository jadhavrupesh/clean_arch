# Test Configuration for Clean Architecture Flutter App

This file contains information about the test structure and how to run tests.

## Test Structure

```
test/
├── core/
│   ├── error/
│   │   └── failures_test.dart          # Tests for failure classes
│   └── usecases/
│       └── usecase_test.dart          # Tests for NoParams and base classes
├── data/
│   ├── datasources/
│   │   └── remote/
│   │       └── api_service_test.dart  # Tests for API service
│   ├── models/
│   │   └── post_model_test.dart       # Tests for data models
│   └── repositories/
│       └── post_repository_impl_test.dart # Tests for repository implementation
├── domain/
│   ├── entities/
│   │   └── post_test.dart             # Tests for domain entities
│   └── usecases/
│       └── get_posts_use_case_test.dart # Tests for use cases
├── fixtures/
│   ├── fixture_reader.dart            # Helper for reading test fixtures
│   └── posts_fixture.json             # Mock data for tests
├── presentation/
│   ├── bloc/
│   │   └── post_bloc_test.dart        # Tests for BLoC
│   └── pages/
│       └── posts_page_test.dart       # Widget tests for pages
└── widget_test.dart                   # Main app widget tests
```

## Test Categories

### 1. Unit Tests
- **Core Tests**: Test error handling, failures, and base use case classes
- **Domain Tests**: Test entities and use cases in isolation
- **Data Tests**: Test models, data sources, and repository implementations
- **Presentation Tests**: Test BLoC logic and state management

### 2. Widget Tests
- **Page Tests**: Test individual pages and their widgets
- **Main App Tests**: Test app-level configuration and initialization

### 3. Integration Tests (Future Enhancement)
- **End-to-End Tests**: Test complete user flows
- **API Integration**: Test real API interactions

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test Files
```bash
# Run domain tests
flutter test test/domain/

# Run data layer tests
flutter test test/data/

# Run presentation tests
flutter test test/presentation/

# Run a specific test file
flutter test test/domain/entities/post_test.dart
```

### Generate Code Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Dependencies

The project uses the following testing dependencies:
- `flutter_test`: Core testing framework
- `mockito`: Mocking framework
- `bloc_test`: Testing utilities for BLoC
- `http_mock_adapter`: HTTP mocking for API tests

## Mock Generation

To generate mocks for testing:
```bash
dart run build_runner build
```

This will generate `.mocks.dart` files for classes annotated with `@GenerateMocks`.

## Test Best Practices

1. **AAA Pattern**: Arrange, Act, Assert
2. **Descriptive Test Names**: Use clear, descriptive test names
3. **Single Responsibility**: Each test should test one specific behavior
4. **Mock External Dependencies**: Use mocks for external services and dependencies
5. **Test Edge Cases**: Include tests for error scenarios and edge cases
6. **Maintain Test Data**: Use fixtures for consistent test data

## Test Coverage Goals

- **Unit Tests**: 100% coverage for business logic
- **Widget Tests**: Cover all user interactions and state changes
- **Integration Tests**: Cover critical user journeys

## Debugging Tests

To debug tests in VS Code:
1. Open the test file
2. Set breakpoints
3. Run "Debug Test" from the VS Code command palette
4. Or use `flutter test --debug` from terminal
