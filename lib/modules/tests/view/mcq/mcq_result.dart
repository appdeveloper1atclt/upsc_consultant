import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class McqResult extends StatelessWidget {
  final String topicName;
  final String subtopicName;
  final int correctCount;
  final int totalCount;

  const McqResult({
    super.key,
    required this.topicName,
    required this.subtopicName,
    required this.correctCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final double accuracy = (correctCount / totalCount) * 100;
    final int wrongCount = totalCount - correctCount;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Practice Result',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              const Spacer(),

              // Trophy/Score Ring Header
              _buildScoreRing(accuracy),
              const SizedBox(height: 32),

              // Title and motivation message
              Text(
                _getMotivationTitle(accuracy),
                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'You answered $correctCount out of $totalCount questions correctly.',
                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Stats Breakdown box
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCol('Accuracy', '${accuracy.toInt()}%', const Color(0xFF3B82F6)),
                    Container(width: 1, height: 40, color: const Color(0xFFEDF2F7)),
                    _buildStatCol('Correct', '$correctCount', const Color(0xFF10B981)),
                    Container(width: 1, height: 40, color: const Color(0xFFEDF2F7)),
                    _buildStatCol('Incorrect', '$wrongCount', const Color(0xFFEF4444)),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Done CTA button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Go back to McqHome
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back to MCQ Home', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRing(double accuracy) {
    Color ringCol = const Color(0xFF10B981); // Green
    IconData centerIcon = Icons.emoji_events_rounded;

    if (accuracy < 40) {
      ringCol = const Color(0xFFEF4444); // Red
      centerIcon = Icons.sentiment_dissatisfied_rounded;
    } else if (accuracy < 75) {
      ringCol = const Color(0xFFF59E0B); // Amber
      centerIcon = Icons.thumb_up_rounded;
    }

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringCol.withOpacity(0.15), width: 12),
      ),
      child: Center(
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: ringCol.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(centerIcon, color: ringCol, size: 50),
        ),
      ),
    );
  }

  Widget _buildStatCol(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  String _getMotivationTitle(double accuracy) {
    if (accuracy >= 80) return 'Excellent Work! 🏆';
    if (accuracy >= 60) return 'Good Effort! 👍';
    return 'Keep Practicing! 💪';
  }
}
