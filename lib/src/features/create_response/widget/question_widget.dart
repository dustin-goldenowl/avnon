import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_response/widget/question_multiple_choice_widget.dart';
import 'package:flutter_form_google/src/features/create_response/widget/question_paragraph_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.index,
      required this.question,
      required this.result});

  final int index;
  final MQuestion question;
  final MQuestionAnswer result;

  @override
  Widget build(BuildContext context) {
    if (question.optionQuestion == 1) {
      return QuestionMultipleChoiceWidget(
          index: index, question: question, result: result);
    }
    return QuestionParagraphWidget(
        index: index, question: question, result: result);
  }
}
