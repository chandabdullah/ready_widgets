part of 'ready_buttons.dart';

enum _LikeButtonStyle { transparent, solid, outline }


class ReadyLikeButton extends StatefulWidget {
  /// Default transparent button with outline style
  factory ReadyLikeButton({
    Key? key,
    Future<bool?> Function(bool isLiked)? onTap,
    double iconSize = 26,
    Color? iconColor,
    IconData solidIcon = Icons.favorite,
    IconData outlineIcon = Icons.favorite_border,
    bool isLiked = false,
    Color? borderColor,
    double borderRadius = 8,
    double borderWidth = 1,
    ReadyButtonSize size = ReadyButtonSize.medium,
  }) {
    return ReadyLikeButton._(
      key: key,
      style: _LikeButtonStyle.transparent,
      onTap: onTap,
      iconSize: iconSize,
      color: Colors.transparent,
      iconColor: iconColor,
      solidIcon: solidIcon,
      outlineIcon: outlineIcon,
      isLiked: isLiked,
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      size: size,
    );
  }

  const ReadyLikeButton.solid({
    Key? key,
    this.onTap,
    this.iconSize = 26,
    this.color,
    this.iconColor,
    this.solidIcon = Icons.favorite,
    this.outlineIcon = Icons.favorite_border,
    this.isLiked = false,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.size = ReadyButtonSize.medium,
  }) : _style = _LikeButtonStyle.solid,
       super(key: key);

  const ReadyLikeButton.outlined({
    Key? key,
    this.onTap,
    this.iconSize = 26,
    this.color,
    this.iconColor,
    this.solidIcon = Icons.favorite,
    this.outlineIcon = Icons.favorite_border,
    this.isLiked = false,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.size = ReadyButtonSize.medium,
  }) : _style = _LikeButtonStyle.outline,
       super(key: key);

  const ReadyLikeButton._({
    Key? key,
    required _LikeButtonStyle style,
    this.onTap,
    this.iconSize = 26,
    this.color,
    this.iconColor,
    this.solidIcon = Icons.favorite,
    this.outlineIcon = Icons.favorite_border,
    this.isLiked = false,
    this.borderColor,
    this.borderRadius = 8,
    this.borderWidth = 1,
    this.size = ReadyButtonSize.medium,
  }) : _style = style,
       super(key: key);

  final Future<bool?> Function(bool isLiked)? onTap;
  final double iconSize;
  final Color? color;
  final Color? iconColor;
  final IconData solidIcon;
  final IconData outlineIcon;
  final bool isLiked;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final _LikeButtonStyle _style;
  final ReadyButtonSize size;

  @override
  State<ReadyLikeButton> createState() => _ReadyLikeButtonState();
}

class _ReadyLikeButtonState extends State<ReadyLikeButton>
    with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _resolveIconColor(ThemeData theme) {
    return widget.iconColor ??
        (widget._style == _LikeButtonStyle.solid
            ? Colors.white
            : theme.primaryColor);
  }

  Color _resolveBackgroundColor(ThemeData theme) {
    return widget._style == _LikeButtonStyle.solid
        ? (widget.color ?? theme.primaryColor)
        : Colors.transparent;
  }

  Color _resolveBorderColor(ThemeData theme) {
    return widget._style == _LikeButtonStyle.outline
        ? (widget.borderColor ?? theme.primaryColor)
        : Colors.transparent;
  }

  double _buttonSize() {
    switch (widget.size) {
      case ReadyButtonSize.small:
        return 36;
      case ReadyButtonSize.medium:
        return 48;
      case ReadyButtonSize.large:
        return 60;
    }
  }

  Future<void> _handleTap() async {
    _controller.forward().then((_) => _controller.reverse());

    final newState = !_isLiked;
    if (widget.onTap != null) {
      final result = await widget.onTap!(newState);
      if (result == null) return;
      setState(() => _isLiked = result);
    } else {
      setState(() => _isLiked = newState);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = _buttonSize();

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _resolveBackgroundColor(theme),
          border: Border.all(
            color: _resolveBorderColor(theme),
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
            child: Icon(
              _isLiked ? widget.solidIcon : widget.outlineIcon,
              size: widget.iconSize,
              color: _resolveIconColor(theme),
            ),
          ),
        ),
      ),
    );
  }
}
