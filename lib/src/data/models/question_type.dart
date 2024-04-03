enum MQuestionType {
  multipleChoice,
  paragraph;

  String toMap() {
    switch (this) {
      case MQuestionType.multipleChoice:
        return 'multipleChoice';
      default:
        return 'paragraph';
    }
  }

  static MQuestionType fromMap(String map) {
    switch (map) {
      case 'multipleChoice':
        return MQuestionType.multipleChoice;
      default:
        return MQuestionType.paragraph;
    }
  }
}
