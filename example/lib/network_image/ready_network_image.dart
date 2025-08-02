import 'package:example/shimmer/ready_shimmer.dart';
import 'package:flutter/material.dart';

class ReadyNetworkImage extends StatefulWidget {
  const ReadyNetworkImage({
    super.key,
    required this.imagePath,
    this.height,
    required this.width,
    this.boxFit,
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

  final String imagePath;
  final double? height;
  final double width;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;
  final bool isRounded;
  final bool isDark;
  final Clip clipBehavior;

  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  State<ReadyNetworkImage> createState() => _ReadyNetworkImageState();
}

class _ReadyNetworkImageState extends State<ReadyNetworkImage> {
  bool _isLoaded = false;
  bool get _isRemote => widget.imagePath.startsWith('http');
  late final double resolvedHeight;

  @override
  void initState() {
    super.initState();
    resolvedHeight = widget.height ?? widget.width;
  }

  @override
  Widget build(BuildContext context) {
    final shape = widget.isRounded ? BoxShape.circle : BoxShape.rectangle;

    return Container(
      height: resolvedHeight,
      width: widget.width,
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
                  width: widget.width,
                  height: resolvedHeight,
                  borderRadius: widget.isRounded ? null : widget.borderRadius,
                ),
          Image.network(
            _isRemote
                ? widget.imagePath
                : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
            fit: widget.boxFit ?? BoxFit.cover,
            frameBuilder: (context, child, frame, wasSyncLoaded) {
              final isNowLoaded = frame != null;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Show shimmer until image is loaded
                  if (!_isLoaded)
                    widget.placeholder ??
                        ReadyShimmer(
                          width: widget.width,
                          height: resolvedHeight,
                          borderRadius:
                              widget.isRounded ? null : widget.borderRadius,
                        ),

                  // Show image with fade-in
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
