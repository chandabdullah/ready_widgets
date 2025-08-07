part of 'ready_buttons.dart';

/// Position of the icon in the [ReadyElevatedButton]

/// A customizable elevated button with optional icon and styles
class ReadyElevatedButton extends StatelessWidget {
  /// The text displayed on the button
  final String text;

  /// Callback when the button is pressed
  final VoidCallback? onPress;

  /// Text color (required if button is enabled)
  final Color? textColor;

  /// Background color of the button (required if button is enabled)
  final Color? backgroundColor;

  /// Border color (optional)
  final Color? borderColor;

  /// Optional icon to display
  final IconData? icon;

  /// Font size of the text
  final double fontSize;

  /// Font weight of the text
  final FontWeight fontWeight;

  /// Width of the button (ignored if [expanded] is true)
  final double? width;

  /// Whether the button is disabled
  final bool isDisabled;

  /// Corner border radius of the button
  final double borderRadius;

  /// Icon position relative to text
  final IconPosition iconPosition;

  /// Whether the button should take full available width
  final bool expanded;

  /// Alignment of the button within its parent
  final Alignment alignment;

  /// Custom padding (if not provided, defaults based on font size)
  final EdgeInsets? padding;

  /// Default constructor (same as large)
  const ReadyElevatedButton({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.width,
    this.isDisabled = false,
    this.borderRadius = 12,
    this.iconPosition = IconPosition.leading,
    this.expanded = false,
    this.alignment = Alignment.center,
    this.padding,
  });

  /// Small-sized button
  const ReadyElevatedButton.small({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.width,
    this.isDisabled = false,
    this.borderRadius = 12,
    this.iconPosition = IconPosition.leading,
    this.expanded = false,
    this.alignment = Alignment.center,
    this.padding,
  });

  /// Large-sized button
  const ReadyElevatedButton.large({
    super.key,
    required this.text,
    this.onPress,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w500,
    this.width,
    this.isDisabled = false,
    this.borderRadius = 12,
    this.iconPosition = IconPosition.leading,
    this.expanded = false,
    this.alignment = Alignment.center,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor;
    final effectiveTextColor = textColor;
    final effectiveBorderColor = borderColor ?? Colors.transparent;

    final effectivePadding =
        padding ??
        EdgeInsets.symmetric(
          vertical: fontSize <= 14 ? 10 : 14,
          horizontal: fontSize <= 14 ? 12 : 16,
        );

    return Align(
      alignment: alignment,
      child: SizedBox(
        width: expanded ? double.infinity : width,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveBgColor,
            foregroundColor: effectiveTextColor,
            padding: effectivePadding,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: effectiveBorderColor),
            ),
          ),
          child: _buildContent(effectiveTextColor),
        ),
      ),
    );
  }

  Widget _buildContent(Color? textColor) {
    final iconWidget = _buildIcon(textColor);
    final textWidget = Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );

    List<Widget> children = [];

    if (iconPosition == IconPosition.leading && _hasIcon()) {
      children = [
        iconWidget,
        SizedBox(width: fontSize <= 14 ? 4 : 8),
        textWidget,
      ];
    } else if (iconPosition == IconPosition.trailing && _hasIcon()) {
      children = [
        textWidget,
        SizedBox(width: fontSize <= 14 ? 4 : 8),
        iconWidget,
      ];
    } else {
      children = [textWidget];
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildIcon(Color? color) {
    if (icon != null) {
      return Icon(icon, size: 20, color: color);
    } else {
      return const SizedBox();
    }
  }

  bool _hasIcon() => icon != null;
}
