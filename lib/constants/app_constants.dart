class AppConstants {
  // App Information
  static const String appName = 'Green Terminal';
  static const String companyName = 'Codera Technologies';
  static const String founderName = 'Lule Arther';
  static const String appVersion = '1.0.0';
  
  // Terminal Messages
  static const String welcomeMessage = '''
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                      GREEN TERMINAL                            ┃
┃                 Sustainability Command Center                  ┃
┃                                                                ┃
┃                Powered by Codera Technologies                  ┃
┃                   Founded by Lule Arther                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

Welcome to the future of sustainability education!
''';

  static const String systemPrompt = 'green@terminal:~\$ ';
  
  static const String loadingMessage = 'Initializing sustainability protocols...';
  
  // Menu Options
  static const List<String> menuOptions = [
    '[1] Sustainability Quiz',
    '[2] Green Facts',
    '[3] Impact Calculators',
  ];
  
  static const List<String> menuDescriptions = [
    'Test your knowledge about plastic recycling and climate action',
    'Discover fascinating facts about environmental conservation',
    'Calculate your environmental impact and carbon footprint',
  ];
  
  // Routes
  static const String homeRoute = '/';
  static const String quizRoute = '/quiz';
  static const String factsRoute = '/facts';
  static const String calculatorRoute = '/calculator';
  
  // Animation durations
  static const Duration typingSpeed = Duration(milliseconds: 50);
  static const Duration fadeInDuration = Duration(milliseconds: 800);
  static const Duration slideInDuration = Duration(milliseconds: 1000);
  
  // Terminal dimensions
  static const double maxTerminalWidth = 800.0;
  static const double terminalPadding = 24.0;
  static const double optionSpacing = 16.0;
  
  // Responsive breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  
  // Matrix effect settings
  static const int matrixDropCount = 20;
  static const double matrixDropSpeed = 1.5;
  
  // Error messages
  static const String networkError = 'Connection failed. Please check your network.';
  static const String unknownError = 'An unexpected error occurred.';
  static const String invalidOptionError = 'Invalid option selected. Please try again.';
}

class TerminalCommands {
  static const String help = 'help';
  static const String clear = 'clear';
  static const String exit = 'exit';
  static const String about = 'about';
  static const String version = 'version';
  static const String quiz = 'quiz';
  static const String facts = 'facts';
  static const String calc = 'calc';
}

class AppStrings {
  // About text
  static const String aboutText = '''
Green Terminal v1.0.0

A revolutionary sustainability education platform that combines 
retro terminal aesthetics with modern environmental awareness.

🌱 Features:
  • Interactive sustainability quizzes
  • Environmental impact calculators
  • Educational facts and tips
  • Gamified learning experience

🚀 Built with Flutter for Web, Android, and Windows

💚 Created by Codera Technologies
   Founded by Lule Arther

🌍 Mission: Making environmental education accessible,
   engaging, and actionable for everyone.
''';

  // Help text
  static const String helpText = '''
Available Commands:

  help     - Show this help message
  clear    - Clear the terminal screen
  about    - Display app information
  version  - Show app version
  quiz     - Start sustainability quiz
  facts    - View green facts
  calc     - Open impact calculators
  exit     - Exit the application

Navigation:
  Use [1], [2], [3] to select menu options
  Type commands or use interactive buttons
''';
}
