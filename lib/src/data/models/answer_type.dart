enum MAnswerType {
  select,
  type;

  String toMap() {
    switch (this) {
      case MAnswerType.select:
        return 'select';
      default:
        return 'type';
    }
  }

  static MAnswerType fromMap(String map) {
    switch (map) {
      case 'select':
        return MAnswerType.select;
      default:
        return MAnswerType.type;
    }
  }
}
