import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputDecorationType { outlined, underlined }

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    this.prefixIcon,
    this.title,
    this.hint,
    this.isObscure = false,
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
  });

  final Icon? prefixIcon;
  final String? title;
  final String? hint;
  final bool isObscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
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

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
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
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(widget.title!, style: theme.textTheme.bodyMedium),
          ),
        TextFormField(
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
          decoration: _buildInputDecoration(context),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
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
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              : UnderlineInputBorder(),
      enabledBorder:
          widget.decorationType == InputDecorationType.outlined
              ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              )
              : UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
      focusedBorder:
          widget.decorationType == InputDecorationType.outlined
              ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              )
              : UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }
}
