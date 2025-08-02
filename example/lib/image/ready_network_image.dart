import 'package:example/shimmer/ready_shimmer.dart';
import 'package:flutter/material.dart';

/// A customizable network image widget with built-in shimmer loading and fallback support.
class ReadyNetworkImage extends StatefulWidget {
  /// The URL or path of the image to load.
  final String imageUrl;

  /// The fixed height of the image. Defaults to width if not provided.
  final double? height;

  /// The width of the image (required).
  final double width;

  /// Defines how the image should be inscribed into the space allocated.
  final BoxFit? fit;

  /// The border radius if [isRounded] is false.
  final BorderRadius? borderRadius;

  /// Color of the image border.
  final Color? borderColor;

  /// Width of the image border.
  final double? borderWidth;

  /// Background color behind the image.
  final Color? backgroundColor;

  /// If true, the image will be rendered as a circle.
  final bool isRounded;

  /// If true, applies a dark overlay to the image.
  final bool isDark;

  /// Clip behavior of the image container.
  final Clip clipBehavior;

  /// A custom placeholder widget shown while the image is loading.
  final Widget? placeholder;

  /// A widget to display when image fails to load.
  final Widget? errorWidget;

  const ReadyNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    required this.width,
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
  /// Tracks if the image is fully loaded to toggle shimmer.
  bool _isLoaded = false;

  /// Determines whether the imageUrl is a remote URL.
  bool get _isRemote => widget.imageUrl.startsWith('http');

  /// Final resolved height based on input height or width fallback.
  late final double resolvedHeight;

  @override
  void initState() {
    super.initState();
    resolvedHeight = widget.height ?? widget.width;
  }

  @override
  Widget build(BuildContext context) {
    // Determines if image should be circular or rectangular.
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
          // Show shimmer or custom placeholder if image not loaded yet
          if (!_isLoaded)
            widget.placeholder ??
                ReadyShimmer(
                  width: widget.width,
                  height: resolvedHeight,
                  borderRadius: widget.isRounded ? null : widget.borderRadius,
                ),
          // Actual image loader
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
                  // Still show shimmer if not loaded
                  if (!_isLoaded)
                    widget.placeholder ??
                        ReadyShimmer(
                          width: widget.width,
                          height: resolvedHeight,
                          borderRadius:
                              widget.isRounded ? null : widget.borderRadius,
                        ),

                  // Fade-in animation once image is ready
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
            // Fallback UI when image loading fails
            errorBuilder:
                (context, error, stackTrace) =>
                    widget.errorWidget ??
                    const Center(child: Icon(Icons.broken_image_outlined)),
          ),
        ],
      ),
    );
  }

  /// Applies dark filter overlay if [isDark] is true.
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
