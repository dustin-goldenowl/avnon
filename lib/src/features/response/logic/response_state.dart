// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_bloc.dart';

class ResponseState extends Equatable {
  const ResponseState({
    required this.formData,
    required this.results,
  });

  final MFormData formData;
  final List<MFormData> results;

  List<MQuestion> responseOfQuestion(String id) {
    List<MQuestion> data = [];
    for (var result in results) {
      final question = result.questionOfId(id);
      if (question != null) {
        data.add(question);
      }
    }
    return data;
  }

  factory ResponseState.ds(MFormData formData, List<MFormData> results) {
    final froms = GetIt.I<UserPrefs>().getResponse(formData.id);
    return ResponseState(formData: formData, results: results);
  }

  @override
  List<Object?> get props => [formData, results];

  ResponseState copyWith({
    MFormData? formData,
    List<MFormData>? results,
  }) {
    return ResponseState(
      formData: formData ?? this.formData,
      results: results ?? this.results,
    );
  }
}
