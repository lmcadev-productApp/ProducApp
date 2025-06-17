import 'package:flutter/material.dart';
import 'package:frontend/utils/AppColors.dart';


void showCustomSnackBar(
    BuildContext context,
    String message, {
      Color backgroundColor = AppColors.azulClaroFondo,
      int durationInSeconds = 2,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.azulLogoPrincipal,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 80,
      ),
      elevation: 8,
    ),
  );
}

