import 'package:flutter/material.dart';

/// Position of the icon in the [ReadyElevatedButton]
enum IconPosition { leading, trailing }

/// A customizable elevated button with optional icon, image, and styles
class ReadyElevatedButton extends StatelessWidget {
  /// The text displayed on the button
  final String text;

  /// Callback when the button is pressed
  final VoidCallback? onPress;

  /// Text color
  final Color? textColor;

  /// Background color of the button
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Optional icon to display
  final IconData? icon;

  /// Font size of the text
  final double? fontSize;

  /// Font weight of the text
  final FontWeight? fontWeight;

  /// Width of the button
  final double? width;

  /// Whether the button is disabled
  final bool isDisabled;

  /// Corner radius of the button
  final double radius;

  /// Whether to show smaller size text and padding
  final bool isSmallText;

  /// Icon position relative to text
  final IconPosition iconPosition;

  /// Path to PNG image (optional alternative to icon)
  final String? pngImage;

  const ReadyElevatedButton({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.width,
    this.isDisabled = false,
    this.radius = 12,
    this.isSmallText = false,
    this.iconPosition = IconPosition.leading,
    this.pngImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBgColor = isDisabled
        ? theme.disabledColor
        : backgroundColor ?? theme.primaryColor;
    final effectiveTextColor = textColor ?? Colors.white;
    final padding = EdgeInsets.symmetric(vertical: isSmallText ? 10 : 14);

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          foregroundColor: effectiveTextColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPosition == IconPosition.leading) _buildIcon(),
            if (_hasIcon()) SizedBox(width: isSmallText ? 4 : 8),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize ?? (isSmallText ? 14 : 16),
                  fontWeight: fontWeight ?? FontWeight.w500,
                  color: effectiveTextColor,
                ),
              ),
            ),
            if (iconPosition == IconPosition.trailing) _buildIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return Icon(icon, size: 20, color: textColor ?? Colors.white);
    } else if (pngImage?.isNotEmpty ?? false) {
      return Image.asset(pngImage!, height: 18);
    } else {
      return const SizedBox();
    }
  }

  bool _hasIcon() {
    return icon != null || (pngImage?.isNotEmpty ?? false);
  }
}
