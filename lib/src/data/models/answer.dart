// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_form_google/src/data/models/answer_type.dart';
import 'package:flutter_form_google/src/data/models/question_type.dart';

class MFormAnswer {
  final String id;
  final String fromId;
  final List<MQuestionAnswer> question;
  MFormAnswer({
    required this.id,
    required this.fromId,
    required this.question,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fromId': fromId,
      'question': question.map((x) => x.toMap()).toList(),
    };
  }

  factory MFormAnswer.fromMap(Map<String, dynamic> map) {
    return MFormAnswer(
      id: map['id'] as String,
      fromId: map['fromId'] as String,
      question: List<MQuestionAnswer>.from(
        (map['question'] as List<int>).map<MQuestionAnswer>(
          (x) => MQuestionAnswer.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MFormAnswer.fromJson(String source) =>
      MFormAnswer.fromMap(json.decode(source) as Map<String, dynamic>);

  MFormAnswer copyWith({
    String? id,
    String? fromId,
    List<MQuestionAnswer>? question,
  }) {
    return MFormAnswer(
      id: id ?? this.id,
      fromId: fromId ?? this.fromId,
      question: question ?? this.question,
    );
  }
}

class MAnswer {
  String option;
  MAnswerType answerType;

  MAnswer({this.option = '', this.answerType = MAnswerType.type});
  factory MAnswer.select(String value) =>
      MAnswer(option: value, answerType: MAnswerType.select);
  factory MAnswer.type(String value) =>
      MAnswer(option: value, answerType: MAnswerType.type);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'option': option,
      'answerType': answerType.toMap(),
    };
  }

  MAnswer copyWith({
    String? option,
    MAnswerType? answerType,
  }) {
    return MAnswer(
      option: option ?? this.option,
      answerType: answerType ?? this.answerType,
    );
  }

  factory MAnswer.fromMap(Map<String, dynamic> map) {
    return MAnswer(
      option: map['option'] as String,
      answerType: MAnswerType.fromMap(map['result'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MAnswer.fromJson(String source) =>
      MAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MQuestionAnswer {
  String question;
  int id;
  MAnswer answer;

  MQuestionAnswer({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory MQuestionAnswer.create(int index) {
    return MQuestionAnswer(id: index, question: '', answer: MAnswer());
  }

  bool validate(MQuestionType type) {
    switch (type) {
      case MQuestionType.paragraph:
        return answer.option.isNotEmpty;
      case MQuestionType.multipleChoice:
        return answer.option.isNotEmpty;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'id': id,
      'answer': answer.toMap(),
    };
  }

  factory MQuestionAnswer.fromMap(Map<String, dynamic> map) {
    return MQuestionAnswer(
      question: map['question'] as String,
      id: map['id'] as int,
      answer: MAnswer.fromMap(map['answer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MQuestionAnswer.fromJson(String source) =>
      MQuestionAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}
