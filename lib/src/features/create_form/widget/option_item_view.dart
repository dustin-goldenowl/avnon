import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class OptionItemView extends StatelessWidget {
  const OptionItemView(
    this.result, {
    super.key,
    required this.groupValue,
    required this.index,
    required this.onChange,
    required this.onChangeResult,
    required this.enableEdit,
    required this.enableRemoveOption,
  });
  final String result;
  final int index;
  final int groupValue;
  final bool enableEdit;
  final bool enableRemoveOption;
  final Function(int?) onChange;
  final Function(String?) onChangeResult;

  @override
  Widget build(BuildContext context) {
    bool isShowText = groupValue == index;
    return RadioListTile<int>(
      enableFeedback: false,
      title: Row(
        children: [
          Expanded(
            child: enableEdit && isShowText
                ? InputWidget(
                    value: result,
                    onChanged: (value) {
                      onChangeResult(value);
                    },
                    textInputAction: TextInputAction.done,
                  )
                : GestureDetector(
                    onTap: enableEdit ? () => onChange(index) : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        result,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )),
          ),
          if (enableRemoveOption && enableEdit)
            IconButton(
              onPressed: () {
                context.read<CreateFormCubit>().onRemoveOptionQuestion(index);
              },
              icon: const Icon(Icons.clear),
            )
        ],
      ),
      value: index,
      groupValue: groupValue,
      onChanged: enableEdit ? onChange : null,
    );
  }
}
