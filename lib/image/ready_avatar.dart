part of 'ready_images.dart';

class ReadyAvatar extends StatelessWidget {
  /// Name used to extract initials (optional).
  final String? name;

  /// Image URL to load avatar image (optional).
  final String? imageUrl;

  /// Size of avatar (width and height).
  final double size;

  /// Show online indicator (null = hidden).
  final bool? isOnline;

  /// Use circular avatar or rectangular.
  final bool isCircular;

  /// Border radius (used when isCircular is false).
  final double borderRadius;

  /// Size of online indicator (optional).
  final double? onlineIndicatorSize;

  /// Text color for initials placeholder (optional).
  final Color? textColor;

  /// Background color for initials placeholder (optional).
  final Color? backgroundColor;

  const ReadyAvatar({
    super.key,
    this.name,
    this.imageUrl,
    this.size = 60.0,
    this.isOnline,
    this.isCircular = true,
    this.borderRadius = 12.0,
    this.onlineIndicatorSize,
    this.textColor,
    this.backgroundColor,
  });

  /// Compute initials from name
  String get initials {
    if (name == null || name!.trim().isEmpty) return 'U';
    final parts = name!.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }

  /// Shimmer placeholder while image loads
  Widget _buildShimmerPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
      ),
    );
  }

  /// Initials-based fallback avatar
  Widget _buildInitialsPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            Theme.of(context).primaryColor.withAlpha((0.3 * 255).toInt()),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size / 2.5,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorSize = onlineIndicatorSize ?? size * 0.2;

    final avatarContent =
        (imageUrl == null || imageUrl!.isEmpty)
            ? _buildInitialsPlaceholder(context)
            : ReadyNetworkImage(
              imageUrl: imageUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: _buildShimmerPlaceholder(context),
              errorWidget: _buildInitialsPlaceholder(context),
            );

    return Stack(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ClipRRect(
            borderRadius:
                isCircular
                    ? BorderRadius.circular(size)
                    : BorderRadius.circular(borderRadius),
            child: avatarContent,
          ),
        ),
        if (isOnline != null)
          Positioned(
            bottom: isCircular ? size * 0.05 : 0,
            right: isCircular ? size * 0.05 : 0,
            child: Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 2,
                ),
                color: isOnline == true ? Colors.green : Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
