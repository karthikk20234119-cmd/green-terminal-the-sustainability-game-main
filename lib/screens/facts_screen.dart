import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import '../utils/app_router.dart';
import '../models/facts_model.dart';
import '../widgets/terminal_widget.dart';

class FactsScreen extends StatefulWidget {
  const FactsScreen({Key? key}) : super(key: key);

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  GreenFact? currentFact;
  String? selectedCategory;
  List<GreenFact> displayedFacts = [];
  final List<String> categories = ['All', ...FactsData.getCategories()];
  
  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideController = AnimationController(
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
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuart,
    ));
    
    _loadNewFact();
    _fadeController.forward();
    _slideController.forward();
  }
  
  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }
  
  void _loadNewFact() {
    setState(() {
      if (selectedCategory == null || selectedCategory == 'All') {
        currentFact = FactsData.facts[math.Random().nextInt(FactsData.facts.length)];
      } else {
        final categoryFacts = FactsData.getFactsByCategory(selectedCategory!);
        if (categoryFacts.isNotEmpty) {
          currentFact = categoryFacts[math.Random().nextInt(categoryFacts.length)];
        }
      }
      
      if (currentFact != null && !displayedFacts.contains(currentFact)) {
        displayedFacts.add(currentFact!);
        if (displayedFacts.length > 10) {
          displayedFacts.removeAt(0);
        }
      }
    });
    
    _fadeController.forward(from: 0);
    _slideController.forward(from: 0);
  }
  
  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category == 'All' ? null : category;
    });
    _loadNewFact();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.matrixBlack,
      appBar: AppBar(
        title: Text(
          'GREEN FACTS',
          style: AppTheme.logoText.copyWith(fontSize: isSmallScreen ? 18 : 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goBack(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  // Category filter
                  _buildCategoryFilter(isSmallScreen),
                  
                  const SizedBox(height: 24),
                  
                  // Main fact display
                  if (currentFact != null)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildFactCard(currentFact!, isSmallScreen),
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  _buildActionButtons(isSmallScreen),
                  
                  const SizedBox(height: 32),
                  
                  // Recent facts history
                  if (displayedFacts.length > 1)
                    _buildFactsHistory(isSmallScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryFilter(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: AppTheme.terminalBlack.withOpacity(0.8),
        border: Border.all(color: AppTheme.darkGreen),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: AppTheme.matrixGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Filter by Category',
                style: AppTheme.terminalPrompt.copyWith(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              final isSelected = (category == 'All' && selectedCategory == null) ||
                  category == selectedCategory;
              return InkWell(
                onTap: () => _selectCategory(category),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.matrixGreen.withOpacity(0.2)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppTheme.matrixGreen : AppTheme.darkGreen,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: AppTheme.terminalOutput.copyWith(
                      fontSize: isSmallScreen ? 11 : 12,
                      color: isSelected ? AppTheme.matrixGreen : AppTheme.lightGreen,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFactCard(GreenFact fact, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 28),
      decoration: BoxDecoration(
        color: AppTheme.terminalBlack.withOpacity(0.9),
        border: Border.all(color: AppTheme.matrixGreen, width: 2),
        borderRadius: BorderRadius.circular(12),
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
          // Icon and category
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fact.icon,
                style: TextStyle(fontSize: isSmallScreen ? 48 : 64),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Category badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.darkGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.darkGreen),
            ),
            child: Text(
              fact.category.toUpperCase(),
              style: AppTheme.terminalCommand.copyWith(
                fontSize: isSmallScreen ? 10 : 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Fact text with typing animation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.matrixGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.darkGreen.withOpacity(0.5)),
            ),
            child: Text(
              '"${fact.fact}"',
              style: AppTheme.terminalOutput.copyWith(
                fontSize: isSmallScreen ? 16 : 18,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Did you know label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: AppTheme.darkGreen,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'DID YOU KNOW?',
                style: AppTheme.terminalCommand.copyWith(
                  fontSize: isSmallScreen ? 10 : 12,
                  color: AppTheme.darkGreen,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _loadNewFact,
          icon: const Icon(Icons.refresh),
          label: Text(isSmallScreen ? 'Next' : 'Next Fact'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 32,
              vertical: isSmallScreen ? 12 : 16,
            ),
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {
            // Share functionality could be added here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Fact copied to clipboard!',
                  style: AppTheme.terminalOutput,
                ),
                backgroundColor: AppTheme.darkGreen,
              ),
            );
          },
          icon: const Icon(Icons.share),
          label: const Text('Share'),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppTheme.darkGreen),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 32,
              vertical: isSmallScreen ? 12 : 16,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFactsHistory(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: AppTheme.terminalBlack.withOpacity(0.8),
        border: Border.all(color: AppTheme.darkGreen),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: AppTheme.matrixGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Recent Facts',
                style: AppTheme.terminalPrompt.copyWith(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...displayedFacts.reversed.take(5).map((fact) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fact.icon,
                    style: TextStyle(fontSize: isSmallScreen ? 16 : 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fact.category,
                          style: AppTheme.terminalCommand.copyWith(
                            fontSize: isSmallScreen ? 10 : 11,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                        Text(
                          fact.fact,
                          style: AppTheme.terminalOutput.copyWith(
                            fontSize: isSmallScreen ? 11 : 12,
                            color: AppTheme.lightGreen.withOpacity(0.8),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
