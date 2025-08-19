#!/bin/bash

# Test Runner Script for Clean Architecture Flutter App
# This script runs all tests and generates coverage reports

echo "🧪 Running Clean Architecture Flutter Tests..."
echo "==============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Change to project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

print_status "Current directory: $PROJECT_DIR"

# Generate code if needed
print_status "Generating code..."
if dart run build_runner build --delete-conflicting-outputs; then
    print_success "Code generation completed"
else
    print_warning "Code generation had warnings or errors"
fi

echo ""

# Run different test categories
print_status "Running Core Tests..."
if flutter test test/core/; then
    print_success "Core tests passed"
else
    print_error "Core tests failed"
    exit 1
fi

echo ""

print_status "Running Domain Tests..."
if flutter test test/domain/; then
    print_success "Domain tests passed"
else
    print_error "Domain tests failed"
    exit 1
fi

echo ""

print_status "Running Data Layer Tests..."
if flutter test test/data/models/; then
    print_success "Data model tests passed"
else
    print_error "Data model tests failed"
    exit 1
fi

echo ""

print_status "Running Widget Tests..."
if flutter test test/widget_test.dart; then
    print_success "Widget tests passed"
else
    print_error "Widget tests failed"
    exit 1
fi

echo ""

# Run all tests with coverage
print_status "Running all tests with coverage..."
if flutter test --coverage; then
    print_success "All tests passed with coverage"
    
    # Check if genhtml is available for HTML coverage report
    if command -v genhtml &> /dev/null; then
        print_status "Generating HTML coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        print_success "Coverage report generated at coverage/html/index.html"
    else
        print_warning "genhtml not found. Install lcov for HTML coverage reports: 'brew install lcov' (macOS)"
    fi
else
    print_error "Some tests failed"
    exit 1
fi

echo ""
print_success "🎉 All tests completed successfully!"
echo ""

# Display test summary
print_status "Test Summary:"
echo "✅ Core tests: Error handling, failures, use cases"
echo "✅ Domain tests: Entities and business logic"
echo "✅ Data tests: Models, repositories, and data sources"
echo "✅ Widget tests: UI components and app structure"
echo ""

print_status "Coverage report available at: coverage/lcov.info"
if [ -d "coverage/html" ]; then
    print_status "HTML coverage report: coverage/html/index.html"
fi

echo ""
print_status "To run specific test categories:"
echo "  flutter test test/core/      # Core layer tests"
echo "  flutter test test/domain/    # Domain layer tests"
echo "  flutter test test/data/      # Data layer tests"
echo "  flutter test test/presentation/  # Presentation layer tests"
