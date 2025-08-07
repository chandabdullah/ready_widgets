import 'package:flutter/material.dart';
import 'ready_button_size.dart';

enum _ButtonStyleType { solid, outline, transparent }

class ReadyIconButton extends StatelessWidget {
  final IconData? iconData;
  final Widget? iconWidget;
  final VoidCallback? onPress;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? tooltip;
  final bool isRounded;
  final double? borderRadius;
  final double? iconSize;
  final Color? iconColor;
  final Color? color;
  final int? badge;
  final double? height;
  final double? width;
  final ReadyButtonSize size;
  final _ButtonStyleType _styleType;

  const ReadyIconButton({
    super.key,
    this.iconData,
    this.iconWidget,
    this.iconColor,
    this.onPress,
    this.backgroundColor,
    this.isRounded = false,
    this.color,
    this.tooltip,
    this.borderRadius,
    this.badge,
    this.height,
    this.iconSize,
    this.width,
    this.borderColor,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.transparent;

  const ReadyIconButton.solid({
    super.key,
    this.iconData,
    this.iconWidget,
    this.iconColor,
    this.onPress,
    this.backgroundColor,
    this.isRounded = false,
    this.color,
    this.tooltip,
    this.borderRadius,
    this.badge,
    this.height,
    this.iconSize,
    this.width,
    this.borderColor,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.solid;

  const ReadyIconButton.outlined({
    super.key,
    this.iconData,
    this.iconWidget,
    this.iconColor,
    this.onPress,
    this.backgroundColor,
    this.isRounded = true,
    this.color,
    this.tooltip,
    this.borderRadius,
    this.badge,
    this.height,
    this.iconSize,
    this.width,
    this.borderColor,
    this.size = ReadyButtonSize.medium,
  }) : _styleType = _ButtonStyleType.outline;

  double _getButtonSize() {
    switch (size) {
      case ReadyButtonSize.small:
        return 32;
      case ReadyButtonSize.medium:
        return 44;
      case ReadyButtonSize.large:
        return 56;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ReadyButtonSize.small:
        return 18;
      case ReadyButtonSize.medium:
        return 24;
      case ReadyButtonSize.large:
        return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double btnSize = _getButtonSize();

    final resolvedHeight = height ?? btnSize;
    final resolvedWidth = width ?? btnSize;
    final resolvedIconSize = iconSize ?? _getIconSize();
    final resolvedIconColor = iconColor ?? color ?? _resolveIconColor(theme);
    final resolvedBackgroundColor = _resolveBackgroundColor(theme);
    final resolvedBorderColor = _resolveBorderColor(theme);

    return Tooltip(
      message: tooltip ?? "",
      child: Material(
        color: Colors.transparent,
        shape: isRounded ? const CircleBorder() : null,
        child: InkWell(
          onTap: onPress,
          customBorder: isRounded ? const CircleBorder() : null,
          borderRadius:
              isRounded ? null : BorderRadius.circular(borderRadius ?? 12),
          splashColor: resolvedIconColor.withAlpha((0.1 * 255).toInt()),
          highlightColor: Colors.black.withAlpha((0.05 * 255).toInt()),
          child: Container(
            height: resolvedHeight,
            width: resolvedWidth,
            decoration: BoxDecoration(
              color: resolvedBackgroundColor,
              shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
              borderRadius:
                  isRounded ? null : BorderRadius.circular(borderRadius ?? 12),
              border: Border.all(color: resolvedBorderColor),
            ),
            alignment: Alignment.center,
            child: Badge(
              isLabelVisible: badge != null,
              label: badge != null ? Text(badge.toString()) : null,
              smallSize: 7,
              alignment: const AlignmentDirectional(1.1, -1),
              backgroundColor: Colors.red,
              textColor: Colors.white,
              child:
                  iconWidget ??
                  Icon(
                    iconData,
                    size: resolvedIconSize,
                    color: resolvedIconColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Color _resolveIconColor(ThemeData theme) {
    if (iconColor != null) return iconColor!;
    if (_styleType == _ButtonStyleType.solid) return Colors.white;
    return theme.primaryColor;
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
      return borderColor ?? color ?? theme.primaryColor;
    }
    return Colors.transparent;
  }
}

