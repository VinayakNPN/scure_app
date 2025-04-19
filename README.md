# S-cure App

<div align="center">
  
![S-cure Logo](https://img.shields.io/badge/S--cure-AI%20Security%20Assistant-0118D8?style=for-the-badge&logo=flutter&logoColor=white)

[![Flutter](https://img.shields.io/badge/Flutter-3.7%2B-blue?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Gemini AI](https://img.shields.io/badge/Powered%20by-Gemini%20AI-4285F4?style=flat-square&logo=google)](https://ai.google.dev/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

</div>

## 📱 Overview

S-cure is a modern Flutter application that leverages the power of Google's Gemini AI to provide intelligent responses to user queries. The app allows users to interact with Gemini AI through text inputs and image uploads, making it versatile for various use cases.

<div align="center">
  <table>
    <tr>
      <td><img src="/api/placeholder/250/500" alt="Login Screen" /></td>
      <td><img src="/api/placeholder/250/500" alt="Home Screen" /></td>
    </tr>
    <tr>
      <td align="center"><strong>Secure Login</strong></td>
      <td align="center"><strong>AI Assistant</strong></td>
    </tr>
  </table>
</div>

## ✨ Features

- **Gemini AI Integration**: Harness the capabilities of Google's powerful Gemini AI model
- **Image Analysis**: Upload or capture images to get AI-powered analysis and insights
- **User Authentication**: Secure signup and login functionality
- **Dark/Light Mode**: Automatic theme switching based on system preferences
- **Responsive UI**: Modern and clean interface that adapts to different screen sizes
- **Local Storage**: Secure data persistence using SharedPreferences

## 🛠️ Tech Stack

- **Flutter**: UI framework for building natively compiled applications
- **Gemini AI**: Google's multimodal AI model for generating text responses
- **SharedPreferences**: Local storage solution for user authentication
- **JSON Serialization**: Automated JSON serialization/deserialization
- **Material Design 3**: Modern design system for a polished UI experience

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code
- Google Gemini API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/scure_app.git
   cd scure_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up configuration**

   Create `assets/config.json` file with your Gemini API key:
   ```json
   {
     "geminiAPIkey": "YOUR_GEMINI_API_KEY"
   }
   ```

4. **Generate required code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── models/
│   └── user_model.dart         # User data model
├── screens/
│   └── auth/
│       ├── login_screen.dart   # Login screen UI
│       └── signup_screen.dart  # Signup screen UI
├── services/
│   ├── ai_service.dart         # Gemini AI integration logic
│   └── auth_service.dart       # Authentication service
├── widgets/
│   └── auth/
│       └── auth_text_field.dart # Custom text field for auth screens
├── config_model.dart           # Configuration model for API keys
├── config_model.g.dart         # Generated code for config model
├── home_screen.dart           # Main AI interaction screen
├── main.dart                  # App entry point
└── theme.dart                 # App theming configuration
```

## 🔐 Authentication

S-cure App uses local authentication with SharedPreferences to store user credentials securely. This approach enables:

- User registration with email validation
- Secure login with credential verification
- Password matching validation
- Persistent user sessions

## 🎨 UI Features

The app's UI is designed with a focus on user experience:

- Clean, minimal interface
- Responsive design adapts to different screen sizes
- Dark and light theme support
- Smooth transitions and animations
- Material Design 3 components

## 🤖 AI Capabilities

Powered by Google's Gemini AI, S-cure can:

- Answer general knowledge questions
- Analyze images and provide descriptions
- Generate creative content
- Provide explanations on complex topics
- Help with problem-solving

## 🛣️ Roadmap

- [ ] Cloud synchronization for user data
- [ ] Voice input support
- [ ] History of previous conversations
- [ ] Export conversations as PDF/text
- [ ] More granular theme customization
- [ ] Multiple language support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev/)
- [Google Gemini AI](https://ai.google.dev/)
- [Material Design](https://material.io/design)

---

<div align="center">
  
Made with ❤️ by Vinayak Chouhan

</div>