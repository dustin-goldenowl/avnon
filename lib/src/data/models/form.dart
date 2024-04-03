// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_form_google/src/data/models/question.dart';

class MFormData {
  final String id;
  final String title;
  final List<MQuestion> questions;
  MFormData({
    required this.id,
    required this.title,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory MFormData.fromMap(Map<String, dynamic> map) {
    return MFormData(
      id: map['id'] as String,
      title: map['title'] as String,
      questions: List<MQuestion>.from(
        (map['questions'] as List).map<MQuestion>(
          (x) => MQuestion.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MFormData.fromJson(String source) =>
      MFormData.fromMap(json.decode(source) as Map<String, dynamic>);
}
