import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_response/logic/create_response_bloc.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class QuestionMultipleChoiceWidget extends StatelessWidget {
  const QuestionMultipleChoiceWidget(
      {super.key, required this.index, required this.question});

  final int index;
  final MQuestion question;
  @override
  Widget build(BuildContext context) {
    return _listRadio();
  }

  Widget _listRadio() {
    return BlocBuilder<CreateResponseBLoc, CreateResponseState>(
        builder: (context, state) {
      return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: question.resultOption.length,
              itemBuilder: (context, indexSelected) {
                return _buildOption(context, indexSelected,
                    question.resultOption[indexSelected]);
              }),
          if (question.hasOther) ...[
            RadioListTile(
              title: InputWidget(
                  decoration: const InputDecoration(hintText: "Enter Answer"),
                  value: state.questions[index].valueOther,
                  onChanged: (value) {
                    context
                        .read<CreateResponseBLoc>()
                        .onChangeOtherValue(value: value, position: index);
                  }),
              value: state.questions[index].valueOther,
              groupValue: state.questions[index].groupValue,
              onChanged: (String? value) {
                // context
                //     .read<CreateResponseBLoc>()
                //     .onUpdateAnswer(index: index, indexSelected: indexSelected);
              },
            )
          ]
        ],
      );
    });
  }

  Widget _buildOption(BuildContext context, int indexSelected, String option) {
    return BlocBuilder<CreateResponseBLoc, CreateResponseState>(
        builder: (context, state) {
      return RadioListTile(
        title: Text(option),
        value: option,
        groupValue: state.questions[index].indexSelected == -1
            ? ""
            : state.questions[index]
                .resultOption[state.questions[index].indexSelected],
        onChanged: (String? value) {
          context
              .read<CreateResponseBLoc>()
              .onUpdateAnswer(index: index, indexSelected: indexSelected);
        },
      );
    });
  }
}
