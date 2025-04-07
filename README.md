# Swift Do - Flutter To-Do List App  

![Swift Do Logo](https://via.placeholder.com/150x150.png?text=Swift+Do) <!-- Replace with your actual logo -->  

A modern To-Do List application built with Flutter and Firebase Firestore that helps you manage your tasks efficiently.  

## ✨ Features  

- **📝 Task Management**  
  - View all tasks with title, description, due date, and completion status  
  - Add new tasks to your list  
  - Edit existing tasks (title, description, due date)  
  - Delete tasks you no longer need  
  - Mark tasks as completed/pending  

- **🔥 Firebase Integration**  
  - Real-time sync with Firebase Firestore  
  - Cloud persistence for your tasks  

- **🔍 Search Functionality**  
  - Quickly find tasks by title or description  

- **🎨 Modern UI**  
  - Clean, intuitive interface with dark theme  

## 🚀 Installation  

### Prerequisites  
- Flutter SDK (latest stable version)  
- Firebase project with Firestore enabled  
- Android Studio/Xcode for emulator/simulator  

### Setup Steps  
1. **Clone the repository**:  
   ```bash
   git clone https://github.com/your-username/swift-do.git
   cd swift-do
Add Firebase configuration:

Add google-services.json for Android

Add GoogleService-Info.plist for iOS

Install dependencies:

bash
Copy
flutter pub get
Run the app:

bash
Copy
flutter run
🔥 Firebase Configuration
The app requires Firebase setup:

Create a Firebase project at Firebase Console

Enable Firestore Database

Add your Android/iOS app to the project

Download configuration files and place them in:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

🛠 Technical Stack
Framework: Flutter

State Management: Provider

Database: Firebase Firestore

UI: Custom design with Material 3

📅 Future Enhancements
Task categories/priority levels

Notifications for due tasks

Offline support

Task sharing functionality
