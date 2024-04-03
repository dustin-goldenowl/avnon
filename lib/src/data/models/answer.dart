// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_form_google/src/data/models/question_type.dart';

class MAnswer {
  String option;
  String result;

  MAnswer({this.option = '', this.result = ''});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'option': option,
      'result': result,
    };
  }

  factory MAnswer.fromMap(Map<String, dynamic> map) {
    return MAnswer(
      option: map['option'] as String,
      result: map['result'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MAnswer.fromJson(String source) =>
      MAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MQuestionAnswer {
  String question;
  int id;
  MQuestionType type;
  List<MAnswer> answers;

  MAnswer get answer {
    if (answers.isEmpty) {
      answers = [MAnswer()];
    }
    return answers[0];
  }

  set answer(MAnswer answer) {
    answers = [answer];
  }

  MQuestionAnswer({
    required this.id,
    required this.question,
    required this.type,
    required this.answers,
  });

  bool enableButton() {
    if (type == MQuestionType.paragraph) {
      return true;
    }
    return answers.isNotEmpty;
  }

  bool validate() {
    switch (type) {
      case MQuestionType.paragraph:
        return answer.option.isNotEmpty;
      case MQuestionType.multipleChoice:
        return answers.isNotEmpty;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'id': id,
      'type': type.toMap(),
      'answers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory MQuestionAnswer.fromMap(Map<String, dynamic> map) {
    return MQuestionAnswer(
      question: map['question'] as String,
      id: map['id'] as int,
      type: MQuestionType.fromMap(map['type'] as String),
      answers: List<MAnswer>.from(
        (map['answers'] as List<int>).map<MAnswer>(
          (x) => MAnswer.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MQuestionAnswer.fromJson(String source) =>
      MQuestionAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}
