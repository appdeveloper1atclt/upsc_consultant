import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class TimerTextWidget extends StatefulWidget {
  final int time;

  const TimerTextWidget({super.key, required this.time});

  @override
  State<TimerTextWidget> createState() => _TimerTextWidgetState();
}

class _TimerTextWidgetState extends State<TimerTextWidget> with SingleTickerProviderStateMixin {
  AnimationController? _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _blinkController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final time = widget.time;
    final minutes = time ~/ 60;
    final seconds = time % 60;
    final timeStr = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    Color timerColor = AppColors.success;
    bool shouldBlink = false;

    if (time <= 30) {
      timerColor = AppColors.error;
      shouldBlink = true;
    } else if (time <= 120) {
      timerColor = AppColors.error;
    } else if (time <= 300) {
      timerColor = Colors.orange;
    }

    if (shouldBlink) {
      if (_blinkController != null && !_blinkController!.isAnimating) {
        _blinkController!.repeat(reverse: true);
      }
    } else {
      if (_blinkController != null && _blinkController!.isAnimating) {
        _blinkController!.stop();
      }
    }

    Widget timerText = Text(
      timeStr,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: timerColor,
        letterSpacing: 0.5,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, size: 18, color: timerColor),
        const SizedBox(width: 6),
        shouldBlink
            ? FadeTransition(
                opacity: _blinkController!,
                child: timerText,
              )
            : timerText,
      ],
    );
  }
}
