import 'dart:convert';

class MQuestion {
  final String question;
  final List<String> resultOption;
  final int indexSelected;
  final String resultParagraph;
  final String? image;
  final bool isRequired;
  final int optionQuestion;
  MQuestion({
    required this.question,
    required this.resultOption,
    required this.resultParagraph,
    this.image,
    required this.isRequired,
    required this.optionQuestion,
    required this.indexSelected,
  });

  MQuestion copyWith({
    String? question,
    List<String>? resultOption,
    String? resultParagraph,
    String? image,
    bool? isRequired,
    int? optionQuestion,
    int? indexSelected,
  }) {
    return MQuestion(
      question: question ?? this.question,
      resultOption: resultOption ?? this.resultOption,
      resultParagraph: resultParagraph ?? this.resultParagraph,
      image: image ?? this.image,
      isRequired: isRequired ?? this.isRequired,
      optionQuestion: optionQuestion ?? this.optionQuestion,
      indexSelected: indexSelected ?? this.indexSelected,
    );
  }

  static MQuestion empty() {
    return MQuestion(
      question: "",
      resultOption: ["Option 1", "Option 2"],
      resultParagraph: "",
      image: null,
      isRequired: false,
      optionQuestion: 1,
      indexSelected: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'resultOption': resultOption,
      'resultParagraph': resultParagraph,
      'image': image,
      'isRequired': isRequired,
      'optionQuestion': optionQuestion,
      'indexSelected': indexSelected,
    };
  }

  String toJson() => json.encode(toMap());

  factory MQuestion.fromMap(Map<String, dynamic> map) {
    return MQuestion(
      question: map['question'] as String,
      resultOption: List<String>.from((map['resultOption'] as List<String>)),
      resultParagraph: map['resultParagraph'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      isRequired: map['isRequired'] as bool,
      optionQuestion: map['optionQuestion'] as int,
      indexSelected: map['indexSelected'] as int,
    );
  }

  factory MQuestion.fromJson(String source) =>
      MQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}
