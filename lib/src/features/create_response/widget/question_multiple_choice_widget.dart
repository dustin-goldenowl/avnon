import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/answer_type.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: question.resultOption.length,
        itemBuilder: (context, indexSelected) {
          return _buildOption(
              context, indexSelected, question.resultOption[indexSelected]);
        });
  }

  Widget _buildOption(BuildContext context, int indexSelected, String option) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return RadioListTile(
        title: option == "Others"
            ? InputWidget(value: option, onChanged: (value) {})
            : Text(option),
        value: option,
        groupValue: state.questions[index]
            .resultOption[state.questions[index].indexSelected],
        onChanged: (String? value) {
          context
              .read<CreateFormCubit>()
              .onUpdateAnswer(index: index, indexSelected: indexSelected);
        },
      );
    });
  }
}
