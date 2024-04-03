// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_form_google/src/data/models/question_type.dart';
import 'package:uuid/uuid.dart';

class MQuestion {
  final String id;
  final String question;
  final List<String> resultOption;
  final bool hasOther;
  final bool isRequired;
  final String resultParagraph;
  final int indexSelected;
  final MQuestionType type;

  bool get enableRemoveOption => resultOption.length > 2;

  MQuestion({
    required this.id,
    required this.question,
    required this.resultOption,
    required this.hasOther,
    required this.isRequired,
    required this.type,
    required this.resultParagraph,
    required this.indexSelected,
  });

  static MQuestion empty() {
    return MQuestion(
      id: const Uuid().v4(),
      question: "",
      resultOption: ["Option 1", "Option 2"],
      isRequired: false,
      hasOther: false,
      type: MQuestionType.multipleChoice,
      resultParagraph: '',
      indexSelected: -1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'resultOption': resultOption,
      'hasOther': hasOther,
      'isRequired': isRequired,
      'indexSelected': indexSelected,
      'resultParagraph': resultParagraph,
      'type': type.toMap(),
    };
  }

  factory MQuestion.fromMap(Map<String, dynamic> map) {
    return MQuestion(
      id: map['id'] as String? ?? '',
      question: map['question'] as String,
      indexSelected: map['indexSelected'] as int? ?? -1,
      resultParagraph: map['resultParagraph'] as String? ?? '',
      resultOption: (map['resultOption'] is List)
          ? (map['resultOption'] as List).map((e) => '$e').toList()
          : [],
      hasOther: map['hasOther'] as bool,
      isRequired: map['isRequired'] as bool,
      type: MQuestionType.fromMap(map['type'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MQuestion.fromJson(String source) =>
      MQuestion.fromMap(json.decode(source) as Map<String, dynamic>);

  MQuestion copyWith({
    String? id,
    String? question,
    List<String>? resultOption,
    bool? hasOther,
    bool? isRequired,
    String? resultParagraph,
    int? indexSelected,
    MQuestionType? type,
  }) {
    return MQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      resultOption: resultOption ?? this.resultOption,
      hasOther: hasOther ?? this.hasOther,
      isRequired: isRequired ?? this.isRequired,
      resultParagraph: resultParagraph ?? this.resultParagraph,
      indexSelected: indexSelected ?? this.indexSelected,
      type: type ?? this.type,
    );
  }
}
