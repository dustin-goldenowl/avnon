import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/data/models/question_type.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';
import 'package:flutter_form_google/src/features/create_form/widget/option_item_view.dart';

class QuestionItemWidget extends StatelessWidget {
  const QuestionItemWidget(
      {super.key,
      required this.model,
      required this.index,
      required this.currentIndex});
  final MQuestion model;
  final int index;
  final int currentIndex;
  bool get enableEdit => currentIndex == index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: enableEdit
            ? null
            : () {
                context.read<CreateFormCubit>().changeIndexQuestion(index);
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildTitle(
                  context,
                  value: model.question,
                  position: index,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _dropdownBox(context, model: model, position: index),
              ),
              if (model.type == MQuestionType.paragraph)
                _paragraphView(context, model: model, position: index)
              else
                _listOptionQuestion(context, index),
              if (enableEdit)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _bottomView(
                    context,
                    model: model,
                    position: index,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context,
      {required String value, required int position}) {
    if (enableEdit) {
      return InputWidget(
        value: value,
        decoration: const InputDecoration(hintText: "Untitled Question"),
        onChanged: (value) {
          context.read<CreateFormCubit>().editQuestion(position, value);
        },
      );
    } else {
      return Text(
        value,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyLarge,
      );
    }
  }

  Widget _dropdownBox(BuildContext context,
      {required MQuestion model, required int position}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: DropdownButton<MQuestionType>(
          value: model.type,
          items: const [
            DropdownMenuItem(
              value: MQuestionType.multipleChoice,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.radio_button_checked),
                  SizedBox(width: 10),
                  Text("Multiple choice")
                ],
              ),
            ),
            DropdownMenuItem(
              value: MQuestionType.paragraph,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.format_align_left),
                  SizedBox(width: 10),
                  Text("Paragraph")
                ],
              ),
            )
          ],
          onChanged: enableEdit
              ? (MQuestionType? value) {
                  if (value != null) {
                    context
                        .read<CreateFormCubit>()
                        .selectQuestionOption(position: position, value: value);
                  }
                }
              : null),
    );
  }

  Widget _listOptionQuestion(BuildContext context, int index) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      final question = state.questions[index];
      final options = question.resultOption;
      final indexOption = state.indexOption;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < options.length; i++)
            OptionItemView(
              options[i],
              index: i,
              groupValue: indexOption,
              enableEdit: enableEdit,
              enableRemoveOption: question.enableRemoveOption,
              onChange: (value) {
                context.read<CreateFormCubit>().changeIndexOption(i);
              },
              onChangeResult: (p0) {
                if (p0 != null) {
                  context.read<CreateFormCubit>().updateResultOption(
                        index: index,
                        indexSelected: i,
                        result: p0,
                      );
                }
              },
            ),
          if (question.hasOther)
            RadioListTile<int>(
              enableFeedback: false,
              title: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Other...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<CreateFormCubit>()
                            .onChangeOptionOther(index, false);
                      },
                      icon: const Icon(Icons.clear))
                ],
              ),
              value: index,
              groupValue: -1,
              onChanged: null,
            ),
          if (state.questions[index].resultOption.length < 5)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<CreateFormCubit>().addOptionQuestion(index);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text("Add option",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ),
                  const Text(" or "),
                  InkWell(
                    onTap: () {
                      context
                          .read<CreateFormCubit>()
                          .onChangeOptionOther(index, true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text("Add `Other`",
                          style: TextStyle(color: Colors.blue.shade700)),
                    ),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }

  Widget _bottomView(BuildContext context,
      {required MQuestion model, required int position}) {
    return Column(
      children: [
        const Divider(),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<CreateFormCubit>().duplicateQuestion(position);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.copy_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<CreateFormCubit>()
                        .removeFormWithPosition(position);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                const SizedBox(width: 10),
                const Text("Required"),
                Switch(
                    value: model.isRequired,
                    onChanged: (value) {
                      context.read<CreateFormCubit>().isRequiredForm(
                          position: position, isRequired: value);
                    })
              ]),
        ),
      ],
    );
  }

  Widget _paragraphView(BuildContext context,
      {required MQuestion model, required int position}) {
    return const SizedBox();
  }
}
