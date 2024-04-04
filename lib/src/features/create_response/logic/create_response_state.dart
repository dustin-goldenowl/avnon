// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_response_bloc.dart';

class CreateResponseState extends Equatable {
  final MFormData formData;
  final List<MQuestion> questions;
  const CreateResponseState({
    required this.formData,
    required this.questions,
  });
  factory CreateResponseState.init(MFormData formData) {
    return CreateResponseState(
      formData: formData,
      questions: formData.questions,
    );
  }

  bool get isValid {
    bool isEnable = false;
    for (var item in questions) {
      if (item.hasOther && item.valueOther.isNotEmpty) {
        isEnable = true;
      }

      if (!item.hasOther && item.indexSelected != -1) {
        isEnable = true;
      }

      if (item.resultParagraph.isEmpty) {
        isEnable = false;
      } else {
        isEnable = true;
      }
    }

    return isEnable;
  }

  @override
  List<Object?> get props => [
        formData,
        questions,
      ];

  CreateResponseState copyWith({
    MFormData? formData,
    List<MQuestion>? questions,
  }) {
    return CreateResponseState(
      formData: formData ?? this.formData,
      questions: questions ?? this.questions,
    );
  }
}
