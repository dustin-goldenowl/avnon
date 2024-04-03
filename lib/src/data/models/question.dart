// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_form_google/src/data/models/question_type.dart';

class MQuestion {
  int id;
  MQuestionType type;
  String title;
  List<Option> option;

  MQuestion({
    required this.id,
    required this.type,
    required this.title,
    required this.option,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'option': option.map((x) => x.toMap()).toList(),
    };
  }

  factory MQuestion.fromMap(Map<String, dynamic> map) {
    return MQuestion(
      id: map['id'] as int,
      title: map['title'] as String,
      type: MQuestionType.fromMap(map['type'] as String),
      option: List<Option>.from(
        (map['option'] as List<int>).map<Option>(
          (x) => Option.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MQuestion.fromJson(String source) =>
      MQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Option {
  String title;
  bool otherSpecify;

  Option({required this.otherSpecify, required this.title});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'otherSpecify': otherSpecify,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      title: map['title'] as String,
      otherSpecify: map['otherSpecify'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);
}
