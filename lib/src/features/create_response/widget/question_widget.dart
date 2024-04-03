import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/data/models/question_type.dart';
import 'package:flutter_form_google/src/features/create_response/widget/question_multiple_choice_widget.dart';
import 'package:flutter_form_google/src/features/create_response/widget/question_paragraph_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key, required this.index, required this.question});

  final int index;
  final MQuestion question;

  @override
  Widget build(BuildContext context) {
    if (question.type == MQuestionType.multipleChoice) {
      return QuestionMultipleChoiceWidget(
        index: index,
        question: question,
      );
    }
    return QuestionParagraphWidget(index: index, question: question);
  }
}
