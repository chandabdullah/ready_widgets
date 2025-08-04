import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enum to define the type of decoration for the input field.
enum InputDecorationType { outlined, underlined }

/// Custom class to handle cursor styling.
class CursorStyleData {
  final Color? color;
  final double? height;
  final double? width;
  final Radius? radius;

  const CursorStyleData({this.color, this.height, this.width, this.radius});
}

/// A custom input widget with flexible configuration options.
class ReadyInput extends StatefulWidget {
  const ReadyInput({
    super.key,
    this.prefixIcon,
    this.label,
    this.showLabelInside = true, // NEW FLAG
    this.hint,
    this.isObscure = false,
    this.autovalidateMode,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.validator,
    this.enabled = true,
    this.autoFocus = false,
    this.minLines = 1,
    this.maxLines,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.decorationType = InputDecorationType.outlined,
    this.focusNode,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.style,
    this.cursorStyle,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.expands = false,
    this.onEditingComplete,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.borderRadius,
  });

  final Widget? prefixIcon;
  final String? label;
  final bool showLabelInside;
  final String? hint;
  final bool isObscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool autoFocus;
  final int minLines;
  final int? maxLines;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecorationType decorationType;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? style;
  final CursorStyleData? cursorStyle;
  final bool enableSuggestions;
  final bool enableInteractiveSelection;
  final Widget? Function(
    BuildContext, {
    int currentLength,
    bool isFocused,
    int? maxLength,
  })?
  buildCounter;
  final bool expands;
  final VoidCallback? onEditingComplete;
  final EdgeInsets scrollPadding;
  final BorderRadius? borderRadius;

  @override
  State<ReadyInput> createState() => _ReadyInputState();
}

class _ReadyInputState extends State<ReadyInput> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    showPassword = !widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.showLabelInside && widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(widget.label!, style: theme.textTheme.bodyMedium),
          ),
        TextFormField(
          autovalidateMode: widget.autovalidateMode,
          controller: widget.controller,
          obscureText: widget.isObscure && !showPassword,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autoFocus,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          minLines: widget.isObscure ? 1 : widget.minLines,
          maxLines:
              widget.isObscure ? 1 : widget.maxLines ?? widget.minLines + 1,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          textCapitalization: widget.textCapitalization,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          style: widget.style,
          cursorColor: widget.cursorStyle?.color,
          cursorHeight: widget.cursorStyle?.height,
          cursorWidth: widget.cursorStyle?.width ?? 2,
          cursorRadius: widget.cursorStyle?.radius,
          enableSuggestions: widget.enableSuggestions,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          buildCounter: widget.buildCounter,
          expands: widget.expands,
          onEditingComplete: widget.onEditingComplete,
          scrollPadding: widget.scrollPadding,
          decoration: _buildInputDecoration(context),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(8);

    return InputDecoration(
      labelText: widget.showLabelInside ? widget.label : null,
      hintText: widget.hint,
      prefixIcon: widget.prefixIcon,
      suffixIcon:
          widget.suffixIcon ??
          (widget.isObscure
              ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
              : null),
      border:
          widget.decorationType == InputDecorationType.outlined
              ? OutlineInputBorder(borderRadius: borderRadius)
              : const UnderlineInputBorder(),
      enabledBorder:
          widget.decorationType == InputDecorationType.outlined
              ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: Colors.grey.shade400),
              )
              : UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
      focusedBorder:
          widget.decorationType == InputDecorationType.outlined
              ? OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              )
              : UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }
}
