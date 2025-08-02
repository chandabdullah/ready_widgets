import 'package:flutter/material.dart';

class ReadyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final PreferredSizeWidget? bottom;
  final IconThemeData? iconTheme;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;
  final double? titleSpacing;
  final ShapeBorder? shape;
  final Widget? flexibleSpace;

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

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
