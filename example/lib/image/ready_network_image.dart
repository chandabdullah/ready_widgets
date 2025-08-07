import 'package:example/shimmer/ready_shimmer.dart';
import 'package:flutter/material.dart';

/// A customizable network image widget with built-in shimmer loading and fallback support.
class ReadyNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;
  final bool isRounded;
  final bool isDark;
  final Clip clipBehavior;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ReadyNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.isRounded = false,
    this.isDark = false,
    this.clipBehavior = Clip.antiAlias,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<ReadyNetworkImage> createState() => _ReadyNetworkImageState();
}

class _ReadyNetworkImageState extends State<ReadyNetworkImage> {
  bool _isLoaded = false;
  bool get _isRemote => widget.imageUrl.startsWith('http');

  late final double resolvedHeight;
  late final double resolvedWidth;

  @override
  void initState() {
    super.initState();
    resolvedHeight = widget.height ?? widget.width ?? 100;
    resolvedWidth = widget.width ?? widget.height ?? 100;
  }

  @override
  Widget build(BuildContext context) {
    final shape = widget.isRounded ? BoxShape.circle : BoxShape.rectangle;

    return Container(
      height: resolvedHeight,
      width: resolvedWidth,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: shape,
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent,
          width: widget.borderWidth ?? 0,
        ),
        borderRadius:
            widget.isRounded
                ? null
                : widget.borderRadius ?? BorderRadius.circular(8),
      ),
      clipBehavior: widget.clipBehavior,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (!_isLoaded)
            widget.placeholder ??
                ReadyShimmer(
                  width: resolvedWidth,
                  height: resolvedHeight,
                  borderRadius: widget.isRounded ? null : widget.borderRadius,
                ),
          Image.network(
            _isRemote
                ? widget.imageUrl
                : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
            fit: widget.fit ?? BoxFit.cover,
            frameBuilder: (context, child, frame, wasSyncLoaded) {
              final isNowLoaded = frame != null;

              return Stack(
                fit: StackFit.expand,
                children: [
                  if (!_isLoaded)
                    widget.placeholder ??
                        ReadyShimmer(
                          width: resolvedWidth,
                          height: resolvedHeight,
                          borderRadius:
                              widget.isRounded ? null : widget.borderRadius,
                        ),
                  AnimatedOpacity(
                    opacity: isNowLoaded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    onEnd: () {
                      if (mounted && !_isLoaded) {
                        setState(() {
                          _isLoaded = true;
                        });
                      }
                    },
                    child: _buildFiltered(child),
                  ),
                ],
              );
            },
            errorBuilder:
                (context, error, stackTrace) =>
                    widget.errorWidget ??
                    const Center(child: Icon(Icons.broken_image_outlined)),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltered(Widget child) {
    if (!widget.isDark) return child;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withAlpha((0.4 * 255).toInt()),
        BlendMode.darken,
      ),
      child: child,
    );
  }
}
