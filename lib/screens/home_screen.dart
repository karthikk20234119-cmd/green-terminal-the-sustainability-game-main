import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';
import '../widgets/terminal_widget.dart';
import '../utils/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _showWelcome = false;
  bool _showMenu = false;
  bool _showFooter = false;
  int _selectedOption = -1;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: AppConstants.fadeInDuration,
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: AppConstants.slideInDuration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuart,
    ));
    
    _startAnimationSequence();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _startAnimationSequence() async {
    // Start fade in
    _fadeController.forward();
    
    // Show welcome message after short delay
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _showWelcome = true;
      });
    }
    
    // Show menu after welcome message completes
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      setState(() {
        _showMenu = true;
      });
      _slideController.forward();
    }
    
    // Show footer
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _showFooter = true;
      });
    }
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
    
    // Add haptic feedback
    HapticFeedback.selectionClick();
    
    // Navigate after a brief delay for visual feedback
    Future.delayed(const Duration(milliseconds: 300), () {
      switch (index) {
        case 0:
          AppRouter.goToQuiz(context);
          break;
        case 1:
          AppRouter.goToFacts(context);
          break;
        case 2:
          AppRouter.goToCalculator(context);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < AppConstants.mobileBreakpoint;
    
    return Scaffold(
      body: MatrixBackground(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(
              isSmallScreen 
                  ? AppConstants.terminalPadding * 0.5 
                  : AppConstants.terminalPadding
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isSmallScreen 
                        ? screenSize.width - 32
                        : AppConstants.maxTerminalWidth,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome message
                      if (_showWelcome)
                        _buildWelcomeSection(isSmallScreen),
                      
                      if (_showWelcome && _showMenu)
                        SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // Menu options
                      if (_showMenu)
                        _buildMenuSection(isSmallScreen),
                      
                      if (_showMenu && _showFooter)
                        SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // Footer
                      if (_showFooter)
                        _buildFooterSection(isSmallScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        color: AppTheme.terminalBlack.withOpacity(0.8),
        border: Border.all(
          color: AppTheme.matrixGreen,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.matrixGreen.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App title with typing effect
          TerminalWidget(
            text: AppConstants.welcomeMessage,
            typingSpeed: const Duration(milliseconds: 30),
            onComplete: () {},
          ),
          
          const SizedBox(height: 16),
          
          // System info
          TerminalLine(
            text: 'System Status: ONLINE',
            style: AppTheme.terminalCommand.copyWith(
              color: AppTheme.brightGreen,
            ),
          ),
          
          const SizedBox(height: 8),
          
          TerminalLine(
            text: 'Connection: SECURE',
            style: AppTheme.terminalCommand.copyWith(
              color: AppTheme.brightGreen,
            ),
          ),
          
          const SizedBox(height: 8),
          
          TerminalLine(
            text: 'Ready for sustainability protocols...',
            style: AppTheme.terminalOutput,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(bool isSmallScreen) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        decoration: BoxDecoration(
          color: AppTheme.terminalBlack.withOpacity(0.9),
          border: Border.all(
            color: AppTheme.darkGreen,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu header
            Row(
              children: [
                Text(
                  AppConstants.systemPrompt,
                  style: AppTheme.terminalPrompt,
                ),
                Text(
                  'Select your mission:',
                  style: AppTheme.terminalCommand,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Menu options
            ...AppConstants.menuOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final description = AppConstants.menuDescriptions[index];
              
              return Column(
                children: [
                  TerminalButton(
                    text: option,
                    onPressed: () => _selectOption(index),
                    isSelected: _selectedOption == index,
                  ),
                  if (isSmallScreen) const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Text(
                      description,
                      style: AppTheme.terminalOutput.copyWith(
                        fontSize: isSmallScreen ? 11 : 12,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }).toList(),
            
            const SizedBox(height: 16),
            
            // Help text
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppTheme.darkGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Type "help" for commands or click options above',
                    style: AppTheme.terminalOutput.copyWith(
                      fontSize: isSmallScreen ? 11 : 12,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection(bool isSmallScreen) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppTheme.darkGreen,
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            // Company branding
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.eco,
                  size: isSmallScreen ? 16 : 20,
                  color: AppTheme.matrixGreen,
                ),
                const SizedBox(width: 8),
                Text(
                  AppConstants.companyName,
                  style: AppTheme.logoText.copyWith(
                    fontSize: isSmallScreen ? 16 : 18,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            Text(
              'Founded by ${AppConstants.founderName}',
              style: AppTheme.companyText.copyWith(
                fontSize: isSmallScreen ? 10 : 12,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Making sustainability education accessible to everyone',
              style: AppTheme.companyText.copyWith(
                fontSize: isSmallScreen ? 9 : 10,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

