import 'package:aceate/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final String value, label;

  const ActivityItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
