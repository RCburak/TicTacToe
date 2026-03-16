# TicTacToe

A modern Flutter-based Tic Tac Toe game with cross-platform support.

## Overview

This is a fully functional Tic Tac Toe game built with Flutter, offering a complete gaming experience across multiple platforms including Android, iOS, Windows, macOS, Linux, and Web.

## Features

- 🎮 **Classic Tic Tac Toe Gameplay** - Play against AI or another player
- 📱 **Cross-Platform** - Works on Android, iOS, Windows, macOS, Linux, and Web
- 🎯 **Responsive UI** - Beautiful and intuitive user interface
- ⚡ **Fast Performance** - Built with Flutter for optimal performance
- 🔧 **Firebase Integration** - Cloud support for enhanced features

## Project Structure

```
TicTacToe/
├── lib/                    # Main Flutter application code
├── android/               # Android-specific code
├── ios/                   # iOS-specific code
├── windows/              # Windows-specific code
├── macos/                # macOS-specific code
├── linux/                # Linux-specific code
├── web/                  # Web-specific code
├── assets/               # Game assets and resources
├── pubspec.yaml          # Project dependencies
└── firebase.json         # Firebase configuration
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version as specified in pubspec.yaml)
- Dart SDK (comes with Flutter)
- Android Studio / Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/RCburak/TicTacToe.git
   cd TicTacToe
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Platform-Specific Setup

### Android
- Requires Android SDK 21 or higher
- Build using: `flutter build apk` or `flutter build appbundle`

### iOS
- Requires iOS 12.0 or higher
- Run: `open ios/Runner.xcworkspace` (use workspace, not project)
- Build using: `flutter build ios`

### Web
- Build using: `flutter build web`
- Deploy to any web hosting service

### Windows / macOS / Linux
- Follow Flutter's official documentation for desktop development
- Build using: `flutter build <windows|macos|linux>`

## Development

### Project Configuration

The project includes analysis options configured in `analysis_options.yaml` for code quality and consistency.

### Firebase Integration

Firebase configuration is set up via `firebase.json`. To use Firebase features:

1. Set up a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Configure your Firebase credentials
3. Enable required services (Authentication, Firestore, etc.)

## How to Play

1. Launch the application
2. Choose your game mode (vs AI or two-player)
3. Players take turns marking spaces on a 3x3 grid
4. First player to get three marks in a row (horizontally, vertically, or diagonally) wins
5. If all spaces are filled without a winner, the game is a draw

## Dependencies

For a complete list of dependencies, see `pubspec.yaml` and `pubspec.lock`.

## Code Quality

This project follows Flutter best practices and includes analysis options for maintaining code quality. Run analysis with:

```bash
flutter analyze
```

## Building for Release

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Troubleshooting

### Common Issues

- **Build issues**: Run `flutter clean` and `flutter pub get`
- **iOS build fails**: Make sure Xcode Command Line Tools are installed
- **Web deployment**: Ensure all assets are properly referenced with `--web-renderer canvaskit`

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License - see LICENSE file for details.

## Author

Created by [RCburak](https://github.com/RCburak)

---

**Last Updated**: 2026-03-16