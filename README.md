# 🌱 Green Terminal: The Sustainability Game

<div align="center">
  
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20Windows-green?style=for-the-badge" alt="Platform">
  
  <h3>🎮 A Matrix-inspired educational game about plastic recycling and sustainability</h3>
  <p><strong>Built by Codera Technologies | Founded by Lule Arther</strong></p>
  
</div>

---

## 📖 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Getting Started](#-getting-started)
- [Installation](#-installation)
- [Usage](#-usage)
- [Game Modules](#-game-modules)
- [Technical Details](#-technical-details)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## 🎯 About

**Green Terminal** is an innovative educational platform that gamifies environmental learning through a stunning Matrix-style terminal interface. This Flutter application makes learning about plastic pollution, recycling, and sustainability engaging and interactive for users of all ages.

The app combines retro terminal aesthetics with modern educational content, featuring animated Matrix rain effects, typewriter animations, and a green-on-black color scheme that creates an immersive learning experience.

### 🌍 Our Mission

> *"Making environmental education accessible, engaging, and actionable for everyone through the power of technology."*

---

## ✨ Features

### 🎨 Visual Design
- **Matrix Rain Animation**: Dynamic background with falling code characters
- **Terminal Aesthetics**: Authentic command-line interface design
- **Green Monochrome Theme**: Classic hacker-style green text on black background
- **Typewriter Effects**: Animated text that types out like a real terminal
- **Responsive Design**: Adapts perfectly to any screen size

### 🎮 Interactive Learning Modules

#### 1. **Sustainability Quiz** 🧠
- 10 carefully crafted questions about plastic pollution and recycling
- Real-time scoring system
- Detailed explanations for each answer
- Progress tracking with visual indicators
- Personalized feedback based on performance

#### 2. **Green Facts** 🌱
- 25+ fascinating environmental facts
- Category filtering (Ocean Pollution, Recycling, Wildlife Impact, etc.)
- Random fact generator
- Facts history tracking
- Share functionality for spreading awareness

#### 3. **Impact Calculators** 📊

**Three Interactive Calculators:**

- **Plastic Waste Calculator**
  - Track weekly usage of bottles, bags, containers, straws, and cups
  - Calculate annual plastic footprint
  - Color-coded feedback system

- **Carbon Footprint Calculator**
  - Input plastic waste and recycling rate
  - Calculate CO₂ emissions
  - Visualize equivalent trees needed for offset

- **Water Savings Calculator**
  - Track reusable item usage
  - Calculate annual water savings
  - Compare savings to everyday usage (showers)

---

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <strong>🏠 Home Screen</strong><br>
        Matrix-style welcome with menu options
      </td>
      <td align="center">
        <strong>🧠 Quiz Module</strong><br>
        Interactive questions with scoring
      </td>
    </tr>
    <tr>
      <td align="center">
        <strong>🌱 Green Facts</strong><br>
        Environmental facts with categories
      </td>
      <td align="center">
        <strong>📊 Calculators</strong><br>
        Three impact calculation tools
      </td>
    </tr>
  </table>
</div>

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.7.2 or higher
  ```bash
  flutter --version
  ```
  
- **Dart SDK**: Comes with Flutter
- **Git**: For version control
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Chrome**: For web development
- **Android Studio**: For Android development (optional)
- **Visual Studio**: For Windows development (optional)

---

## 💻 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/LuleArther/Green-Terminal-The-Sustainability-Game-.git
cd Green-Terminal-The-Sustainability-Game-
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

#### For Web (Recommended for quick testing)
```bash
flutter run -d chrome
```

#### For Android
```bash
flutter run -d android
```

#### For Windows
```bash
flutter run -d windows
```

#### List all available devices
```bash
flutter devices
```

---

## 🏗️ Building for Production

### Web Build
```bash
flutter build web --release
# Output: build/web/
```

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### Windows Executable
```bash
flutter build windows --release
# Output: build/windows/x64/runner/Release/
```

---

## 📱 Usage

### Navigation

1. **Launch the app** - You'll see the Matrix rain animation and welcome screen
2. **Main Menu** - Choose from three options:
   - Press `[1]` or click for Sustainability Quiz
   - Press `[2]` or click for Green Facts
   - Press `[3]` or click for Impact Calculators
3. **Back Navigation** - Use the back arrow in the app bar to return

### Hot Reload (Development)

While running in debug mode:
- Press `r` for hot reload
- Press `R` for hot restart
- Press `h` for help
- Press `q` to quit

---

## 🎮 Game Modules

### Module 1: Sustainability Quiz

**How to Play:**
1. Start the quiz from the main menu
2. Read each question carefully
3. Select your answer from four options
4. View the explanation after answering
5. Click "Next Question" to continue
6. See your final score and performance message

**Topics Covered:**
- Plastic recycling rates
- Ocean pollution
- Microplastics
- Decomposition times
- Global plastic production

### Module 2: Green Facts

**Features:**
- Browse facts by category
- Generate random facts
- View fact history
- Share interesting facts

**Categories:**
- Ocean Pollution
- Decomposition
- Health Impact
- Recycling Benefits
- Wildlife Impact
- And more...

### Module 3: Impact Calculators

**Calculator Types:**

1. **Plastic Waste Calculator**
   - Input your weekly plastic usage
   - See annual waste projection
   - Get personalized recommendations

2. **Carbon Footprint Calculator**
   - Calculate CO₂ from plastic waste
   - Adjust for recycling percentage
   - Visualize environmental impact

3. **Water Savings Calculator**
   - Track reusable item usage
   - Calculate water conservation
   - Compare to everyday water usage

---

## 🛠️ Technical Details

### Project Structure

```
green_terminal/
├── lib/
│   ├── main.dart              # App entry point
│   ├── constants/              # App constants and strings
│   ├── models/                 # Data models (quiz, facts)
│   ├── screens/                # All app screens
│   │   ├── home_screen.dart
│   │   ├── quiz_screen.dart
│   │   ├── facts_screen.dart
│   │   └── calculator_screen.dart
│   ├── theme/                  # Matrix theme configuration
│   ├── utils/                  # Routing and utilities
│   └── widgets/                # Reusable UI components
├── web/                        # Web-specific files
├── android/                    # Android-specific files
├── windows/                    # Windows-specific files
├── pubspec.yaml               # Dependencies
└── README.md                  # This file
```

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^14.6.1          # Navigation
  animated_text_kit: ^4.2.2   # Text animations
  google_fonts: ^6.3.0        # Terminal fonts
```

### Key Features Implementation

- **State Management**: StatefulWidget with setState
- **Navigation**: go_router for declarative routing
- **Animations**: AnimationController and custom animations
- **Responsive Design**: MediaQuery and adaptive layouts
- **Theme**: Custom Material 3 dark theme

---

## 🤝 Contributing

We welcome contributions to make Green Terminal even better!

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Areas for Contribution

- Add more quiz questions
- Include additional environmental facts
- Improve calculator algorithms
- Add new language translations
- Enhance animations and visual effects
- Write tests
- Improve documentation

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

### Codera Technologies

**Founder & Lead Developer:** Lule Arther

Codera Technologies is an innovative tech company dedicated to creating technology solutions that address real-world challenges, particularly in sustainability and environmental education.

---

## 📞 Contact

- **GitHub**: [@LuleArther](https://github.com/LuleArther)
- **Repository**: [Green Terminal](https://github.com/LuleArther/Green-Terminal-The-Sustainability-Game-)
- **Issues**: [Report bugs or request features](https://github.com/LuleArther/Green-Terminal-The-Sustainability-Game-/issues)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for inspiration
- Environmental activists worldwide
- All contributors and users of Green Terminal

---

<div align="center">
  
  ### 💚 Made with love for our planet
  
  **Green Terminal - Where Technology Meets Sustainability**
  
  *© 2024 Codera Technologies. All rights reserved.*
  
</div>
