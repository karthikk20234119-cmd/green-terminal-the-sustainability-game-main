import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/facts_screen.dart';
import '../screens/calculator_screen.dart';
import '../constants/app_constants.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.quizRoute,
        name: 'quiz',
        builder: (context, state) => const QuizScreen(),
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const QuizScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.factsRoute,
        name: 'facts',
        builder: (context, state) => const FactsScreen(),
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const FactsScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.calculatorRoute,
        name: 'calculator',
        builder: (context, state) => const CalculatorScreen(),
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const CalculatorScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => _ErrorScreen(error: state.error.toString()),
  );

  static GoRouter get router => _router;

  static CustomTransitionPage _buildPageWithTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Matrix-style slide transition
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
          ),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  // Navigation helper methods
  static void goHome(BuildContext context) {
    GoRouter.of(context).go(AppConstants.homeRoute);
  }

  static void goToQuiz(BuildContext context) {
    GoRouter.of(context).go(AppConstants.quizRoute);
  }

  static void goToFacts(BuildContext context) {
    GoRouter.of(context).go(AppConstants.factsRoute);
  }

  static void goToCalculator(BuildContext context) {
    GoRouter.of(context).go(AppConstants.calculatorRoute);
  }

  static void goBack(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else {
      goHome(context);
    }
  }
}

class _ErrorScreen extends StatelessWidget {
  final String error;

  const _ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error 404',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Page not found in the matrix...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => AppRouter.goHome(context),
              child: const Text('Return to Terminal'),
            ),
            const SizedBox(height: 16),
            if (error.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  'Debug info: $error',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
