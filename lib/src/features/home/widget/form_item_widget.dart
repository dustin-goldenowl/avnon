import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:flutter_form_google/src/localization/localization_utils.dart';
import 'package:flutter_form_google/src/route/coordinator.dart';

enum FormOptionAction { edit, seeResponse, createResponse, delete }

class FormItemWidget extends StatelessWidget {
  const FormItemWidget(this.item, {super.key});
  final MFormData item;
  Future onActionSelected(BuildContext context, FormOptionAction action) async {
    switch (action) {
      case FormOptionAction.edit:
        return AppCoordinator.showCreateForm(context, editItem: item);
      case FormOptionAction.seeResponse:
        return AppCoordinator.showResponse(context, item: item);
      case FormOptionAction.createResponse:
        return AppCoordinator.showCreateResponse(context, item: item);
      case FormOptionAction.delete:
        return context.read<HomeBloc>().removeForm(item.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionCount = item.questions.length;
    final subtitle = questionCount <= 1
        ? S.of(context).form_count_question_one(questionCount)
        : S.of(context).form_count_question_many(questionCount);
    return ListTile(
      title: Text(item.title),
      subtitle: Text(subtitle),
      trailing: PopupMenuButton<FormOptionAction>(
        onSelected: (action) => onActionSelected(context, action),
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<FormOptionAction>>[
          PopupMenuItem<FormOptionAction>(
            value: FormOptionAction.edit,
            child: Text(S.of(context).form_action_edit),
          ),
          PopupMenuItem<FormOptionAction>(
            value: FormOptionAction.seeResponse,
            child: Text(S.of(context).form_action_see_response),
          ),
          PopupMenuItem<FormOptionAction>(
            value: FormOptionAction.createResponse,
            child: Text(S.of(context).form_action_create_response),
          ),
          PopupMenuItem<FormOptionAction>(
            value: FormOptionAction.delete,
            child: Text(S.of(context).form_action_delete),
          ),
        ],
      ),
    );
  }
}
