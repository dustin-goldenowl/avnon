import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class OptionItemView extends StatefulWidget {
  const OptionItemView({
    super.key,
    required this.result,
    required this.groupValue,
    required this.onChange,
    required this.onChangeResult,
  });
  final String result;
  final String groupValue;
  final Function(String?) onChange;
  final Function(String?) onChangeResult;

  @override
  State<OptionItemView> createState() => _OptionItemViewState();
}

class _OptionItemViewState extends State<OptionItemView> {
  bool isShowText = false;
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: isShowText
          ? InputWidget(
              value: widget.result,
              onChanged: (value) {
                widget.onChangeResult(value);
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (p0) {
                setState(() {
                  isShowText = false;
                });
              },
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isShowText = true;
                });
              },
              child: Text(widget.result)),
      value: widget.result,
      groupValue: widget.groupValue,
      onChanged: widget.onChange,
    );
  }
}
