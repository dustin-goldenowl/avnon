// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_response_bloc.dart';

class CreateResponseState extends Equatable {
  final MFormData formData;
  final MFormAnswer answers;
  const CreateResponseState({
    required this.formData,
    required this.answers,
  });
  factory CreateResponseState.init(MFormData formData) {
    return CreateResponseState(
      formData: formData,
      answers: MFormAnswer(
        id: const Uuid().v4(),
        fromId: formData.id,
        question: List.generate(formData.questions.length,
            (index) => MQuestionAnswer.create(index)),
      ),
    );
  }

  @override
  List<Object?> get props => [formData, answers];

  CreateResponseState copyWith({
    MFormData? formData,
    MFormAnswer? answers,
  }) {
    return CreateResponseState(
      formData: formData ?? this.formData,
      answers: answers ?? this.answers,
    );
  }
}
