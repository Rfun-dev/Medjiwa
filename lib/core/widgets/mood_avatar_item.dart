import 'package:aceate/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../utils/mood_enum.dart';

class MoodAvatarItem extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodAvatarItem({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  String get emoji {
    switch (mood) {
      case Mood.senang:
        return 'assets/ic_senang.png';
      case Mood.kecewa:
        return 'assets/ic_kecewa.png';
      case Mood.netral:
        return 'assets/ic_netral.png';
      case Mood.marah:
        return 'assets/ic_marah.png';
      case Mood.sedih:
        return 'assets/ic_sedih.png';
    }
  }

  String get label {
    switch (mood) {
      case Mood.senang:
        return 'Senang';
      case Mood.kecewa:
        return 'Kecewa';
      case Mood.netral:
        return 'Netral';
      case Mood.marah:
        return 'Marah';
      case Mood.sedih:
        return 'Sedih';
    }
  }

  Color get color {
    switch (mood) {
      case Mood.senang:
        return const Color(0xFFE46B73);
      case Mood.kecewa:
        return const Color(0xFF5FA876);
      case Mood.netral:
        return const Color(0xFFFBBD4A);
      case Mood.marah:
        return const Color(0xFFE66B6B);
      case Mood.sedih:
        return const Color(0xFF6B9FE6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.8),
                          blurRadius: 8,
                          spreadRadius: 4,
                        ),
                      ]
                    : null,
              ),
              child: Image.asset(
                emoji,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
