# CountDownTimer: A Two-Player Game Timer App

CountDownTimer is a modern iOS application built with SwiftUI, providing a seamless experience for managing time in turn-based games across iOS devices.

## Features

- **Dual Timer System**: Manage two separate timers for two players in a turn-based game.
- **Turn Management**: Easily switch between players with visual indicators of whose turn it is.
- **Game Controls**: Start, pause, resume, and reset game timers with intuitive controls.
- **Customizable Game Length**: Configure the game duration in minutes through the settings.
- **Visually Appealing UI**: Modern and intuitive user interface designed with SwiftUI.

## Technologies Used

### iOS:
- **SwiftUI**: Declarative UI framework for building native iOS interfaces.
- **Observable Pattern**: Modern state management using the @Observable macro.
- **Swift Concurrency**: Modern approach to handling asynchronous operations.

## Architecture

The app follows a clean architecture pattern, ensuring a clear separation of concerns and maintainability.

- **Model**: Represents the game state and timer logic (`Game` and `TimerObject` classes).
- **View**: Displays the UI and handles user interactions (`ContentView` and `TimerView`).
- **State Management**: Uses SwiftUI's state management system for reactive UI updates.

## Key Components

### TimerObject
- Manages individual player timers
- Handles timer operations (start, stop, reset)
- Calculates remaining time and progress

### Game
- Coordinates the overall game state
- Manages player turns
- Handles game operations (start, pause, resume, reset)

### TimerView
- Provides the user interface for the game
- Displays player timers with visual emphasis on the active player
- Offers control buttons for game management

## Benefits

- **Intuitive Design**: Simple and clear interface for managing game time.
- **Responsive UI**: Real-time updates as timers count down.
- **Flexible Configuration**: Adjustable game length to suit different game types.
- **Visual Feedback**: Clear indication of whose turn it is and how much time remains.

## Possible Enhancements

- **Sound Effects**: Add audio cues for timer events and turn changes.
- **Custom Timer Presets**: Save and load different timer configurations.
- **Player Names**: Allow customization of player names.
- **Game History**: Track and display previous game results.
- **Additional Game Modes**: Support for more than two players or different timing rules.
- **iCloud Sync**: Synchronize game settings across devices.
- **Widgets**: Add home screen widgets for quick timer access.

## Getting Started

1. Clone the repository: `git clone [repository URL]`
2. Open the project in Xcode.
3. Build and run the app on your iOS device or simulator.

## Contributions

Contributions are welcome! Feel free to submit pull requests or open issues for bug reports and feature suggestions. 