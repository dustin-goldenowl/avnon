import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    required this.value,
    required this.onChanged,
    this.decoration,
    this.keyboardType,
    this.obscureText = false,
    this.showErrorWithOutText = false,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.errorText,
    this.inputFormatters,
    this.maxLines = 3,
    this.minLines = 1,
    this.hintStyle,
    super.key,
  });

  final ValueChanged<String>? onChanged;
  final String value;
  final InputDecoration? decoration;
  final bool obscureText;
  final bool showErrorWithOutText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int minLines;
  final TextStyle? hintStyle;

  @override
  State<InputWidget> createState() => _XInputState();
}

class _XInputState extends State<InputWidget> {
  late TextEditingController _controller;

  String get value => widget.value;
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        widget.onEditingComplete?.call();
      },
      onFieldSubmitted: (e) {
        FocusScope.of(context).unfocus();
        widget.onFieldSubmitted?.call(e);
      },
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
          alignLabelWithHint: true,
          errorText: widget.errorText,
          labelStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          errorMaxLines: 1,
          suffixIcon: widget.suffixIcon,
          fillColor: Colors.white),
    );
  }
}
