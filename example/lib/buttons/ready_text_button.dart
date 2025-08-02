import 'ready_icon_position.dart';
import 'package:flutter/material.dart';

/// Enum to define button size
enum ReadyButtonSize { small, medium, large }

/// A flexible, customizable text button for various use cases.
class ReadyTextButton extends StatelessWidget {
  /// The text to be displayed inside the button.
  final String text;

  /// Callback function triggered when the button is pressed.
  final VoidCallback? onPress;

  /// Color of the button text.
  final Color? textColor;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Color of the icon (if provided).
  final Color? iconColor;

  /// Border color of the button.
  final Color? borderColor;

  /// Optional icon to show alongside the text.
  final IconData? icon;

  /// Width of the button.
  final double? width;

  /// Height of the button.
  final double? height;

  /// Border radius of the button corners.
  final double borderRadius;

  /// Space between icon and text.
  final double? iconSpacing;

  /// Thickness of the button border.
  final double? borderWidth;

  /// Whether to show underline beneath the text.
  final bool showUnderline;

  /// Position of the icon relative to text.
  final IconPosition iconPosition;

  /// Alignment of the button within its parent.
  final Alignment alignment;

  /// Size of the button: small, medium, or large.
  final ReadyButtonSize size;

  /// Determines the style of button: solid, outline, or transparent.
  final _ButtonStyleType _styleType;

  const ReadyTextButton({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.icon,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.iconSpacing,
    this.borderWidth,
    this.showUnderline = false,
    this.iconPosition = IconPosition.trailing,
    this.alignment = Alignment.center,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.transparent;

  /// Creates a solid button with filled background
  const ReadyTextButton.solid({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.icon,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.iconSpacing,
    this.borderWidth,
    this.showUnderline = false,
    this.iconPosition = IconPosition.trailing,
    this.alignment = Alignment.center,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.solid;

  /// Creates an outlined button with transparent background and visible border
  const ReadyTextButton.outline({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.icon,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.iconSpacing,
    this.borderWidth,
    this.showUnderline = false,
    this.iconPosition = IconPosition.trailing,
    this.alignment = Alignment.center,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.outline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedTextColor = _resolveTextColor(theme);
    final resolvedIconColor = iconColor ?? resolvedTextColor;
    final resolvedBackground = _resolveBackgroundColor(theme);
    final resolvedBorder = _resolveBorderColor(theme);

    return Align(
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: height ?? _resolveHeight(),
        child: TextButton(
          onPressed: onPress,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(resolvedBackground),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  color: resolvedBorder,
                  width: borderWidth ?? 1,
                ),
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              resolvedTextColor.withOpacity(0.08),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          child: _buildContent(resolvedTextColor, resolvedIconColor),
        ),
      ),
    );
  }

  Widget _buildContent(Color textColor, Color iconColor) {
    final spacing = iconSpacing ?? (size == ReadyButtonSize.small ? 4 : 8);
    final iconWidget =
        icon != null
            ? Icon(icon, color: iconColor, size: _resolveIconSize())
            : const SizedBox.shrink();

    final textWidget = Text(
      text,
      style: TextStyle(
        fontSize: _resolveFontSize(),
        color: textColor,
        fontWeight: FontWeight.w500,
        decoration: showUnderline ? TextDecoration.underline : null,
        decorationColor: textColor,
        decorationThickness: 1.5,
      ),
    );

    List<Widget> children = [];
    if (iconPosition == IconPosition.leading && icon != null) {
      children = [iconWidget, SizedBox(width: spacing), textWidget];
    } else if (iconPosition == IconPosition.trailing && icon != null) {
      children = [textWidget, SizedBox(width: spacing), iconWidget];
    } else {
      children = [textWidget];
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double _resolveFontSize() {
    switch (size) {
      case ReadyButtonSize.small:
        return 13;
      case ReadyButtonSize.medium:
        return 15;
      case ReadyButtonSize.large:
        return 17;
    }
  }

  double _resolveHeight() {
    switch (size) {
      case ReadyButtonSize.small:
        return 36;
      case ReadyButtonSize.medium:
        return 48;
      case ReadyButtonSize.large:
        return 56;
    }
  }

  double _resolveIconSize() {
    switch (size) {
      case ReadyButtonSize.small:
        return 16;
      case ReadyButtonSize.medium:
        return 20;
      case ReadyButtonSize.large:
        return 24;
    }
  }

  Color _resolveTextColor(ThemeData theme) {
    if (textColor != null) return textColor!;
    if (_styleType == _ButtonStyleType.solid) return Colors.white;
    return theme.textTheme.bodyLarge?.color ?? Colors.black;
  }

  Color _resolveBackgroundColor(ThemeData theme) {
    if (_styleType == _ButtonStyleType.solid) {
      return backgroundColor ?? theme.primaryColor;
    } else {
      return backgroundColor ?? Colors.transparent;
    }
  }

  Color _resolveBorderColor(ThemeData theme) {
    if (_styleType == _ButtonStyleType.outline) {
      return borderColor ?? theme.primaryColor;
    }
    return borderColor ?? Colors.transparent;
  }
}

/// Internal enum to define style type.
enum _ButtonStyleType { solid, outline, transparent }
