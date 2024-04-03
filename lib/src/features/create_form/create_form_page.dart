import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
import 'package:flutter_form_google/src/model/form_data_model.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key});

  static const routeName = '/create';

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFormCubit(),
      child: BlocBuilder<CreateFormCubit, CreateFormState>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Create Form"),
            ),
            body: _body(context),
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.read<CreateFormCubit>().addNewForm();
            }));
      }),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _titleForm(context),
        Expanded(child: _listFormQuestion()),
      ],
    );
  }

  Widget _listFormQuestion() {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return ListView.builder(
          itemCount: state.listFormData.length,
          itemBuilder: (context, position) {
            return _itemAddQuestion(
              context,
              model: state.listFormData[position],
              position: position,
            );
          });
    });
  }

  Widget _titleForm(BuildContext context) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return Container(
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
      {required MQuestion model, required int position}) {
    return Card(
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
            _dropdownBox(context),
            _radioBox(context, position: position),
            _bottomView(
              context,
              position: position,
            )
          ],
        ),
      ),
    );
  }

  Widget _rowInputAndPickImage(BuildContext context,
      {required String value, required int position}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: InputWidget(
            value: value,
            onChanged: (value) {
              context.read<CreateFormCubit>().editQuestion(position, value);
            },
          ),
        ),
        // const SizedBox(
        //   width: 10,
        // ),
        // InkWell(
        //     onTap: () {},
        //     child: const Padding(
        //       padding: EdgeInsets.all(10),
        //       child: Icon(Icons.photo),
        //     ))
      ],
    );
  }

  Widget _dropdownBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      child: DropdownButton(
          value: 1,
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
          onChanged: (value) {}),
    );
  }

  String? _selectedOption;

  Widget _listOptionQuestion(int position) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: state.listFormData[position].resultOption.length,
              itemBuilder: (context, selectedPosition) {
                final result =
                    state.listFormData[position].resultOption[selectedPosition];
                return RadioListTile(
                    title: Text(result),
                    value: result,
                    groupValue: state.listFormData[position].resultOption[
                        state.listFormData[position].indexSelected],
                    onChanged: (value) {
                      context.read<CreateFormCubit>().changeOptionQuestion(
                          index: position, indexSelected: selectedPosition);
                    });
              }),
          if (state.listFormData[position].resultOption.length < 5)
            RadioListTile(
                title: Row(
                  children: [
                    Text(
                      "Add option",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(" or "),
                    InkWell(
                      onTap: () {
                        context
                            .read<CreateFormCubit>()
                            .addOptionQuestion(position);
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
                onChanged: (value) {
                  _selectedOption = value;
                  setState(() {});
                })
        ],
      );
    });
  }

  Widget _radioBox(BuildContext context, {required int position}) {
    return _listOptionQuestion(position);
  }

  bool _isRequired = false;

  Widget _bottomView(BuildContext context, {required int position}) {
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
                    // TODO: add tab question
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
                Text("Reuqired"),
                Switch(
                    value: _isRequired,
                    onChanged: (value) {
                      _isRequired = value;
                      setState(() {});
                    })
              ]),
        ),
      ],
    );
  }
}
