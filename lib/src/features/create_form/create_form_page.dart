import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_cubit.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
import 'package:flutter_form_google/src/features/create_form/widget/question_item_widget.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';
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
            title:
                Text(widget.editFormData != null ? "Edit Form" : "Create Form"),
            actions: [
              ElevatedButton(
                onPressed: state.isEmptyForm
                    ? null
                    : () {
                        Navigator.pop(context);
                        if (widget.editFormData != null) {
                          context.read<HomeBloc>().editNewForm(MFormData(
                              id: widget.editFormData!.id,
                              title: state.titleForm,
                              questions: state.questions));
                        } else {
                          context.read<HomeBloc>().addNewForm(MFormData(
                              id: const Uuid().v4(),
                              title: state.titleForm,
                              questions: state.questions));
                        }
                      },
                child: Text(
                  widget.editFormData != null ? "Edit" : "Send",
                ),
              )
            ],
          ),
          body: _body(context),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CreateFormCubit>().addNewForm();
            },
          ),
        );
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
      return ListView.separated(
        itemCount: state.questions.length,
        padding: const EdgeInsets.only(bottom: 40),
        itemBuilder: (context, index) {
          return QuestionItemWidget(
            model: state.questions[index],
            index: index,
            currentIndex: state.indexQuestion,
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 10);
        },
      );
    });
  }

  Widget _titleForm(BuildContext context) {
    return BlocBuilder<CreateFormCubit, CreateFormState>(
        builder: (context, state) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.centerLeft,
        child: state.isEditTitle
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
}
