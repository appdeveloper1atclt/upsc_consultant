import '../models/daily_challenge.dart';
import '../models/pt_question.dart';

class PtChallengeRepository {
  // Static database of Daily Challenges
  final List<DailyChallenge> _challenges = [
    DailyChallenge(
      id: 'today_polity',
      title: 'Indian Polity',
      topic: 'Indian Polity',
      difficulty: 'Medium',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now(),
    ),
    DailyChallenge(
      id: 'economy_1',
      title: 'Indian Economy',
      topic: 'Indian Economy',
      difficulty: 'Hard',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DailyChallenge(
      id: 'geo_1',
      title: 'Geography',
      topic: 'Geography',
      difficulty: 'Medium',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    DailyChallenge(
      id: 'hist_1',
      title: 'History',
      topic: 'History',
      difficulty: 'Hard',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
    DailyChallenge(
      id: 'env_1',
      title: 'Environment',
      topic: 'Environment',
      difficulty: 'Easy',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
    DailyChallenge(
      id: 'sci_1',
      title: 'Science & Tech',
      topic: 'Science & Tech',
      difficulty: 'Medium',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    DailyChallenge(
      id: 'curr_1',
      title: 'Current Affairs',
      topic: 'Current Affairs',
      difficulty: 'Medium',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 6)),
    ),
    DailyChallenge(
      id: 'ir_1',
      title: 'International Relations',
      topic: 'International Relations',
      difficulty: 'Hard',
      duration: 20,
      totalQuestions: 20,
      totalMarks: 80,
      availableDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  // Leaders list for the Daily Challenge
  final List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'name': 'Rahul Sharma', 'score': 95, 'time': '14m 20s', 'isCurrentUser': false},
    {'rank': 2, 'name': 'Ankit Verma', 'score': 94, 'time': '15m 10s', 'isCurrentUser': false},
    {'rank': 3, 'name': 'Shivam Mishra', 'score': 94, 'time': '16m 02s', 'isCurrentUser': false},
    {'rank': 4, 'name': 'Aditi Rao', 'score': 92, 'time': '13m 45s', 'isCurrentUser': false},
    {'rank': 5, 'name': 'Vikram Singh', 'score': 90, 'time': '17m 18s', 'isCurrentUser': false},
  ];

  List<DailyChallenge> getChallenges() {
    return _challenges;
  }

  DailyChallenge? getTodayChallenge() {
    return _challenges.firstWhere((c) => c.id == 'today_polity');
  }

  // Fetch mock questions for a specific topic
  List<PtQuestion> getQuestionsForTopic(String topic) {
    // Return mock questions based on the topic. We'll populate Polity with 20 questions, and others with 5.
    if (topic == 'Indian Polity') {
      return List.generate(20, (index) {
        final qNum = index + 1;
        return PtQuestion(
          id: 'polity_$qNum',
          question: _polityQuestions[index % _polityQuestions.length]['question'] as String,
          options: List<String>.from(_polityQuestions[index % _polityQuestions.length]['options'] as List),
          correctAnswer: _polityQuestions[index % _polityQuestions.length]['correctAnswer'] as int,
          explanation: _polityQuestions[index % _polityQuestions.length]['explanation'] as String,
          difficulty: index % 3 == 0 ? 'Easy' : (index % 3 == 1 ? 'Medium' : 'Hard'),
          topic: 'Indian Polity',
        );
      });
    } else {
      // General fallbacks for other topics
      final questionsList = _otherTopicsQuestions[topic] ?? _polityQuestions;
      return List.generate(20, (index) {
        final qNum = index + 1;
        final data = questionsList[index % questionsList.length];
        return PtQuestion(
          id: '${topic.toLowerCase().replaceAll(' ', '_')}_$qNum',
          question: data['question'] as String,
          options: List<String>.from(data['options'] as List),
          correctAnswer: data['correctAnswer'] as int,
          explanation: data['explanation'] as String,
          difficulty: index % 3 == 0 ? 'Easy' : (index % 3 == 1 ? 'Medium' : 'Hard'),
          topic: topic,
        );
      });
    }
  }

  // ── Polity Mock Database ──────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _polityQuestions = [
    {
      'question': 'Q1. Which of the following is not a Fundamental Right under the Indian Constitution?',
      'options': [
        'A. Right to Equality',
        'B. Right to Freedom',
        'C. Right against Exploitation',
        'D. Right to Property'
      ],
      'correctAnswer': 3,
      'explanation': 'The Right to Property was deleted from the list of Fundamental Rights by the 44th Amendment Act, 1978. It is now made a legal right under Article 300-A in Part XII of the Constitution.',
    },
    {
      'question': 'Q2. The concept of \'Directive Principles of State Policy\' in the Indian Constitution is borrowed from which country?',
      'options': [
        'A. Ireland',
        'B. USA',
        'C. Australia',
        'D. USSR'
      ],
      'correctAnswer': 0,
      'explanation': 'The Directive Principles of State Policy are borrowed from the Irish Constitution of 1937, which had copied it from the Spanish Constitution.',
    },
    {
      'question': 'Q3. Who is considered the guardian of the Indian Constitution?',
      'options': [
        'A. The President of India',
        'B. The Parliament of India',
        'C. The Supreme Court of India',
        'D. The Prime Minister of India'
      ],
      'correctAnswer': 2,
      'explanation': 'The Supreme Court of India is the ultimate interpreter and guardian of the Constitution. It protects the fundamental rights of citizens and maintains the federal structure.',
    },
    {
      'question': 'Q4. The joint sitting of both Houses of Parliament is presided over by the:',
      'options': [
        'A. President of India',
        'B. Speaker of Lok Sabha',
        'C. Chairman of Rajya Sabha',
        'D. Prime Minister'
      ],
      'correctAnswer': 1,
      'explanation': 'According to Article 118 of the Constitution, the joint sitting of both Houses of Parliament is presided over by the Speaker of Lok Sabha, or in their absence, the Deputy Speaker of Lok Sabha.',
    },
    {
      'question': 'Q5. Which Article of the Indian Constitution deals with the amendment procedure of the Constitution?',
      'options': [
        'A. Article 356',
        'B. Article 360',
        'C. Article 368',
        'D. Article 370'
      ],
      'correctAnswer': 2,
      'explanation': 'Article 368 in Part XX of the Constitution deals with the powers of Parliament to amend the Constitution and its procedure.',
    },
    {
      'question': 'Q6. Under the Indian Constitution, the power to issue a writ of Habeas Corpus is vested in:',
      'options': [
        'A. Only the Supreme Court',
        'B. Only the High Courts',
        'C. Both the Supreme Court and High Courts',
        'D. Subordinate Courts'
      ],
      'correctAnswer': 2,
      'explanation': 'Article 32 empowers the Supreme Court and Article 226 empowers High Courts to issue writs including Habeas Corpus, Mandamus, Prohibition, Certiorari, and Quo-Warranto.',
    },
    {
      'question': 'Q7. Which of the following constitutional amendments is known as the \'Mini Constitution\'?',
      'options': [
        'A. 42nd Amendment Act',
        'B. 44th Amendment Act',
        'C. 73rd Amendment Act',
        'D. 86th Amendment Act'
      ],
      'correctAnswer': 0,
      'explanation': 'The 42nd Amendment Act of 1976 is called the Mini Constitution because of the massive and sweeping changes it made to a large number of provisions in the Constitution.',
    },
    {
      'question': 'Q8. The Sarkaria Commission was set up to review which of the following relations?',
      'options': [
        'A. Inter-State disputes',
        'B. Centre-State relations',
        'C. Legislative-Executive relations',
        'D. Separation of Powers'
      ],
      'correctAnswer': 1,
      'explanation': 'Sarkaria Commission was set up in 1983 by the Central government of India to examine the relationship and balance of power between state and central governments (Centre-State relations).',
    },
    {
      'question': 'Q9. Who appoints the Comptroller and Auditor General (CAG) of India?',
      'options': [
        'A. The Prime Minister',
        'B. The President of India',
        'C. The Finance Minister',
        'D. Chief Justice of India'
      ],
      'correctAnswer': 1,
      'explanation': 'The Comptroller and Auditor General (CAG) of India is appointed by the President of India by warrant under his hand and seal, according to Article 148.',
    },
    {
      'question': 'Q10. How many members are nominated to the Rajya Sabha by the President of India?',
      'options': [
        'A. 2 members',
        'B. 10 members',
        'C. 12 members',
        'D. 15 members'
      ],
      'correctAnswer': 2,
      'explanation': 'Under Article 80, the President nominates 12 members to the Rajya Sabha who have special knowledge or practical experience in literature, science, art, and social service.',
    },
  ];

  // ── Other Topics Mock Database ─────────────────────────────────────────────
  static const Map<String, List<Map<String, dynamic>>> _otherTopicsQuestions = {
    'Indian Economy': [
      {
        'question': 'Q1. Which body compiles the National Income estimates in India?',
        'options': [
          'A. NITI Aayog',
          'B. National Statistical Office (NSO)',
          'C. Reserve Bank of India',
          'D. Finance Ministry'
        ],
        'correctAnswer': 1,
        'explanation': 'The National Income estimates in India are compiled by the National Statistical Office (NSO), under the Ministry of Statistics and Programme Implementation.',
      },
      {
        'question': 'Q2. What type of unemployment is most common in the agricultural sector of India?',
        'options': [
          'A. Structural Unemployment',
          'B. Frictional Unemployment',
          'C. Disguised Unemployment',
          'D. Open Unemployment'
        ],
        'correctAnswer': 2,
        'explanation': 'Disguised unemployment is a phenomenon where more people are employed in an activity than actually needed. This is highly prevalent in Indian agriculture.',
      },
      {
        'question': 'Q3. Who regulates the monetary policy in India?',
        'options': [
          'A. Reserve Bank of India (RBI)',
          'B. Finance Commission',
          'C. SEBI',
          'D. Ministry of Finance'
        ],
        'correctAnswer': 0,
        'explanation': 'The Reserve Bank of India (RBI) is responsible for monetary policy formulation and implementation under the RBI Act, 1934.',
      },
    ],
    'Geography': [
      {
        'question': 'Q1. Which of the following rivers is known as the \'Sorrow of Bengal\'?',
        'options': [
          'A. Damodar River',
          'B. Kosi River',
          'C. Hooghly River',
          'D. Gandak River'
        ],
        'correctAnswer': 0,
        'explanation': 'The Damodar River was historically known as the \'Sorrow of Bengal\' due to its devastating floods in the plains of Bengal.',
      },
      {
        'question': 'Q2. The standard meridian of India (82°30\' E) passes through which of the following states?',
        'options': [
          'A. Uttar Pradesh, Madhya Pradesh, Chhattisgarh, Odisha, Andhra Pradesh',
          'B. Uttar Pradesh, Bihar, Jharkhand, West Bengal',
          'C. Gujarat, Rajasthan, Madhya Pradesh, Chhattisgarh',
          'D. Maharashtra, Telangana, Andhra Pradesh, Tamil Nadu'
        ],
        'correctAnswer': 0,
        'explanation': 'The Standard Meridian of India passes through 5 states: Uttar Pradesh, Madhya Pradesh, Chhattisgarh, Odisha, and Andhra Pradesh.',
      },
    ],
    'History': [
      {
        'question': 'Q1. The famous Harappan site of Lothal is located in which modern state of India?',
        'options': [
          'A. Rajasthan',
          'B. Punjab',
          'C. Gujarat',
          'D. Haryana'
        ],
        'correctAnswer': 2,
        'explanation': 'Lothal, the ancient port city of the Indus Valley Civilization, is located in the Saragwala village in Dholka Taluka of Ahmedabad district in Gujarat.',
      },
    ],
  };
}
