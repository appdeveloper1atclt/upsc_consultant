class DailyChallenge {
  final String id;
  final String title;
  final String topic;
  final String difficulty;
  final int duration; // in minutes
  final int totalQuestions;
  final int totalMarks;
  final DateTime availableDate;
  bool attempted;
  double progress; // 0.0 to 1.0 (for resuming)
  int? lastScore;
  double? lastAccuracy;
  String? lastTimeTaken;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.topic,
    required this.difficulty,
    required this.duration,
    required this.totalQuestions,
    required this.totalMarks,
    required this.availableDate,
    this.attempted = false,
    this.progress = 0.0,
    this.lastScore,
    this.lastAccuracy,
    this.lastTimeTaken,
  });
}
