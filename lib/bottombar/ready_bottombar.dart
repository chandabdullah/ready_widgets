import 'package:flutter/material.dart';

class ReadyBottomBar extends StatelessWidget {
  /// A single widget to show inside the bottom bar.
  final Widget? child;

  /// Multiple widgets to show inside the bottom bar.
  final List<Widget>? children;

  /// Padding around the content.
  final EdgeInsetsGeometry padding;

  /// Background color of the bottom bar.
  final Color? backgroundColor;

  /// Whether to display a top border.
  final bool showTopBorder;

  /// Color of the top border (if visible).
  final Color? borderColor;

  /// Width of the top border.
  final double borderWidth;

  /// Border radius around the container.
  final BorderRadiusGeometry? borderRadius;

  /// Elevation for shadow effect.
  final double elevation;

  const ReadyBottomBar({
    super.key,
    this.child,
    this.children,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.showTopBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final contentWidgets =
        children ?? (child != null ? [child!] : [const SizedBox.shrink()]);

    return Material(
      color: backgroundColor ?? theme.cardColor,
      elevation: elevation,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.cardColor,
          borderRadius: borderRadius,
          border:
              showTopBorder
                  ? Border(
                    top: BorderSide(
                      color: borderColor ?? theme.dividerColor,
                      width: borderWidth,
                    ),
                  )
                  : null,
        ),
        padding: padding,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: contentWidgets,
          ),
        ),
      ),
    );
  }
}
