# Comments App

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Firebase Configuration](#firebase-configuration)
- [Dependencies](#dependencies)

## Introduction
The **Comments App** is a Flutter application designed to fetch and display comments from an API. The app integrates Firebase for authentication and Firestore for storing user details. It also leverages Firebase Remote Config to manage feature flags, such as masking email addresses.
- Video demonstration of the app: [Click Here](https://drive.google.com/file/d/1s3Rz5WE_-uNSVoG_zjVlbZBHT19YwSyd/view?usp=sharing)

## Features
- **User Authentication:** Sign up and login functionality using Firebase Authentication.
- **Comments Fetching:** Fetch comments from an API and display them in a list.
- **Theming:** Toggle between light and dark themes.
- **Email Masking:** Optionally mask email addresses using Firebase Remote Config.
- **State Management:** Manage app state using the Provider package.

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase Account](https://firebase.google.com/)
- A code editor (e.g., Visual Studio Code, Android Studio)

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/comments-app.git
    cd comments-app
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Set up Firebase:**
    - Create a Firebase project and configure it for your app.
    - Add `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) to your Flutter project.
    - Or add FlutterFire or Firebase CLI for Flutter configuration.

4. **Run the app:**
    ```bash
    flutter run
    ```

## Project Structure

```plaintext
lib/
├── main.dart
├── models/
│   └── comment.dart
├── services/
│   ├── api_services.dart
│   └── firebase_services.dart
├── utils.dart
├── view_models/
│   ├── auth_view_model.dart
│   └── comment_view_model.dart
└── views/
    ├── home_view.dart
    ├── login_view.dart
    └── signup_view.dart
```

## Usage

1. **Login or Sign Up:**
    - On launching the app, you'll be presented with a login screen.
    - If you don't have an account, click on the "Signup" button to create a new account.

2. **Fetch Comments:**
    - After logging in, you'll be navigated to the home screen where the app fetches and displays comments from the API.
    - Comments include the commenter's name, masked email (if enabled via Firebase Remote Config), and the comment body.

3. **Toggle Theme:**
    - Use the theme toggle button in the app bar to switch between light and dark themes.

## Firebase Configuration

### Authentication

1. Enable Email/Password authentication in the Firebase console.

### Firestore

1. Create a `users` collection to store user details (name and email).

### Remote Config

1. Add a parameter `mask_email` with a default value of `false`.

## Dependencies

- **firebase_core:** For initializing Firebase.
- **firebase_auth:** For Firebase Authentication.
- **cloud_firestore:** For Firestore database.
- **firebase_remote_config:** For Firebase Remote Config.
- **provider:** For state management.
- **http:** For making HTTP requests.
- **google_fonts:** For using Google Fonts.
- **shared_preferences:** For persisting theme preferences.
