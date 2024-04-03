import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit(MFormData? mFormData) : super(CreateFormState.ds(mFormData));

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

  void editFormData(MFormData mFormData) {
    emit(state.copyWith(
        titleForm: mFormData.title, listFormData: mFormData.questions));
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

  void addOptionQuestion(int index, bool isAddOther) {
    var list = state.listFormData.toList();
    var data = list[index];
    list[index] = list[index].copyWith(
        resultOption: data.resultOption.toList()
          ..add(isAddOther && !data.resultOption.contains("Others")
              ? "Others"
              : "Option ${data.resultOption.length + 1}"));
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
    listUpdated[position] = listUpdated[position].copyWith(
      isRequired: isRequired,
    );
    emit(state.copyWith(listFormData: listUpdated));
  }

  void selectQuestionOption({required int position, required int value}) {
    List<MQuestion> listUpdated = List.from(state.listFormData);
    listUpdated[position] =
        listUpdated[position].copyWith(optionQuestion: value);
    emit(state.copyWith(listFormData: listUpdated));
  }

  void onChangeParagraph({required String value, required int position}) {
    List<MQuestion> listUpdated = List.from(state.listFormData);
    listUpdated[position] =
        listUpdated[position].copyWith(resultParagraph: value);
    emit(state.copyWith(listFormData: listUpdated));
  }
}
