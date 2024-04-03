import 'package:flutter_form_google/src/data/models/question_type.dart';

class MAnswer {
  String option;
  String result;

  MAnswer({this.option = '', this.result = ''});
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
  }) : answers = [];

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
}
