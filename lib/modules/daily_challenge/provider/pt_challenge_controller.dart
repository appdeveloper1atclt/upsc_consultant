import 'dart:async';
import 'package:flutter/material.dart';
import '../models/daily_challenge.dart';
import '../models/pt_question.dart';
import '../repository/pt_challenge_repository.dart';

class ConsultationSession {
  final String id;
  final String mentorName;
  final String topic;
  final String dateTime;
  final bool isCompleted;

  ConsultationSession({required this.id, required this.mentorName, required this.topic, required this.dateTime, this.isCompleted = false});
}

class PtChallengeController extends ChangeNotifier {
  final PtChallengeRepository _repository = PtChallengeRepository();

  DailyChallenge? _currentChallenge;
  List<PtQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _remainingTime = 0; // in seconds
  Timer? _timer;
  bool _isSubmitting = false;

  // Streak & attempts (Mock user profile data in controller)
  int currentStreak = 18;
  int dailyAspirants = 2438;

  // Journey state details
  String userName = 'Abhishek Jha';
  String targetExam = 'UPSC CSE';
  String targetAttempt = '2027';
  double studyHours = 6.0;

  List<ConsultationSession> consultations = [
    ConsultationSession(id: '1', mentorName: 'Dr. Tanvi Sharma', topic: 'Syllabus & Optional Prep Strategy', dateTime: 'Tomorrow, 5:00 PM', isCompleted: false),
    ConsultationSession(
      id: '2',
      mentorName: 'Sanjay Kumar (IAS Retd.)',
      topic: 'Ethics GS-4 Mock Evaluation',
      dateTime: '12th July, 3:00 PM',
      isCompleted: true,
    ),
    ConsultationSession(
      id: '3',
      mentorName: 'Aarti Dogra (IAS)',
      topic: 'Syllabus Micro-timelining Session',
      dateTime: '05th July, 11:00 AM',
      isCompleted: true,
    ),
  ];

  void updateJourney({required String name, required String exam, required String attempt, required double hours}) {
    userName = name;
    targetExam = exam;
    targetAttempt = attempt;
    studyHours = hours;
    notifyListeners();
  }

  // Session Results
  int score = 0;
  int rank = 243;
  double accuracy = 0.0;
  int correctCount = 0;
  int wrongCount = 0;
  int skippedCount = 0;
  String timeTakenString = "00:00";
  String avgTimePerQuestionString = "0s";

  // Topic wise performance (mock)
  final Map<String, double> topicScores = {'Polity': 0.80, 'Economy': 0.45, 'History': 1.00, 'Geography': 0.60};
  final List<String> weakTopics = ['Economy', 'Geography'];
  final List<String> aiRecommendations = ['Parliament', 'Fundamental Rights (FR)', 'Directive Principles (DPSP)', 'Union Budget & Fiscal Policy'];

  // Getters
  DailyChallenge? get currentChallenge => _currentChallenge;
  List<PtQuestion> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get remainingTime => _remainingTime;
  bool get isSubmitting => _isSubmitting;
  PtQuestion? get currentQuestion => _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

  // Get challenges from repository
  List<DailyChallenge> getChallenges() => _repository.getChallenges();

  DailyChallenge? getTodayChallenge() {
    final today = _repository.getTodayChallenge();
    // Update it if it exists in local state
    if (today != null && _currentChallenge != null && _currentChallenge!.id == today.id) {
      return _currentChallenge;
    }
    return today;
  }

  // ── Operations ────────────────────────────────────────────────────────────

  List<PtQuestion> _getCustomQuestions(String topic, int count) {
    final baseQuestions = _repository.getQuestionsForTopic(topic);
    if (baseQuestions.isEmpty) return [];

    return List.generate(count, (index) {
      final baseQ = baseQuestions[index % baseQuestions.length];
      final qNum = index + 1;
      return PtQuestion(
        id: '${baseQ.id}_custom_$qNum',
        question: 'Q$qNum. ${baseQ.question.replaceFirst(RegExp(r'^Q\d+\.\s*'), '')}',
        options: baseQ.options,
        correctAnswer: baseQ.correctAnswer,
        explanation: baseQ.explanation,
        difficulty: baseQ.difficulty,
        topic: topic,
      );
    });
  }

  void startChallenge(
    DailyChallenge challenge, {
    String? customTopic,
    int? customQuestionsCount,
    int? customDurationMinutes,
  }) {
    // If it's already attempted, we just view results
    if (challenge.attempted) return;

    final selectedTopic = customTopic ?? challenge.topic;
    final questionsCount = customQuestionsCount ?? challenge.totalQuestions;
    final durationMinutes = customDurationMinutes ?? challenge.duration;

    // Reset/Setup state
    _questions = _getCustomQuestions(selectedTopic, questionsCount);
    _currentQuestionIndex = 0;
    _remainingTime = durationMinutes * 60;
    _isSubmitting = false;

    _currentChallenge = DailyChallenge(
      id: challenge.id,
      title: challenge.title,
      topic: selectedTopic,
      difficulty: challenge.difficulty,
      duration: durationMinutes,
      totalQuestions: questionsCount,
      totalMarks: questionsCount * 4,
      availableDate: challenge.availableDate,
      attempted: challenge.attempted,
      progress: challenge.progress,
      lastScore: challenge.lastScore,
      lastAccuracy: challenge.lastAccuracy,
      lastTimeTaken: challenge.lastTimeTaken,
    );

    // Mark first question as visited & current
    if (_questions.isNotEmpty) {
      _questions[0].isVisited = true;
    }

    _startTimer();
    notifyListeners();
  }

  void resumeChallenge() {
    if (_currentChallenge == null) return;
    _startTimer();
    notifyListeners();
  }

  void pauseChallenge() {
    _timer?.cancel();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        // Update time spent on the current question
        if (_questions.isNotEmpty) {
          _questions[_currentQuestionIndex].timeSpent++;
        }

        // Notify listeners every second so timer ticks in UI
        notifyListeners();

        // Check for auto-submit
        if (_remainingTime == 0) {
          autoSubmit();
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  void selectQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      _questions[_currentQuestionIndex].isVisited = true;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _questions[_currentQuestionIndex].isVisited = true;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _questions[_currentQuestionIndex].isVisited = true;
      notifyListeners();
    }
  }

  void selectOption(int optionIndex) {
    if (_questions.isNotEmpty) {
      _questions[_currentQuestionIndex].selectedOption = optionIndex;
      notifyListeners();
    }
  }

  void clearAnswer() {
    if (_questions.isNotEmpty) {
      _questions[_currentQuestionIndex].selectedOption = null;
      notifyListeners();
    }
  }

  void toggleMarkForReview() {
    if (_questions.isNotEmpty) {
      _questions[_currentQuestionIndex].isMarkedReview = !_questions[_currentQuestionIndex].isMarkedReview;
      notifyListeners();
    }
  }

  void toggleBookmark(int index) {
    if (index >= 0 && index < _questions.length) {
      _questions[index].bookmark = !_questions[index].bookmark;
      notifyListeners();
    }
  }

  // Submit and calculate results
  void submitChallenge() {
    _timer?.cancel();
    _isSubmitting = true;

    // Calculations
    correctCount = 0;
    wrongCount = 0;
    skippedCount = 0;
    int totalTimeSpent = 0;

    for (var q in _questions) {
      totalTimeSpent += q.timeSpent;
      if (q.selectedOption == null) {
        skippedCount++;
      } else if (q.selectedOption == q.correctAnswer) {
        correctCount++;
      } else {
        wrongCount++;
      }
    }

    // UPSC marking: +4 for correct, -1 for incorrect, 0 for skipped
    score = (correctCount * 4) - (wrongCount * 1);

    // Percentages & details
    int attempted = correctCount + wrongCount;
    accuracy = attempted > 0 ? (correctCount / attempted) * 100 : 0.0;

    int mins = totalTimeSpent ~/ 60;
    int secs = totalTimeSpent % 60;
    timeTakenString = "${mins}m ${secs.toString().padLeft(2, '0')}s";

    double avgTime = attempted > 0 ? totalTimeSpent / attempted : 0;
    avgTimePerQuestionString = "${avgTime.toStringAsFixed(1)}s";

    // Set challenge as completed
    if (_currentChallenge != null) {
      _currentChallenge!.attempted = true;
      _currentChallenge!.progress = 1.0;
      _currentChallenge!.lastScore = score;
      _currentChallenge!.lastAccuracy = accuracy;
      _currentChallenge!.lastTimeTaken = timeTakenString;
    }

    // Increase streak by 1 if not attempted before
    currentStreak++;

    _isSubmitting = false;
    notifyListeners();
  }

  void autoSubmit() {
    submitChallenge();
  }

  // Get bookmarked questions from the quiz
  List<PtQuestion> getBookmarkedQuestions() {
    return _questions.where((q) => q.bookmark).toList();
  }

  // Dev method to reset state for testing retakes
  void resetState(DailyChallenge challenge) {
    challenge.attempted = false;
    challenge.progress = 0.0;
    challenge.lastScore = null;
    challenge.lastAccuracy = null;
    challenge.lastTimeTaken = null;

    startChallenge(challenge);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
