import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_response/logic/create_response_bloc.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class QuestionParagraphWidget extends StatelessWidget {
  const QuestionParagraphWidget(
      {super.key,
      required this.index,
      required this.question,
      required this.result});

  final int index;
  final MQuestion question;
  final MQuestionAnswer result;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateResponseBLoc, CreateResponseState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: InputWidget(
          value: result.answer.option,
          onChanged: (value) {
            // TODO
          },
          maxLines: 3,
          keyboardType: TextInputType.multiline,
        ),
      );
    });
  }
}
