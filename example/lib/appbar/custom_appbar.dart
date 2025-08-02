import 'package:flutter/material.dart';

/// A customizable AppBar widget that allows for both simple and complex title setups,
/// optional subtitle, and flexible customization options.
class ReadyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The primary title text to display if [titleWidget] is not provided.
  final String? titleText;

  /// A custom widget to use as the AppBar title instead of [titleText] and [subtitle].
  final Widget? titleWidget;

  /// Optional subtitle text displayed below the [titleText].
  final String? subtitle;

  /// A widget to display before the title, typically an [IconButton].
  final Widget? leading;

  /// Widgets displayed after the title, typically action buttons.
  final List<Widget>? actions;

  /// Whether to center the title horizontally within the AppBar.
  final bool centerTitle;

  /// The z-coordinate at which to place this AppBar.
  final double elevation;

  /// The background color of the AppBar.
  final Color? backgroundColor;

  /// The text style for the title text.
  final TextStyle? titleTextStyle;

  /// The text style for the subtitle text.
  final TextStyle? subtitleTextStyle;

  /// A widget displayed at the bottom of the AppBar, typically a [TabBar].
  final PreferredSizeWidget? bottom;

  /// Defines the default color, opacity, and size for icons in the AppBar.
  final IconThemeData? iconTheme;

  /// The color to use for text and icons in the AppBar.
  final Color? foregroundColor;

  /// Whether to show the default back button when no [leading] is provided.
  final bool automaticallyImplyLeading;

  /// Horizontal spacing around the title content.
  final double? titleSpacing;

  /// The shape of the AppBar's container.
  final ShapeBorder? shape;

  /// A widget to display behind the toolbar and tab bar.
  final Widget? flexibleSpace;

  /// Creates a [ReadyAppBar] widget.
  const ReadyAppBar({
    super.key,
    this.titleText,
    this.titleWidget,
    this.subtitle,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.bottom,
    this.iconTheme,
    this.foregroundColor,
    this.automaticallyImplyLeading = false,
    this.titleSpacing,
    this.shape,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    Widget? title;

    // Decide what to use as title: a custom widget, text with subtitle, or just text.
    if (titleWidget != null) {
      title = titleWidget;
    } else if (titleText != null && subtitle != null) {
      title = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(titleText!, style: titleTextStyle),
          Text(subtitle!, style: subtitleTextStyle),
        ],
      );
    } else if (titleText != null) {
      title = Text(titleText!, style: titleTextStyle);
    }

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      elevation: elevation,
      backgroundColor: backgroundColor,
      bottom: bottom,
      iconTheme: iconTheme,
      foregroundColor: foregroundColor,
      titleSpacing: titleSpacing,
      shape: shape,
      flexibleSpace: flexibleSpace,
    );
  }

  /// The size this AppBar prefers to be.
  /// Accounts for the height of the [bottom] widget if present.
  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
