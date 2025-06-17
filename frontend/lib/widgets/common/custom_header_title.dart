import 'package:flutter/material.dart';
import 'package:frontend/utils/app_text_styles.dart';

import '../../utils/AppColors.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String text;

  const CustomHeaderTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.azulClaro,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        text,
        style: AppTextStyles.tituloHeader,
      ),
    );
  }
}
