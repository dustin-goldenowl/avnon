import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';
import 'package:flutter_form_google/src/model/form_data_model.dart';
import 'package:flutter_form_google/src/route/coordinator.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit() : super(CreateFormState.ds()) {
    _initEmptyForm();
  }

  _initEmptyForm() {
    emit(state.copyWith(listFormData: [MQuestion.empty()]));
  }

  void addNewForm() {
    List<MQuestion> updatedList = List.from(state.listFormData);
    updatedList.add(MQuestion.empty());
    emit(state.copyWith(listFormData: updatedList));
  }

  void removeFormWithPosition(int position) {
    List<MQuestion> updatedList = List.from(state.listFormData);
    updatedList.removeAt(position);
    emit(state.copyWith(listFormData: updatedList));
  }

  void isEditTitleForm() {
    emit(state.copyWith(isEditTitile: true));
  }

  void onDoneChangeEditTitleForm() {
    emit(state.copyWith(isEditTitile: false));
  }

  void onChangeTitleForm(String value) {
    emit(state.copyWith(titleForm: value));
  }

  void editQuestion(int index, String value) {
    state.listFormData[index] =
        state.listFormData[index].copyWith(question: value);
    emit(state.copyWith(listFormData: state.listFormData.toList()));
  }

  void addOptionQuestion(int index) {
    var list = state.listFormData.toList();
    var data = list[index];
    list[index] = list[index].copyWith(
        resultOption: data.resultOption.toList()
          ..add("Option ${data.resultOption.length + 1}"));
    emit(state.copyWith(listFormData: list.toList()));
  }

  void changeOptionQuestion({required int index, required int indexSelected}) {
    var list = state.listFormData.toList();
    var data = list[index];
    data = data.copyWith(indexSelected: indexSelected);
    list[index] = data;
    emit(state.copyWith(listFormData: List.from(list)));
  }

  void updateResultOption(
      {required int index,
      required int indexSelected,
      required String result}) {
    var list = state.listFormData.toList();
    var data = list[index];
    var option = data.resultOption[indexSelected];
    option = result;

    data.resultOption[indexSelected] = option;

    data = data.copyWith(resultOption: data.resultOption);
    list[index] = data;
    emit(state.copyWith(listFormData: List.from(list)));
  }

  void duplicateQuestion(int position) {
    List<MQuestion> listUpdated = List.from(state.listFormData);
    listUpdated.add(state.listFormData[position]);
    emit(state.copyWith(listFormData: listUpdated));
  }

  void isRequiredForm({required int position, required bool isRequired}) {
    List<MQuestion> listUpdated = List.from(state.listFormData);
    listUpdated[position] =
        listUpdated[position].copyWith(isRequired: isRequired);
    emit(state.copyWith(listFormData: listUpdated));
  }

  void selectQuestionOption({required int position, required int value}) {
    List<MQuestion> listUpdated = List.from(state.listFormData);
    listUpdated[position] =
        listUpdated[position].copyWith(optionQuestion: value);
    emit(state.copyWith(listFormData: listUpdated));
  }
}
