
import 'package:flutter_form_google/src/data/models/form.dart';

abstract class FromRepository {
  void saveFrom(MFormData form);
  void deleteFrom(MFormData form);
  Future<List<MFormData>> getFroms();
  Future<MFormData> getFrom(int id);
}
