import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../utils/app_router.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Plastic Waste Calculator
  double plasticBottles = 0;
  double plasticBags = 0;
  double takeawayContainers = 0;
  double plasticStraws = 0;
  double plasticCups = 0;
  
  // Carbon Footprint Calculator
  double plasticWasteKg = 0;
  double recycledPercentage = 0;
  
  // Water Savings Calculator
  double reusableBottlesPerWeek = 0;
  double reusableBagsPerMonth = 0;
  double reusableContainersPerWeek = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  double calculateWeeklyPlasticWaste() {
    // Average weights in grams
    const bottleWeight = 20.0;
    const bagWeight = 5.0;
    const containerWeight = 30.0;
    const strawWeight = 0.5;
    const cupWeight = 10.0;
    
    return (plasticBottles * bottleWeight +
            plasticBags * bagWeight +
            takeawayContainers * containerWeight +
            plasticStraws * strawWeight +
            plasticCups * cupWeight) / 1000; // Convert to kg
  }
  
  double calculateCarbonFootprint() {
    // 6kg CO2 per kg of plastic
    const co2PerKg = 6.0;
    final recyclingReduction = plasticWasteKg * (recycledPercentage / 100) * 0.88;
    return (plasticWasteKg * co2PerKg) - recyclingReduction;
  }
  
  double calculateWaterSavings() {
    // Liters of water saved
    const waterPerBottle = 3.0; // Production water for one plastic bottle
    const waterPerBag = 1.0;
    const waterPerContainer = 2.0;
    
    return (reusableBottlesPerWeek * waterPerBottle * 52) +
           (reusableBagsPerMonth * waterPerBag * 12) +
           (reusableContainersPerWeek * waterPerContainer * 52);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.matrixBlack,
      appBar: AppBar(
        title: Text(
          'IMPACT CALCULATORS',
          style: AppTheme.logoText.copyWith(fontSize: isSmallScreen ? 18 : 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goBack(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.matrixGreen,
          labelColor: AppTheme.matrixGreen,
          unselectedLabelColor: AppTheme.darkGreen,
          tabs: [
            Tab(
              icon: Icon(Icons.delete_outline, size: isSmallScreen ? 20 : 24),
              text: isSmallScreen ? 'Waste' : 'Plastic Waste',
            ),
            Tab(
              icon: Icon(Icons.co2, size: isSmallScreen ? 20 : 24),
              text: isSmallScreen ? 'Carbon' : 'Carbon Footprint',
            ),
            Tab(
              icon: Icon(Icons.water_drop, size: isSmallScreen ? 20 : 24),
              text: isSmallScreen ? 'Water' : 'Water Savings',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPlasticWasteCalculator(isSmallScreen),
          _buildCarbonCalculator(isSmallScreen),
          _buildWaterSavingsCalculator(isSmallScreen),
        ],
      ),
    );
  }
  
  Widget _buildPlasticWasteCalculator(bool isSmallScreen) {
    final weeklyWaste = calculateWeeklyPlasticWaste();
    final yearlyWaste = weeklyWaste * 52;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.8),
                  border: Border.all(color: AppTheme.matrixGreen),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.recycling,
                      size: isSmallScreen ? 48 : 64,
                      color: AppTheme.matrixGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Weekly Plastic Usage',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 18 : 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSliderInput(
                      'Plastic Bottles',
                      Icons.local_drink,
                      plasticBottles,
                      0,
                      50,
                      (value) => setState(() => plasticBottles = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Plastic Bags',
                      Icons.shopping_bag,
                      plasticBags,
                      0,
                      30,
                      (value) => setState(() => plasticBags = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Takeaway Containers',
                      Icons.takeout_dining,
                      takeawayContainers,
                      0,
                      20,
                      (value) => setState(() => takeawayContainers = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Plastic Straws',
                      Icons.vertical_align_bottom,
                      plasticStraws,
                      0,
                      30,
                      (value) => setState(() => plasticStraws = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Disposable Cups',
                      Icons.coffee,
                      plasticCups,
                      0,
                      30,
                      (value) => setState(() => plasticCups = value),
                      isSmallScreen,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Results
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.9),
                  border: Border.all(color: AppTheme.matrixGreen, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.matrixGreen.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'YOUR PLASTIC FOOTPRINT',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 16 : 18,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildResultRow(
                      'Weekly Waste',
                      '${weeklyWaste.toStringAsFixed(2)} kg',
                      Icons.calendar_today,
                      isSmallScreen,
                    ),
                    
                    _buildResultRow(
                      'Yearly Waste',
                      '${yearlyWaste.toStringAsFixed(1)} kg',
                      Icons.calendar_month,
                      isSmallScreen,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      yearlyWaste > 50
                          ? '🔴 High plastic consumption! Consider switching to reusables.'
                          : yearlyWaste > 20
                              ? '🟡 Moderate usage. Room for improvement!'
                              : '🟢 Great job! Keep reducing plastic use!',
                      style: AppTheme.terminalOutput.copyWith(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: yearlyWaste > 50
                            ? Colors.red
                            : yearlyWaste > 20
                                ? Colors.orange
                                : AppTheme.matrixGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCarbonCalculator(bool isSmallScreen) {
    final carbonFootprint = calculateCarbonFootprint();
    final treesNeeded = (carbonFootprint / 21).round(); // One tree absorbs ~21kg CO2/year
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.8),
                  border: Border.all(color: AppTheme.matrixGreen),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.co2,
                      size: isSmallScreen ? 48 : 64,
                      color: AppTheme.matrixGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Carbon Footprint Calculator',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 18 : 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSliderInput(
                      'Annual Plastic Waste (kg)',
                      Icons.scale,
                      plasticWasteKg,
                      0,
                      200,
                      (value) => setState(() => plasticWasteKg = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Recycling Rate (%)',
                      Icons.recycling,
                      recycledPercentage,
                      0,
                      100,
                      (value) => setState(() => recycledPercentage = value),
                      isSmallScreen,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Results
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.9),
                  border: Border.all(color: AppTheme.matrixGreen, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.matrixGreen.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'CO₂ EMISSIONS',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 16 : 18,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      '${carbonFootprint.toStringAsFixed(1)}',
                      style: AppTheme.logoText.copyWith(
                        fontSize: isSmallScreen ? 48 : 64,
                        color: AppTheme.brightGreen,
                      ),
                    ),
                    Text(
                      'kg CO₂ per year',
                      style: AppTheme.terminalOutput.copyWith(
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.darkGreen),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.park,
                            color: AppTheme.matrixGreen,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Equivalent to $treesNeeded trees needed',
                            style: AppTheme.terminalOutput.copyWith(
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWaterSavingsCalculator(bool isSmallScreen) {
    final waterSaved = calculateWaterSavings();
    final showers = (waterSaved / 65).round(); // Average shower uses 65 liters
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.8),
                  border: Border.all(color: AppTheme.matrixGreen),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.water_drop,
                      size: isSmallScreen ? 48 : 64,
                      color: AppTheme.matrixGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Water Savings Calculator',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 18 : 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSliderInput(
                      'Reusable Bottles/Week',
                      Icons.water,
                      reusableBottlesPerWeek,
                      0,
                      50,
                      (value) => setState(() => reusableBottlesPerWeek = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Reusable Bags/Month',
                      Icons.eco,
                      reusableBagsPerMonth,
                      0,
                      100,
                      (value) => setState(() => reusableBagsPerMonth = value),
                      isSmallScreen,
                    ),
                    
                    _buildSliderInput(
                      'Reusable Containers/Week',
                      Icons.food_bank,
                      reusableContainersPerWeek,
                      0,
                      30,
                      (value) => setState(() => reusableContainersPerWeek = value),
                      isSmallScreen,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Results
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                decoration: BoxDecoration(
                  color: AppTheme.terminalBlack.withOpacity(0.9),
                  border: Border.all(color: AppTheme.matrixGreen, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.matrixGreen.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'ANNUAL WATER SAVINGS',
                      style: AppTheme.terminalPrompt.copyWith(
                        fontSize: isSmallScreen ? 16 : 18,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      '${waterSaved.toStringAsFixed(0)}',
                      style: AppTheme.logoText.copyWith(
                        fontSize: isSmallScreen ? 48 : 64,
                        color: AppTheme.brightGreen,
                      ),
                    ),
                    Text(
                      'liters saved per year',
                      style: AppTheme.terminalOutput.copyWith(
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.darkGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.darkGreen),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shower,
                                color: AppTheme.matrixGreen,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Equal to $showers showers',
                                style: AppTheme.terminalOutput.copyWith(
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            waterSaved > 5000
                                ? '🌊 Amazing water conservation!'
                                : waterSaved > 1000
                                    ? '💧 Good progress!'
                                    : '💦 Every drop counts!',
                            style: AppTheme.terminalOutput.copyWith(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: AppTheme.matrixGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSliderInput(
    String label,
    IconData icon,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.matrixGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.terminalCommand.copyWith(
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.matrixGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.darkGreen),
                ),
                child: Text(
                  value.toStringAsFixed(0),
                  style: AppTheme.terminalOutput.copyWith(
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.matrixGreen,
              inactiveTrackColor: AppTheme.darkGreen.withOpacity(0.3),
              thumbColor: AppTheme.matrixGreen,
              overlayColor: AppTheme.matrixGreen.withOpacity(0.3),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultRow(
    String label,
    String value,
    IconData icon,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.darkGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.terminalCommand.copyWith(
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: AppTheme.terminalOutput.copyWith(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.brightGreen,
            ),
          ),
        ],
      ),
    );
  }
}
