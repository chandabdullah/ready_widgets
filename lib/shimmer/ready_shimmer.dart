import 'package:flutter/material.dart';

/// A customizable shimmer effect widget without using external dependencies.
class ReadyShimmer extends StatefulWidget {
  /// Width of the shimmer container.
  final double width;

  /// Height of the shimmer container.
  final double height;

  /// Optional border radius for rounded corners.
  final BorderRadiusGeometry? borderRadius;

  /// Optional shimmer colors. Minimum 2 required.
  ///
  /// If not provided, defaults to 3 grey tones.
  final List<Color>? shimmerColors;

  const ReadyShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shimmerColors,
  });

  @override
  State<ReadyShimmer> createState() => _ReadyShimmerState();
}

class _ReadyShimmerState extends State<ReadyShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    final duration = Duration(
      milliseconds: (1200 * (widget.height / 100).clamp(0.5, 3)).toInt(),
    );

    _controller = AnimationController(vsync: this, duration: duration)
      ..repeat();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<double> _generateStops(int count) {
    if (count < 2) return [0.0];
    return List.generate(count, (index) => index / (count - 1));
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        widget.shimmerColors ??
        const [Color(0xFFC8C8C8), Color(0xFFF0F0F0), Color(0xFFC8C8C8)];

    if (colors.length < 2) {
      throw FlutterError('shimmerColors must contain at least 2 colors.');
    }

    final stops = _generateStops(colors.length);

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final shimmerX = 2 * _animation.value - 1;

        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 + shimmerX, -1 + shimmerX),
              end: Alignment(1 + shimmerX, 1 + shimmerX),
              colors: colors,
              stops: stops,
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: colors.first.withAlpha((0.4 * 255).toInt()),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
