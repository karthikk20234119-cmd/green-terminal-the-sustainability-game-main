import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'utils/app_router.dart';
import 'constants/app_constants.dart';

void main() {
  // Set preferred device orientations and system UI
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Set system UI overlay style for Matrix theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.matrixBlack,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const GreenTerminalApp());
}

class GreenTerminalApp extends StatelessWidget {
  const GreenTerminalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.darkTheme,
      
      // Routing configuration
      routerConfig: AppRouter.router,
      
      // App metadata
      builder: (context, child) {
        return MediaQuery(
          // Ensure text doesn't scale beyond readable limits
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
