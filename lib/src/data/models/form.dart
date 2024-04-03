import 'package:flutter_form_google/src/data/models/question.dart';

class MFormData {
  final String title;
  final List<MQuestion> questions;
  MFormData({
    required this.title,
    required this.questions,
  });
}
