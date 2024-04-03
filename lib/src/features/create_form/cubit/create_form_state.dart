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
    if (titleForm == "Untitled form") return true;
    return questions.any((element) => element.question.isEmpty);
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
