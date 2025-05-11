# post_viewer

A new Flutter project post viewer.

This project is a starting point for a Flutter application that fetches and displays a list of articles from a public API.

## Features
- List of articles
- Search functionality to search articles
- Favorites icon to view list of favorite posts
- Detail view of posts
- Responsive UI
- Font Family used 'Lato'
- Images for error and app icon

## ArchitecturalSetup
- Followed SOLID principles for project and accordingly folder structure is maintained
- Applied Clean Code practices
- Created common textStyles and color class in app_theme.dart

## State Management Explanation
Used Bloc Cubit for simple and efficient state management in the app. 
It allows us to emit states directly using methods like emit(...) without writing boilerplate-heavy event classes. 
This approach keeps the business logic and UI cleanly separated while maintaining reactive UI updates.


## Setup Instructions
1. Clone the repo:
   git clone https://github.com/neha09panchal/post_viewer.git
   
2. Install dependencies:
   flutter pub get

3. Run the app:
   flutter run


## Tech Stack
- Flutter SDK: 3.29.2
- State Management: Bloc Cubit
- HTTP Client: Dio
- Persistence: Hive

