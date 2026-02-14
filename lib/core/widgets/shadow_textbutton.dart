import 'package:flutter/material.dart';

class ShadowTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color backgroundColor;
  final Color shadowColor;
  final Color? borderColor;
  final double borderWidth;
  final double? widht;

  const ShadowTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor = const Color(0xFF048973),
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.borderColor,
    this.borderWidth = 0,
    this.widht,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: widht,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),

        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth)
                  : BorderSide.none,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
