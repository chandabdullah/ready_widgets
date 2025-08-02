import 'dart:math';
import 'package:flutter/material.dart';

class ReadyEmptyWidget extends StatefulWidget {
  const ReadyEmptyWidget({
    super.key,
    required this.title,
    this.icon,
    this.customIcon,
    this.subtitle,
    this.backgroundColor,
    this.additionalWidget,
    this.padding = 16,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final IconData? icon;
  final Widget? customIcon;
  final String? subtitle;
  final Color? backgroundColor;
  final Widget? additionalWidget;
  final double padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  State<ReadyEmptyWidget> createState() => _ReadyEmptyWidgetState();
}

class _ReadyEmptyWidgetState extends State<ReadyEmptyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showSubtitle = widget.subtitle?.trim().isNotEmpty ?? false;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.padding),
      color: widget.backgroundColor ?? Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              final offset = sin(
                _animation.value > 0.9
                    ? 1 - _animation.value
                    : _animation.value,
              );
              return Transform.translate(
                offset: Offset(0, offset),
                child:
                    widget.customIcon ??
                    Icon(widget.icon ?? Icons.info_outline, size: 30),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style:
                widget.titleStyle ??
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (showSubtitle) ...[
            const SizedBox(height: 8),
            Text(
              widget.subtitle!,
              textAlign: TextAlign.center,
              style: widget.subtitleStyle ?? TextStyle(fontSize: 16),
            ),
          ],
          const SizedBox(height: 12),
          widget.additionalWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
