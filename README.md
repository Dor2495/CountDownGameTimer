# CountDownTimer: A Two-Player Game Timer App

CountDownTimer is a modern iOS application built with SwiftUI, providing a seamless experience for managing time in turn-based games across iOS devices.

## Features

- **Dual Timer System**: Manage two separate timers for two players in a turn-based game.
- **Turn Management**: Easily switch between players with visual indicators of whose turn it is.
- **Game Controls**: Start, pause, resume, and reset game timers with intuitive controls.
- **Customizable Game Length**: Configure the game duration with precise minute and second settings.
- **Theme Customization**: Personalize the appearance with custom colors for:
  - Player One's timer
  - Player Two's timer
  - Game time display
  - Control buttons
- **Sound Effects**: Audio feedback when switching turns.
- **Feedback System**: Built-in email feedback functionality for user suggestions and bug reports.
- **Visually Appealing UI**: Modern and intuitive user interface with:
  - Dynamic scaling for different screen sizes
  - Dark mode support
  - Smooth animations for turn transitions
  - Visual feedback for active/inactive states

## Technologies Used

### iOS:
- **SwiftUI**: Declarative UI framework for building native iOS interfaces.
- **Observable Pattern**: Modern state management using the @Observable macro.
- **AVFoundation**: For handling sound effects.
- **GeometryReader**: For responsive layouts across different device sizes.

## Architecture

The app follows a clean architecture pattern, ensuring a clear separation of concerns and maintainability.

### Models
- **Game**: Manages game state, player turns, and overall game flow
- **TimerObject**: Handles individual timer logic and time calculations
- **ThemeViewModel**: Manages UI theme settings and color customization

### Views
- **ContentView**: Root view coordinating the overall app structure
- **TimerView**: Main game interface with player timers and controls
- **SettingsView**: Configuration interface for game duration and themes
- **SendEmailView**: User feedback interface

### Components
- **PlayerTimerButton**: Custom button component for player timers
- **ControlButton**: Reusable control buttons with consistent styling

## Key Features Implementation

### Timer System
- Independent timers for each player
- Precise time tracking with one-second resolution
- Automatic turn switching
- Visual indication when time runs out

### Theme Management
- Individual color settings for each UI element
- Real-time color preview
- Persistent theme settings

### Game Controls
- Start/Resume game
- Pause current game
- Reset timers
- Access settings

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Build and run on your iOS device or simulator

## Requirements
- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Future Enhancements

- Custom timer presets
- Player names customization
- Game history tracking
- Multiple game modes
- iCloud settings sync
- Home screen widgets
- Haptic feedback
- Additional sound effects
- Accessibility improvements

## Contributions

Contributions are welcome! Feel free to submit pull requests or open issues for bug reports and feature suggestions.

## Contact

For feedback or suggestions, use the built-in feedback form in the app settings or contact the developer directly. 
