import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum ButtonVariant {
  primary,
  ghost,
  outline,
}

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  final ButtonVariant variant;
  final bool isLoading;

  final double? height;
  final double? width;

  final double borderRadius;
  final EdgeInsets? padding;

  final TextStyle? textStyle;
  final Color? textColor;

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
    this.textStyle,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null || isLoading;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _bgColor(isDisabled),
          borderRadius: BorderRadius.circular(borderRadius),
          border: _border(isDisabled),
        ),
        child: isLoading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : Text(
          text,
          style: _textStyle(context, isDisabled),
        ),
      ),
    );
  }

  Color _bgColor(bool isDisabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return isDisabled ? Colors.grey : AppTheme.primary;
      case ButtonVariant.ghost:
      case ButtonVariant.outline:
        return Colors.transparent;
    }
  }

  Border? _border(bool isDisabled) {
    if (variant == ButtonVariant.outline) {
      return Border.all(
        color: isDisabled ? Colors.grey : AppTheme.primary,
      );
    }
    return null;
  }

  TextStyle _textStyle(BuildContext context, bool isDisabled) {
    final base = Theme.of(context).textTheme.labelLarge!;

    if (textStyle != null) return base.merge(textStyle);

    switch (variant) {
      case ButtonVariant.primary:
        return base.copyWith(
          color: textColor ?? Colors.white,
        );

      case ButtonVariant.ghost:
      case ButtonVariant.outline:
        return base.copyWith(
          color: textColor ??
              (isDisabled ? Colors.grey : AppTheme.primary),
        );
    }
  }
}