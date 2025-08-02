import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Enum to define trimming behavior — by line count or by text length.
enum TrimMode { line, length }

/// A widget that trims long text and shows "Read more"/"Read less" links.
class ReadyReadMoreText extends StatefulWidget {
  final String text;

  /// Style for the main text.
  final TextStyle? textStyle;

  /// Style for the "Read more"/"Read less" links.
  final TextStyle? moreLessStyle;

  /// Number of lines to trim to when [trimMode] is `TrimMode.line`.
  final int trimLines;

  /// Number of characters to trim to when [trimMode] is `TrimMode.length`.
  final int trimLength;

  /// Whether trimming is based on line count or text length.
  final TrimMode trimMode;

  /// Text shown to expand the content.
  final String readMoreText;

  /// Text shown to collapse the content.
  final String readLessText;

  const ReadyReadMoreText({
    super.key,
    required this.text,
    this.textStyle,
    this.moreLessStyle,
    this.trimLines = 2,
    this.trimLength = 100,
    this.trimMode = TrimMode.line,
    this.readMoreText = ' Read more',
    this.readLessText = ' Read less',
  });

  @override
  State<ReadyReadMoreText> createState() => _ReadyReadMoreTextState();
}

class _ReadyReadMoreTextState extends State<ReadyReadMoreText> {
  /// Tracks whether the full text is currently shown.
  bool _expanded = false;

  /// Whether the text overflows the defined trimLines.
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    // Resolve styles or fall back to theme defaults
    final defaultStyle =
        widget.textStyle ?? Theme.of(context).textTheme.bodyMedium!;
    final linkStyle =
        widget.moreLessStyle ??
        defaultStyle.copyWith(color: Theme.of(context).primaryColor);

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: defaultStyle);

        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        // Check if the text exceeds the trimLines
        _isOverflowing = tp.didExceedMaxLines;

        if (!_expanded && _isOverflowing) {
          // Show trimmed text with "Read more"
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _getTrimmedText(widget.text, defaultStyle, constraints),
                  style: defaultStyle,
                ),
                TextSpan(
                  text: widget.readMoreText,
                  style: linkStyle,
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          setState(() => _expanded = true);
                        },
                ),
              ],
            ),
          );
        } else {
          // Show full text, and if it was trimmed, offer "Read less"
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: widget.text, style: defaultStyle),
                if (_isOverflowing)
                  TextSpan(
                    text: widget.readLessText,
                    style: linkStyle,
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            setState(() => _expanded = false);
                          },
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  /// Trims the text based on how many lines fit within the constraints.
  String _getTrimmedText(
    String text,
    TextStyle style,
    BoxConstraints constraints,
  ) {
    final words = text.split(' ');
    String result = '';

    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: widget.trimLines,
    );

    for (var word in words) {
      final temp =
          (result.isEmpty ? '' : '$result ') + word + widget.readMoreText;
      tp.text = TextSpan(text: temp, style: style);
      tp.layout(maxWidth: constraints.maxWidth);

      // Stop adding more words if maxLines exceeded
      if (tp.didExceedMaxLines) break;
      result = result.isEmpty ? word : '$result $word';
    }

    return '$result...';
  }
}
