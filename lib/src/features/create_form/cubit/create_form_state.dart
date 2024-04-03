// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';

class CreateFormState extends Equatable {
  final List<MQuestion> questions;
  final String titleForm;
  final bool isEditTitle;
  final int indexQuestion;
  final int indexOption;
  const CreateFormState({
    required this.questions,
    required this.titleForm,
    this.indexQuestion = 0,
    this.indexOption = 0,
    this.isEditTitle = false,
  });

  bool get isEmptyForm {
    if (titleForm.isEmpty) return true;
    for (var item in questions) {
      if (item.question.isEmpty) return true;
    }
    return false;
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

  @override
  List<Object> get props => [
        questions,
        isEditTitle,
        titleForm,
        indexQuestion,
        indexOption,
      ];

  CreateFormState copyWith({
    List<MQuestion>? questions,
    String? titleForm,
    bool? isEditTitle,
    int? indexQuestion,
    int? indexOption,
  }) {
    return CreateFormState(
      questions: questions ?? this.questions,
      titleForm: titleForm ?? this.titleForm,
      isEditTitle: isEditTitle ?? this.isEditTitle,
      indexQuestion: indexQuestion ?? this.indexQuestion,
      indexOption: indexOption ?? this.indexOption,
    );
  }
}
