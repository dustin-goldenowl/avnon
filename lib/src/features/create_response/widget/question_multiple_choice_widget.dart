import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/answer_type.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class QuestionMultipleChoiceWidget extends StatelessWidget {
  const QuestionMultipleChoiceWidget(
      {super.key,
      required this.index,
      required this.question,
      required this.result});

  final int index;
  final MQuestion question;
  final MQuestionAnswer result;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (int i = 0; i < question.resultOption.length; i++)
        _buildOption(context, i, question.resultOption[i])
    ]);
  }

  Widget _buildOption(BuildContext context, int index, String option) {
    final bool isChoose = result.answer.option == option &&
        result.answer.answerType == MAnswerType.select;

    return RadioListTile(
      title: option == "Others"
          ? InputWidget(value: option, onChanged: (value) {})
          : Text(option),
      value: option,
      groupValue: option,
      onChanged: (String? value) {},
    );
  }
}
