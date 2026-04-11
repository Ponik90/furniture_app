import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum IconButtonVariant {
  filled,
  outline,
  ghost,
}

class CommonIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  final IconButtonVariant variant;
  final bool isLoading;

  final double size;
  final double iconSize;

  const CommonIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.variant = IconButtonVariant.filled,
    this.isLoading = false,
    this.size = 48,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null || isLoading;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _bgColor(isDisabled),
          borderRadius: BorderRadius.circular(10),
          border: _border(isDisabled),
        ),
        child: isLoading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : IconTheme(
          data: IconThemeData(
            size: iconSize,
            color: _iconColor(isDisabled),
          ),
          child: icon,
        ),
      ),
    );
  }

  Color _bgColor(bool isDisabled) {
    switch (variant) {
      case IconButtonVariant.filled:
        return isDisabled ? Colors.grey : AppTheme.primaryColor;
      case IconButtonVariant.ghost:
      case IconButtonVariant.outline:
        return Colors.transparent;
    }
  }

  Border? _border(bool isDisabled) {
    if (variant == IconButtonVariant.outline) {
      return Border.all(
        color: isDisabled ? Colors.grey : AppTheme.primaryColor,
      );
    }
    return null;
  }

  Color _iconColor(bool isDisabled) {
    switch (variant) {
      case IconButtonVariant.filled:
        return Colors.white;
      case IconButtonVariant.ghost:
      case IconButtonVariant.outline:
        return isDisabled ? Colors.grey : AppTheme.primaryColor;
    }
  }
}