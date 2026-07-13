class GreenFact {
  final String fact;
  final String category;
  final String icon;

  GreenFact({
    required this.fact,
    required this.category,
    required this.icon,
  });
}

class FactsData {
  static final List<GreenFact> facts = [
    GreenFact(
      fact: "Every minute, one garbage truck worth of plastic is dumped into our oceans.",
      category: "Ocean Pollution",
      icon: "🌊",
    ),
    GreenFact(
      fact: "A single plastic bag takes up to 1,000 years to degrade in a landfill.",
      category: "Decomposition",
      icon: "🛍️",
    ),
    GreenFact(
      fact: "The average person eats 70,000 microplastics each year.",
      category: "Health Impact",
      icon: "🍽️",
    ),
    GreenFact(
      fact: "Recycling one ton of plastic saves 7.4 cubic yards of landfill space.",
      category: "Recycling Benefits",
      icon: "♻️",
    ),
    GreenFact(
      fact: "By 2050, there could be more plastic than fish in the ocean by weight.",
      category: "Future Projections",
      icon: "🐟",
    ),
    GreenFact(
      fact: "Over 1 million marine animals die each year from plastic pollution.",
      category: "Wildlife Impact",
      icon: "🐢",
    ),
    GreenFact(
      fact: "91% of plastic waste isn't recycled globally.",
      category: "Recycling Stats",
      icon: "📊",
    ),
    GreenFact(
      fact: "Plastic production has increased by 200-fold since 1950.",
      category: "Production Growth",
      icon: "📈",
    ),
    GreenFact(
      fact: "A plastic water bottle takes 450 years to decompose.",
      category: "Decomposition",
      icon: "🍶",
    ),
    GreenFact(
      fact: "The Great Pacific Garbage Patch is 3 times the size of France.",
      category: "Ocean Pollution",
      icon: "🗺️",
    ),
    GreenFact(
      fact: "Humans have produced 8.3 billion metric tons of plastic since 1950.",
      category: "Production Stats",
      icon: "🏭",
    ),
    GreenFact(
      fact: "500 billion plastic cups are used globally every year.",
      category: "Single-Use Stats",
      icon: "☕",
    ),
    GreenFact(
      fact: "Plastic bottles require up to 700 years to dissolve.",
      category: "Decomposition",
      icon: "🧴",
    ),
    GreenFact(
      fact: "73% of beach litter worldwide is plastic.",
      category: "Beach Pollution",
      icon: "🏖️",
    ),
    GreenFact(
      fact: "1 million plastic bottles are bought every minute globally.",
      category: "Consumption",
      icon: "⏱️",
    ),
    GreenFact(
      fact: "Microplastics have been found in 83% of tap water samples worldwide.",
      category: "Water Pollution",
      icon: "🚰",
    ),
    GreenFact(
      fact: "Only 1 in 5 plastic bottles are recycled.",
      category: "Recycling Stats",
      icon: "♻️",
    ),
    GreenFact(
      fact: "Plastic accounts for 10% of all waste we generate.",
      category: "Waste Stats",
      icon: "🗑️",
    ),
    GreenFact(
      fact: "The energy saved from recycling one plastic bottle can power a 60W bulb for 3 hours.",
      category: "Energy Savings",
      icon: "💡",
    ),
    GreenFact(
      fact: "Plastic bags are used for an average of 12 minutes before being thrown away.",
      category: "Usage Stats",
      icon: "⏰",
    ),
    GreenFact(
      fact: "If current trends continue, by 2050 there will be 12 billion metric tons of plastic in landfills.",
      category: "Future Projections",
      icon: "📅",
    ),
    GreenFact(
      fact: "Recycling plastic saves 88% of the energy required to produce plastic from raw materials.",
      category: "Energy Savings",
      icon: "⚡",
    ),
    GreenFact(
      fact: "Americans throw away 35 billion plastic bottles every year.",
      category: "Waste Stats",
      icon: "🇺🇸",
    ),
    GreenFact(
      fact: "Plastic straws take up to 200 years to decompose.",
      category: "Decomposition",
      icon: "🥤",
    ),
    GreenFact(
      fact: "The carbon footprint of plastic is about 6kg CO2 per kg of plastic.",
      category: "Carbon Impact",
      icon: "🌡️",
    ),
  ];

  static GreenFact getRandomFact() {
    final randomIndex = DateTime.now().millisecond % facts.length;
    return facts[randomIndex];
  }

  static List<GreenFact> getFactsByCategory(String category) {
    return facts.where((fact) => fact.category == category).toList();
  }

  static List<String> getCategories() {
    return facts.map((fact) => fact.category).toSet().toList()..sort();
  }
}
