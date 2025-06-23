import 'package:flutter/material.dart';
import 'package:frontend/utils/AppColors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;   //  👈  ahora puede ser null
  final bool isEnabled;
  final double fontSize;
  final FontWeight fontWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w700,
    this.verticalPadding = 14,
    this.horizontalPadding = 32,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,   //  👈  Flutter aceptará null
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.azulIntermedio)
              : AppColors.grisClaro,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: Colors.black45,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
