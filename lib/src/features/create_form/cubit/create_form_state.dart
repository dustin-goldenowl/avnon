import 'package:equatable/equatable.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';

class CreateFormState extends Equatable {
  final List<MQuestion> listFormData;
  final String titleForm;
  final bool isEditTitile;
  const CreateFormState({
    required this.listFormData,
    required this.titleForm,
    required this.isEditTitile,
  });

  bool get isEmptyForm {
    bool isEmpty = false;
    if (titleForm == "Untitled form") return true;

    for (var item in listFormData) {
      if (item.question.isEmpty) isEmpty = true;
      if (item.optionQuestion == 2 && item.resultParagraph.isEmpty) {
        isEmpty = true;
      }
    }

    return isEmpty;
  }

  factory CreateFormState.ds(MFormData? mFormData) {
    if (mFormData != null) {
      return CreateFormState(
          listFormData: mFormData.questions,
          titleForm: mFormData.title,
          isEditTitile: false);
    } else {
      return CreateFormState(
          listFormData: [MQuestion.empty()],
          titleForm: "Untitled form",
          isEditTitile: false);
    }
  }

  CreateFormState copyWith({
    List<MQuestion>? listFormData,
    String? titleForm,
    bool? isEditTitile,
  }) {
    return CreateFormState(
      listFormData: listFormData ?? this.listFormData,
      titleForm: titleForm ?? this.titleForm,
      isEditTitile: isEditTitile ?? this.isEditTitile,
    );
  }

  @override
  List<Object> get props => [
        listFormData,
        isEditTitile,
        titleForm,
      ];
}
