# TaskFlow - Voice-Driven To-Do List App

A Flutter-based voice-driven to-do list application that allows users to manage their tasks entirely through voice commands.

## Features

- Voice-driven task management
- Offline voice capture and queuing
- Real-time task synchronization
- Voice feedback for task operations
- Clean, modern UI with Material Design 3
- Local data persistence using Hive

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Generate Hive adapters:
   ```bash
   flutter pub run build_runner build
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Voice Commands

- "Add task [task description]" - Add a new task
- "Complete task [task number]" - Mark a task as complete
- "Delete task [task number]" - Delete a task

## Project Structure

```
lib/
  ├── models/         # Data models
  ├── providers/      # State management
  ├── screens/        # UI screens
  ├── services/       # Business logic
  └── main.dart       # App entry point
```

## Dependencies

- flutter_riverpod: State management
- hive: Local storage
- speech_to_text: Voice recognition
- flutter_tts: Text-to-speech

## License

This project is licensed under the MIT License.
