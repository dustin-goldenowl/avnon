import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:uuid/uuid.dart';

part 'create_response_state.dart';

class CreateResponseBLoc extends Cubit<CreateResponseState> {
  CreateResponseBLoc(MFormData formData)
      : super(CreateResponseState.init(formData));

  void onChangeParagraph({required String value, required int position}) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated[position] =
        listUpdated[position].copyWith(resultParagraph: value);
    emit(state.copyWith(questions: listUpdated));
  }

  void onUpdateAnswer({required int index, required int indexSelected}) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated[index] = listUpdated[index]
        .copyWith(indexSelected: indexSelected, groupValue: "-1");
    emit(state.copyWith(questions: listUpdated));
  }

  void onChangeOtherValue({required String value, required int position}) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated[position] = listUpdated[position]
        .copyWith(valueOther: value, groupValue: value, indexSelected: -1);
    emit(state.copyWith(questions: listUpdated));
  }

  void onSubmitFormData(BuildContext context) {
    Navigator.pop(context);
    context.read<HomeBloc>().addNewResult(MFormData(
          id: const Uuid().v4(),
          title: state.formData.title,
          questions: state.questions,
          isResult: true,
        ));
  }
}
