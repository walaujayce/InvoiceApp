import 'package:flutter/material.dart';

class EmotionFace extends StatelessWidget {
  // 15:23
  final String emotionFace;
  const EmotionFace({
    super.key,
    required this.emotionFace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          emotionFace,
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}

