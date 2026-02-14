import 'package:aceate/core/theme/app_colors.dart';
import 'package:aceate/core/widgets/shadow_textbutton.dart';
import 'package:flutter/material.dart';
import '../utils/mood_enum.dart';

class MoodResponseCard extends StatelessWidget {
  final Mood mood;

  const MoodResponseCard({super.key, required this.mood});

  String get title {
    switch (mood) {
      case Mood.senang:
        return 'Senang mendengarnya!';
      case Mood.kecewa:
        return 'Hari ini terasa berat ya?';
      case Mood.netral:
        return 'Hariini terasa biasa?';
      case Mood.marah:
        return 'Seperti ada yang mengganggu';
      case Mood.sedih:
        return 'Aku selalu disini untukmu';
    }
  }

  String get subtitle {
    switch (mood) {
      case Mood.senang:
        return 'Mau berbagi momen baikmu?';
      case Mood.kecewa:
        return 'Mau cerita sedikit?';
      case Mood.netral:
        return 'Ada yang ingin diceritakan?';
      case Mood.marah:
        return 'Mau cerita apa yang terjadi';
      case Mood.sedih:
        return 'Mau berbagi hal berat itu?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.background,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(color: AppColors.background, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShadowTextButton(
                widht: 170,
                text: 'Ceritakan Sekarang',
                textColor: AppColors.primary,
                backgroundColor: Colors.white,
                shadowColor: AppColors.primary,
                onPressed: () {},
              ),
              const SizedBox(width: 4),
              ShadowTextButton(
                widht: 170,
                text: 'Nanti aja',
                textColor: AppColors.background,
                borderColor: AppColors.background,
                backgroundColor: AppColors.primary,
                borderWidth: 1,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
