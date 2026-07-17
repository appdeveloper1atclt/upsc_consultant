class PtQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer; // 0-indexed correct option index
  final String explanation;
  final String difficulty;
  final String topic;
  bool bookmark;
  int? selectedOption; // null if unattempted
  bool isVisited;
  bool isMarkedReview;
  int timeSpent; // in seconds

  PtQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
    required this.topic,
    this.bookmark = false,
    this.selectedOption,
    this.isVisited = false,
    this.isMarkedReview = false,
    this.timeSpent = 0,
  });

  PtQuestion copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctAnswer,
    String? explanation,
    String? difficulty,
    String? topic,
    bool? bookmark,
    int? selectedOption,
    bool? isVisited,
    bool? isMarkedReview,
    int? timeSpent,
  }) {
    return PtQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      difficulty: difficulty ?? this.difficulty,
      topic: topic ?? this.topic,
      bookmark: bookmark ?? this.bookmark,
      selectedOption: selectedOption ?? this.selectedOption,
      isVisited: isVisited ?? this.isVisited,
      isMarkedReview: isMarkedReview ?? this.isMarkedReview,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }
}
