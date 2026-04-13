import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  final bool obscureText;
  final TextInputType? keyboardType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final TextStyle? textStyle;

  const CommonTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: textStyle ?? Theme.of(context).textTheme.bodyLarge,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: AppTheme.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
      ),
    );
  }
}