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
}

class Option {
  String title;
  bool otherSpecify;

  Option({required this.otherSpecify, required this.title});
}
