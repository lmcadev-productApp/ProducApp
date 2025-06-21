import 'package:flutter/material.dart';
import 'package:frontend/utils/app_text_styles.dart';

Widget inputFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
  TextInputType tipoTeclado = TextInputType.text,
  bool isPassword = false,
  bool passwordVisible = false,
  VoidCallback? onTogglePassword,
  int maxLines = 1,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.inputLabel),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: tipoTeclado,
        obscureText: isPassword && !passwordVisible,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.inputHint,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
        ),
      ),
    ],
  );
}
