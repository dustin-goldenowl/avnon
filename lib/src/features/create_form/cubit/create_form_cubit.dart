import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/data/models/question_type.dart';
import 'package:flutter_form_google/src/features/create_form/cubit/create_form_state.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit(MFormData? editFormData)
      : super(CreateFormState.ds(editFormData));

  void addNewForm() {
    List<MQuestion> updatedList = List.from(state.questions);
    updatedList.add(MQuestion.empty());
    emit(state.copyWith(questions: updatedList));
  }

  void removeFormWithPosition(int position) {
    List<MQuestion> updatedList = List.from(state.questions);
    updatedList.removeAt(position);
    emit(state.copyWith(questions: updatedList));
  }

  void editFormData(MFormData mFormData) {
    emit(state.copyWith(
        titleForm: mFormData.title, questions: mFormData.questions));
  }

  void isEditTitleForm() {
    emit(state.copyWith(isEditTitle: true));
  }

  void onDoneChangeEditTitleForm() {
    emit(state.copyWith(isEditTitle: false));
  }

  void onChangeTitleForm(String value) {
    emit(state.copyWith(titleForm: value));
  }

  void editQuestion(int index, String value) {
    state.questions[index] = state.questions[index].copyWith(question: value);
    emit(state.copyWith(questions: state.questions.toList()));
  }

  void addOptionQuestion(int index) {
    var list = state.questions.toList();
    var data = list[index];
    list[index] = list[index].copyWith(
        resultOption: data.resultOption.toList()
          ..add("Option ${data.resultOption.length + 1}"));
    emit(state.copyWith(questions: list.toList()));
  }

  void onRemoveOptionQuestion(int index) {
    _updateQuestionAt(state.indexQuestion, (p0) {
      var options = p0.resultOption.toList();
      options.removeAt(index);
      return p0.copyWith(resultOption: options);
    });
  }

  void onChangeOptionOther(int index, bool value) {
    _updateQuestionAt(index, (e) => e.copyWith(hasOther: value));
  }

  void changeIndexOption(int index) {
    emit(state.copyWith(indexOption: index));
  }

  void changeIndexQuestion(int index) {
    emit(state.copyWith(indexQuestion: index, indexOption: 0));
  }

  void updateResultOption(
      {required int index,
      required int indexSelected,
      required String result}) {
    var list = state.questions.toList();
    var data = list[index];
    var option = data.resultOption[indexSelected];
    option = result;

    data.resultOption[indexSelected] = option;

    data = data.copyWith(resultOption: data.resultOption);
    list[index] = data;
    emit(state.copyWith(questions: List.from(list)));
  }


  void duplicateQuestion(int position) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated.insert(position, state.questions[position]);
    emit(state.copyWith(questions: listUpdated));
  }

  void isRequiredForm({required int position, required bool isRequired}) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated[position] = listUpdated[position].copyWith(
      isRequired: isRequired,
    );
    emit(state.copyWith(questions: listUpdated));
  }

  void selectQuestionOption(
      {required int position, required MQuestionType value}) {
    List<MQuestion> listUpdated = List.from(state.questions);
    listUpdated[position] = listUpdated[position].copyWith(type: value);
    emit(state.copyWith(questions: listUpdated));
  }

  void _updateQuestionAt(int index, MQuestion Function(MQuestion) onChange) {
    final list = [...state.questions];
    list[index] = onChange(list[index]);
    emit(state.copyWith(questions: list));
  }
}
