import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_response/logic/create_response_bloc.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class QuestionParagraphWidget extends StatelessWidget {
  const QuestionParagraphWidget({
    super.key,
    required this.index,
    required this.question,
  });

  final int index;
  final MQuestion question;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateResponseBLoc, CreateResponseState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: InputWidget(
          value: question.resultParagraph,
          onChanged: (value) {
            context
                .read<CreateResponseBLoc>()
                .onChangeParagraph(value: value, position: index);
          },
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(hintText: "Enter Answer"),
        ),
      );
    });
  }
}
