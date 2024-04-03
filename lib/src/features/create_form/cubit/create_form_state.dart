import 'package:equatable/equatable.dart';
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

  factory CreateFormState.ds() {
    return const CreateFormState(
        listFormData: [], titleForm: "Untitled form", isEditTitile: false);
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
