# Clean Architecture Flutter App

A Flutter project implementing Clean Architecture principles with Dio HTTP client, header interceptors, device ID functionality, and dependency injection.

## Features

- **Clean Architecture**: Organized into domain, data, and presentation layers
- **Dio HTTP Client**: Configured with interceptors for headers, logging, and error handling
- **Device ID Integration**: Automatic device ID generation and inclusion in request headers
- **Dependency Injection**: Using `injectable` and `get_it` for IoC
- **BLoC Pattern**: State management using Flutter BLoC
- **Error Handling**: Comprehensive error handling with custom failure types

## Network Implementation

### Header Interceptor
- Automatically adds common headers to all requests
- Includes device ID in `X-Device-ID` header
- Supports authentication token (Bearer token)
- Configurable user agent and content type

### Device ID Service
- Generates unique device identifier using `device_info_plus`
- Persists device ID using `shared_preferences`
- Automatically included in all API requests

### Interceptors Included
1. **HeaderInterceptor**: Adds headers and device ID
2. **LoggingInterceptor**: Logs requests/responses for debugging
3. **ErrorInterceptor**: Handles and transforms HTTP errors

### Configuration
Network settings are centralized in `NetworkConfig`:
- Base URL: `https://jsonplaceholder.typicode.com`
- Timeout configurations
- Default headers

## Project Structure

```
lib/
├── core/
│   ├── error/           # Error handling and failure types
│   ├── network/         # Network configuration and interceptors
│   └── usecases/        # Base use case classes
├── data/
│   ├── datasources/     # Remote and local data sources
│   ├── models/          # Data models
│   └── repositories/    # Repository implementations
├── di/                  # Dependency injection setup
├── domain/
│   ├── entities/        # Domain entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Use case implementations
└── presentation/
    ├── bloc/            # BLoC state management
    ├── pages/           # UI pages
    └── widgets/         # Reusable widgets
```

## Usage

The app demonstrates the network functionality through the Posts feature:

1. **View Posts**: The main page loads posts from the API
2. **Refresh**: Use the refresh button or FAB to trigger new network requests
3. **Headers**: Check debug console to see headers including device ID
4. **Error Handling**: Network errors are handled gracefully

### Device ID in Action

Every API request automatically includes:
```
X-Device-ID: [unique-device-identifier]
Content-Type: application/json
Accept: application/json
User-Agent: CleanArchApp/1.0.0
```

## Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate injection files**:
   ```bash
   dart run build_runner build
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Dependencies

- `dio`: HTTP client
- `injectable`: Dependency injection
- `get_it`: Service locator
- `flutter_bloc`: State management
- `device_info_plus`: Device information
- `shared_preferences`: Local storage
- `retrofit`: Type-safe HTTP client
