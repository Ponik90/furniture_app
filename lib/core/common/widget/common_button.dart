import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum ButtonVariant { primary, ghost, outline }

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  final ButtonVariant variant;
  final bool isLoading;

  final double? height;
  final double? width;

  final double borderRadius;
  final EdgeInsets? padding;

  final Color? backgroundColor;
  final Color? borderColor;

  // 🔥 Flexible Text Control
  final TextStyle? textStyle;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;

  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.height = 50,
    this.width,
    this.borderRadius = 8,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(borderRadius),
          border: _getBorder(),
        ),
        child: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(text, style: _buildTextStyle(context)),
      ),
    );
  }

  // 🎨 Background
  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case ButtonVariant.primary:
        return AppTheme.primaryColor;

      case ButtonVariant.ghost:
      case ButtonVariant.outline:
        return Colors.transparent;
    }
  }

  // 🔲 Border
  Border? _getBorder() {
    if (variant == ButtonVariant.outline) {
      return Border.all(color: borderColor ?? AppTheme.primaryColor);
    }
    return null;
  }

  // 🔤 FINAL TEXT STYLE
  TextStyle _buildTextStyle(BuildContext context) {
    final defaultStyle = _getDefaultTextStyle(context);

    if (textStyle != null) {
      return defaultStyle.merge(textStyle);
    }

    return defaultStyle.copyWith(
      color: textColor,
      fontSize: textSize,
      fontWeight: fontWeight,
    );
  }

  // 🧱 DEFAULT STYLE FROM THEME
  TextStyle _getDefaultTextStyle(BuildContext context) {
    final base = Theme.of(context).textTheme.labelLarge!;

    switch (variant) {
      case ButtonVariant.primary:
        return base.copyWith(
          color: AppTheme.surface, // usually white
        );

      case ButtonVariant.ghost:
      case ButtonVariant.outline:
        return base.copyWith(color: AppTheme.primaryColor);
    }
  }
}
