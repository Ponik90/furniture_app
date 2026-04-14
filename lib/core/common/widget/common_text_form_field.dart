import 'package:furniture_app/core/constant/app_imports.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;

  final bool obscureText;
  final TextInputType? keyboardType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final Color? fillColor;
  final bool isFilled;

  final double borderRadius;

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
    this.onFieldSubmitted,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.isFilled = true,
    this.borderRadius = 30, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style:
          textStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .w500),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            hintStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .w500),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: isFilled,
        fillColor: fillColor ?? AppTheme.greyLightColor,

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppTheme.error),
        ),
      ),
    );
  }
}
