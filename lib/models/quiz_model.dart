class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class QuizData {
  static final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "What percentage of plastic waste is actually recycled globally?",
      options: ["9%", "25%", "50%", "75%"],
      correctIndex: 0,
      explanation: "Only about 9% of plastic waste ever produced has been recycled. Most ends up in landfills or the environment.",
    ),
    QuizQuestion(
      question: "Which type of plastic is most commonly recycled?",
      options: ["PVC (#3)", "PET (#1)", "PS (#6)", "PP (#5)"],
      correctIndex: 1,
      explanation: "PET (Polyethylene Terephthalate) bottles are the most commonly recycled plastics worldwide.",
    ),
    QuizQuestion(
      question: "How long does it take for a plastic bottle to decompose?",
      options: ["10 years", "50 years", "100 years", "450+ years"],
      correctIndex: 3,
      explanation: "Plastic bottles can take 450 years or more to decompose in the environment.",
    ),
    QuizQuestion(
      question: "What is the Great Pacific Garbage Patch?",
      options: [
        "A recycling facility",
        "A massive collection of marine debris",
        "An island made of plastic",
        "A conservation area"
      ],
      correctIndex: 1,
      explanation: "The Great Pacific Garbage Patch is a massive collection of marine debris in the North Pacific Ocean.",
    ),
    QuizQuestion(
      question: "Which country produces the most plastic waste per capita?",
      options: ["China", "India", "United States", "Indonesia"],
      correctIndex: 2,
      explanation: "The United States produces the most plastic waste per capita, despite having advanced recycling infrastructure.",
    ),
    QuizQuestion(
      question: "What does the recycling symbol number on plastic indicate?",
      options: [
        "Quality rating",
        "Type of plastic resin",
        "Times it can be recycled",
        "Manufacturing date"
      ],
      correctIndex: 1,
      explanation: "The number indicates the type of plastic resin used, helping recyclers sort materials properly.",
    ),
    QuizQuestion(
      question: "How much plastic enters the ocean every year?",
      options: ["1 million tons", "8 million tons", "20 million tons", "50 million tons"],
      correctIndex: 1,
      explanation: "Approximately 8 million metric tons of plastic waste enters the ocean annually.",
    ),
    QuizQuestion(
      question: "What is 'microplastic'?",
      options: [
        "Recyclable plastic",
        "Plastic pieces smaller than 5mm",
        "Biodegradable plastic",
        "Compressed plastic waste"
      ],
      correctIndex: 1,
      explanation: "Microplastics are tiny plastic particles less than 5mm in size that pollute our environment.",
    ),
    QuizQuestion(
      question: "Which everyday item releases the most microplastics?",
      options: ["Plastic bags", "Water bottles", "Synthetic clothing", "Food packaging"],
      correctIndex: 2,
      explanation: "Washing synthetic clothing releases millions of microplastic fibers into water systems.",
    ),
    QuizQuestion(
      question: "What is the most effective way to reduce plastic pollution?",
      options: [
        "Recycling more",
        "Using biodegradable plastics",
        "Reducing single-use plastics",
        "Ocean cleanup"
      ],
      correctIndex: 2,
      explanation: "Reducing single-use plastic consumption is the most effective way to combat plastic pollution at its source.",
    ),
  ];
}
