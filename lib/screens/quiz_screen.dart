import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../utils/app_router.dart';
import '../widgets/terminal_widget.dart';
import '../models/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool showExplanation = false;
  bool quizCompleted = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (showExplanation) return;
    
    setState(() {
      selectedAnswer = index;
      showExplanation = true;
      if (index == QuizData.questions[currentQuestionIndex].correctIndex) {
        score++;
      }
    });
    HapticFeedback.selectionClick();
  }

  void _nextQuestion() {
    if (currentQuestionIndex < QuizData.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showExplanation = false;
      });
      _fadeController.forward(from: 0);
    } else {
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswer = null;
      showExplanation = false;
      quizCompleted = false;
    });
    _fadeController.forward(from: 0);
  }

  String _getScoreMessage() {
    final percentage = (score / QuizData.questions.length * 100).round();
    if (percentage >= 80) {
      return "🌟 Excellent! You're a sustainability expert!";
    } else if (percentage >= 60) {
      return "💚 Good job! You have solid environmental knowledge.";
    } else if (percentage >= 40) {
      return "🌱 Not bad! Keep learning about sustainability.";
    } else {
      return "🌍 Keep exploring! Every bit of knowledge helps our planet.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.matrixBlack,
      appBar: AppBar(
        title: Text(
          'SUSTAINABILITY QUIZ',
          style: AppTheme.logoText.copyWith(fontSize: isSmallScreen ? 18 : 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goBack(context),
        ),
        actions: [
          if (!quizCompleted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Score: $score/${currentQuestionIndex + (showExplanation ? 1 : 0)}',
                  style: AppTheme.terminalOutput,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: quizCompleted ? _buildCompletionScreen(isSmallScreen) : _buildQuizContent(isSmallScreen),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizContent(bool isSmallScreen) {
    final question = QuizData.questions[currentQuestionIndex];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress indicator
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.terminalBlack.withOpacity(0.8),
            border: Border.all(color: AppTheme.darkGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                'Question ${currentQuestionIndex + 1} of ${QuizData.questions.length}',
                style: AppTheme.terminalCommand,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / QuizData.questions.length,
                backgroundColor: AppTheme.darkGreen.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.matrixGreen),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Question
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
          decoration: BoxDecoration(
            color: AppTheme.terminalBlack.withOpacity(0.9),
            border: Border.all(color: AppTheme.matrixGreen, width: 2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.matrixGreen.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(
            question.question,
            style: AppTheme.terminalPrompt.copyWith(
              fontSize: isSmallScreen ? 16 : 18,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Options
        ...question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = selectedAnswer == index;
          final isCorrect = index == question.correctIndex;
          
          Color borderColor = AppTheme.darkGreen;
          Color? backgroundColor;
          
          if (showExplanation) {
            if (isCorrect) {
              borderColor = AppTheme.matrixGreen;
              backgroundColor = AppTheme.matrixGreen.withOpacity(0.1);
            } else if (isSelected && !isCorrect) {
              borderColor = Colors.red;
              backgroundColor = Colors.red.withOpacity(0.1);
            }
          } else if (isSelected) {
            borderColor = AppTheme.lightGreen;
            backgroundColor = AppTheme.matrixGreen.withOpacity(0.1);
          }
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _selectAnswer(index),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.transparent,
                  border: Border.all(color: borderColor, width: isSelected || (showExplanation && isCorrect) ? 2 : 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor),
                        color: (showExplanation && isCorrect) || (isSelected && !showExplanation)
                            ? borderColor.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: AppTheme.terminalCommand.copyWith(
                            color: borderColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option,
                        style: AppTheme.terminalOutput.copyWith(
                          fontSize: isSmallScreen ? 14 : 16,
                          color: showExplanation && isCorrect
                              ? AppTheme.matrixGreen
                              : (showExplanation && isSelected && !isCorrect)
                                  ? Colors.red
                                  : AppTheme.lightGreen,
                        ),
                      ),
                    ),
                    if (showExplanation)
                      Icon(
                        isCorrect ? Icons.check_circle : (isSelected ? Icons.cancel : null),
                        color: isCorrect ? AppTheme.matrixGreen : Colors.red,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        
        // Explanation
        if (showExplanation) ...[
          const SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            decoration: BoxDecoration(
              color: AppTheme.dimGreen.withOpacity(0.2),
              border: Border.all(color: AppTheme.darkGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.matrixGreen,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Explanation',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  question.explanation,
                  style: AppTheme.terminalOutput.copyWith(
                    fontSize: isSmallScreen ? 13 : 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: _nextQuestion,
              icon: const Icon(Icons.arrow_forward),
              label: Text(
                currentQuestionIndex < QuizData.questions.length - 1
                    ? 'Next Question'
                    : 'View Results',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCompletionScreen(bool isSmallScreen) {
    final percentage = (score / QuizData.questions.length * 100).round();
    
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
      decoration: BoxDecoration(
        color: AppTheme.terminalBlack.withOpacity(0.9),
        border: Border.all(color: AppTheme.matrixGreen, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.matrixGreen.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            percentage >= 80 ? Icons.emoji_events : Icons.eco,
            size: isSmallScreen ? 64 : 80,
            color: AppTheme.matrixGreen,
          ),
          const SizedBox(height: 24),
          Text(
            'QUIZ COMPLETED!',
            style: AppTheme.logoText.copyWith(
              fontSize: isSmallScreen ? 24 : 28,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.matrixGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.darkGreen),
            ),
            child: Column(
              children: [
                Text(
                  'Your Score',
                  style: AppTheme.terminalCommand.copyWith(
                    fontSize: isSmallScreen ? 16 : 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$score / ${QuizData.questions.length}',
                  style: AppTheme.logoText.copyWith(
                    fontSize: isSmallScreen ? 36 : 48,
                    color: AppTheme.brightGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$percentage%',
                  style: AppTheme.terminalPrompt.copyWith(
                    fontSize: isSmallScreen ? 20 : 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _getScoreMessage(),
            style: AppTheme.terminalOutput.copyWith(
              fontSize: isSmallScreen ? 14 : 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () => AppRouter.goHome(context),
                icon: const Icon(Icons.home),
                label: const Text('Home'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.darkGreen),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
