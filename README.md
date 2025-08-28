# TVTOR - Flutter Mobile Application

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](https://flutter.dev/docs/deployment)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📱 Project Overview

**TVTOR** is a comprehensive Flutter-based mobile application designed for tutor management and educational services. The application provides a robust platform for connecting tutors with students, managing educational assignments, and facilitating communication between educational stakeholders.

### Key Features

- **Multi-User Authentication System**: Separate interfaces for tutors and tutor managers
- **Tutor Management**: Comprehensive tutor profile management and assignment system
- **Profile Management**: Detailed user profiles with photo upload capabilities
- **Multi-Language Support**: Internationalization support for English and Italian
- **Push Notifications**: Firebase Cloud Messaging integration for real-time updates
- **Offline Support**: HTTP caching for improved user experience
- **Cross-Platform**: Native performance on both Android and iOS platforms

## Architecture & Technology Stack

### Frontend Framework
- **Flutter 3.0+**: Google's UI toolkit for building natively compiled applications
- **Dart 3.0+**: Client-optimized language for fast apps on any platform

### State Management
- **Provider Pattern**: For state management and dependency injection
- **SharedPreferences**: For local data persistence

### Networking & API
- **Dio**: Powerful HTTP client for Dart with interceptors and transformers
- **HTTP Cache**: Offline caching support with `dio_http_cache_lts`
- **RESTful API**: Clean API architecture with centralized configuration

### Backend Services
- **Firebase Core**: Google's mobile development platform
- **Firebase Cloud Messaging**: Push notification service
- **Custom REST API**: Backend services for business logic

### UI/UX Components
- **Material Design**: Google's design language implementation
- **Custom Fonts**: Rajdhani font family integration
- **Responsive Design**: Adaptive layouts for various screen sizes
- **Image Handling**: Photo capture and selection capabilities

### Localization
- **Easy Localization**: Multi-language support framework
- **Supported Languages**: English (en-US) and Italian (it-IT)

## Project Structure

```
tvtorfrontend/
├── android/                 # Android-specific configuration
│   ├── app/                # Android app configuration
│   ├── gradle/            # Gradle wrapper and configuration
│   └── build.gradle       # Android build configuration
├── ios/                   # iOS-specific configuration
│   ├── Flutter/           # Flutter iOS configuration
│   ├── Runner/            # iOS app configuration
│   └── Podfile           # CocoaPods dependencies
├── lib/                   # Main Dart source code
│   ├── models/            # Data models and DTOs
│   │   ├── response/      # API response models
│   │   ├── tutorHistory/  # Tutor history models
│   │   └── requests/      # API request models
│   ├── mvp/               # MVP architecture components
│   ├── rest/              # API and networking layer
│   │   ├── apiConfig.dart # API endpoint configuration
│   │   ├── RestApiClient.dart # REST API client
│   │   └── network_util.dart # Network utility functions
│   ├── utils/             # Utility functions and helpers
│   ├── main.dart          # Application entry point
│   ├── splashscreen.dart  # Splash screen implementation
│   ├── SignIn.dart        # Authentication screen
│   ├── TutorSignUp.dart   # Tutor registration
│   ├── TutorManagerSignUp.dart # Manager registration
│   ├── Tutor_Profile.dart # Tutor profile management
│   ├── Tutor_Manager_Home.dart # Manager dashboard
│   ├── Invite_Tutor.dart  # Tutor invitation system
│   ├── Tutor_Assign.dart  # Tutor assignment management
│   └── commondrawer.dart  # Shared navigation drawer
├── assets/                # Application assets
│   ├── 2.0/              # 2x resolution images
│   ├── 2.0x/             # 2x resolution images (alternative)
│   ├── 3.0/              # 3x resolution images
│   └── 3.0x/             # 3x resolution images (alternative)
├── font/                  # Custom font files
│   ├── Rajdhani-Light.ttf
│   ├── Rajdhani-Medium.ttf
│   ├── Rajdhani-Regular.ttf
│   └── Rajdhani-SemiBold.ttf
├── resources/             # Application resources
│   └── langs/            # Localization files
├── pubspec.yaml          # Flutter dependencies and configuration
└── README.md             # Project documentation
```

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- **Flutter SDK** (version 3.0.0 or higher)
- **Dart SDK** (version 3.0.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development, macOS only)
- **Git** for version control

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd tvtorfrontend
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Platform-Specific Setup**

   **Android:**
   - Ensure Android SDK is properly configured
   - Update `android/app/build.gradle` with your application ID
   - Configure signing keys in `android/app/keystore.jks`

   **iOS:**
   - Install CocoaPods: `sudo gem install cocoapods`
   - Navigate to iOS directory: `cd ios`
   - Install pods: `pod install`
   - Open `Runner.xcworkspace` in Xcode

4. **Firebase Configuration**
   - Download `google-services.json` for Android
   - Download `GoogleService-Info.plist` for iOS
   - Place files in respective platform directories

5. **Run the Application**
   ```bash
   flutter run
   ```

## Configuration

### Environment Variables
The application uses several configuration files for different environments:

- **API Configuration**: `lib/rest/apiConfig.dart`
- **Network Configuration**: `lib/rest/network_util.dart`
- **Localization**: `resources/langs/`

### API Endpoints
The application communicates with the following API endpoints:
- Authentication: `/login`, `/register`
- Tutor Management: `/tutors`, `/assigntutor`
- User Management: `/user`
- Subject Management: `/subject`
- Notifications: `/notification`
- Comments: `/comments`

### Localization Setup
The application supports multiple languages through the `easy_localization` package:
- **English (en-US)**: Default language
- **Italian (it-IT)**: Secondary language
- Language files are stored in `resources/langs/`

## 📱 Features & Screens

### Authentication & Registration
- **Sign In**: User authentication for tutors and managers
- **Tutor Sign Up**: Complete tutor registration process
- **Manager Sign Up**: Tutor manager registration
- **Forgot Password**: Password recovery functionality

### User Management
- **Profile Management**: User profile creation and editing
- **Photo Upload**: Profile picture management
- **Password Management**: Secure password change functionality

### Tutor Management
- **Tutor Dashboard**: Comprehensive tutor overview
- **Tutor Assignment**: Assign tutors to specific tasks
- **Tutor History**: Track tutor performance and history
- **Tutor Invitation**: Invite new tutors to the platform

### Manager Features
- **Manager Dashboard**: Overview of all managed tutors
- **Tutor Overview**: Detailed tutor information and statistics
- **Assignment Management**: Manage tutor assignments and schedules

## Development Guidelines

### Code Style
- Follow Dart/Flutter best practices
- Use meaningful variable and function names
- Implement proper error handling
- Add comprehensive comments for complex logic

### Architecture Patterns
- **MVP (Model-View-Presenter)**: For complex screens
- **Repository Pattern**: For data access layer
- **Service Layer**: For business logic implementation

### State Management
- Use Provider pattern for state management
- Implement proper state persistence
- Handle loading and error states appropriately

### Testing
- Write unit tests for business logic
- Implement widget tests for UI components
- Use integration tests for critical user flows

## Dependencies

### Core Dependencies
```yaml
flutter: ^3.0.0
dio: ^5.9.0                    # HTTP client
shared_preferences: ^2.5.3      # Local storage
firebase_core: ^4.0.0          # Firebase services
firebase_messaging: ^16.0.0     # Push notifications
```

### UI Dependencies
```yaml
flutter_staggered_grid_view: ^0.7.0  # Grid layouts
dotted_border: ^3.1.0               # Custom borders
image_picker: ^1.1.2                # Image selection
```

### Utility Dependencies
```yaml
intl: ^0.20.2                      # Internationalization
path: ^1.9.1                        # Path manipulation
fluttertoast: ^8.2.12              # Toast notifications
share_plus: ^11.1.0                # Content sharing
```

## Security Considerations

### Data Protection
- Implement secure authentication mechanisms
- Use HTTPS for all API communications
- Implement proper input validation
- Secure local storage for sensitive data

### API Security
- Implement token-based authentication
- Use secure API endpoints
- Implement rate limiting
- Validate all API responses

## Performance Optimization

### Image Optimization
- Use appropriate image resolutions for different devices
- Implement image caching strategies
- Optimize image file sizes

### Network Optimization
- Implement HTTP caching for offline support
- Use efficient API calls
- Implement proper error handling and retry mechanisms

### Memory Management
- Dispose of controllers properly
- Implement efficient list views
- Use appropriate widget lifecycle management

## Deployment

### Android Deployment
1. **Build Configuration**
   ```bash
   flutter build apk --release
   ```

2. **Signing Configuration**
   - Configure signing keys in `android/app/build.gradle`
   - Use the provided `keystore.jks` file

3. **Google Play Store**
   - Generate signed APK
   - Upload to Google Play Console
   - Configure store listing and metadata

### iOS Deployment
1. **Build Configuration**
   ```bash
   flutter build ios --release
   ```

2. **App Store Configuration**
   - Configure signing in Xcode
   - Set up App Store Connect
   - Submit for review

## Troubleshooting

### Common Issues

1. **Dependency Conflicts**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Platform-Specific Issues**
   - Android: Check SDK configuration
   - iOS: Verify CocoaPods installation

3. **Firebase Issues**
   - Verify configuration files
   - Check Firebase console settings
   - Ensure proper initialization

### Debug Mode
```bash
flutter run --debug
```

### Profile Mode
```bash
flutter run --profile
```

## Contributing

We welcome contributions to improve the TVTOR application. Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit your changes**: `git commit -m 'Add amazing feature'`
4. **Push to the branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Contribution Guidelines
- Follow the existing code style
- Add tests for new functionality
- Update documentation as needed
- Ensure all tests pass before submitting