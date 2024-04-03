import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';
import 'package:flutter_form_google/src/widget/option_item_view.dart';
import 'package:uuid/uuid.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key, this.editFormData});
  final MFormData? editFormData;

  static const routeName = '/create';

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFormCubit(widget.editFormData),
      child: BlocBuilder<CreateFormCubit, CreateFormState>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                  widget.editFormData != null ? "Edit Form" : "Create Form"),
              actions: [
                Opacity(
                  opacity: state.isEmptyForm ? 0.5 : 1,
                  child: ElevatedButton(
                      onPressed: () {
                        if (state.isEmptyForm) return;
                        Navigator.pop(context);
                        if (widget.editFormData != null) {
                          context.read<HomeBloc>().editNewForm(MFormData(
                              id: widget.editFormData!.id,
                              title: state.titleForm,
                              questions: state.listFormData));
                        } else {
                          context.read<HomeBloc>().addNewForm(MFormData(
                              id: const Uuid().v4(),
                              title: state.titleForm,
                              questions: state.listFormData));
                        }
                      },
                      child: Text(
                        widget.editFormData != null ? "Edit" : "Send",
                      )),
                )
              ],
            ),
            body: _body(context),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  context.read<CreateFormCubit>().addNewForm();
                }));
      }),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _titleForm(context),
          Expanded(child: _listFormQuestion()),
        ],
      ),
    );
  }

  Widget _listFormQuestion() {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return ListView.builder(
          itemCount: state.listFormData.length,
          itemBuilder: (context, position) {
            return _itemAddQuestion(context,
                model: state.listFormData[position],
                position: position,
                isBottom: state.listFormData.length == position + 1);
          });
    });
  }

  Widget _titleForm(BuildContext context) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.centerLeft,
        child: state.isEditTitile
            ? InputWidget(
                value: state.titleForm,
                onChanged: (value) {
                  context.read<CreateFormCubit>().onChangeTitleForm(value);
                },
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  context.read<CreateFormCubit>().onDoneChangeEditTitleForm();
                },
              )
            : InkWell(
                onTap: () {
                  context.read<CreateFormCubit>().isEditTitleForm();
                },
                child: Text(
                  state.titleForm,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.left,
                ),
              ),
      );
    });
  }

  Widget _itemAddQuestion(BuildContext context,
      {required MQuestion model,
      required int position,
      required bool isBottom}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isBottom ? 40 : 10,
      ),
      child: Card(
        elevation: 2,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          child: Column(
            children: [
              _rowInputAndPickImage(
                context,
                value: model.question,
                position: position,
              ),
              _dropdownBox(context, model: model, position: position),
              model.optionQuestion == 2
                  ? _paragrahpView(context, model: model, position: position)
                  : _radioBox(context, position: position),
              _bottomView(
                context,
                model: model,
                position: position,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowInputAndPickImage(BuildContext context,
      {required String value, required int position}) {
    return InputWidget(
      value: value,
      decoration: InputDecoration(hintText: "Untitled Question"),
      onChanged: (value) {
        context.read<CreateFormCubit>().editQuestion(position, value);
      },
    );
  }

  Widget _dropdownBox(BuildContext context,
      {required MQuestion model, required int position}) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      child: DropdownButton(
          value: model.optionQuestion,
          items: const [
            DropdownMenuItem(
              value: 1,
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
              value: 2,
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
          onChanged: (value) {
            context
                .read<CreateFormCubit>()
                .selectQuestionOption(position: position, value: value ?? 0);
          }),
    );
  }

  String? _selectedOption;

  Widget _listOptionQuestion(int position) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.listFormData[position].resultOption.length,
              itemBuilder: (context, selectedPosition) {
                final result =
                    state.listFormData[position].resultOption[selectedPosition];
                return OptionItemView(
                  result: result,
                  groupValue: state.listFormData[position]
                      .resultOption[state.listFormData[position].indexSelected],
                  onChange: (value) {
                    context.read<CreateFormCubit>().changeOptionQuestion(
                        index: position, indexSelected: selectedPosition);
                  },
                  onChangeResult: (p0) {
                    context.read<CreateFormCubit>().updateResultOption(
                        index: position,
                        indexSelected: selectedPosition,
                        result: p0 ?? "");
                  },
                );
              }),
          if (state.listFormData[position].resultOption.length < 5)
            RadioListTile(
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<CreateFormCubit>()
                            .addOptionQuestion(position, false);
                      },
                      child: const Text(
                        "Add option",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(" or "),
                    InkWell(
                      onTap: () {
                        context
                            .read<CreateFormCubit>()
                            .addOptionQuestion(position, true);
                      },
                      child: Text(
                        "Add `Other`",
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
                value: "Add Other",
                groupValue: _selectedOption,
                onChanged: (value) {})
        ],
      );
    });
  }

  Widget _radioBox(BuildContext context, {required int position}) {
    return _listOptionQuestion(position);
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
                VerticalDivider(
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Required"),
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

  Widget _paragrahpView(BuildContext context,
      {required MQuestion model, required int position}) {
    return InputWidget(
        decoration: const InputDecoration(hintText: "Enter answer"),
        value: model.resultParagraph,
        onChanged: (value) {
          context
              .read<CreateFormCubit>()
              .onChangeParagraph(value: value, position: position);
        });
  }
}
