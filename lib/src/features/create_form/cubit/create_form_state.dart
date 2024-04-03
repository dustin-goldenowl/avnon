import 'package:equatable/equatable.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';

class CreateFormState extends Equatable {
  final List<MQuestion> questions;
  final String titleForm;
  final bool isEditTitle;
  const CreateFormState({
    required this.questions,
    required this.titleForm,
    this.isEditTitle = false,
  });

  bool get isEmptyForm {
    bool isEmpty = false;
    if (titleForm.isEmpty) return true;

    for (var item in questions) {
      if (item.question.isEmpty) isEmpty = true;
      if (item.optionQuestion == 2 && item.resultParagraph.isEmpty) {
        isEmpty = true;
      }
    }

    return isEmpty;
  }

  factory CreateFormState.ds(MFormData? editFormData) {
    if (editFormData != null) {
      return CreateFormState(
        questions: editFormData.questions,
        titleForm: editFormData.title,
      );
    } else {
      return CreateFormState(
          questions: [MQuestion.empty()], titleForm: "Untitled form");
    }
  }

  CreateFormState copyWith({
    List<MQuestion>? questions,
    String? titleForm,
    bool? isEditTitle,
  }) {
    return CreateFormState(
      questions: questions ?? this.questions,
      titleForm: titleForm ?? this.titleForm,
      isEditTitle: isEditTitle ?? this.isEditTitle,
    );
  }

  @override
  List<Object> get props => [
        questions,
        isEditTitle,
        titleForm,
      ];
}
