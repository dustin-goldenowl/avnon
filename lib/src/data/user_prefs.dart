import 'dart:convert';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class _keys {
  static const String from = 'from';
}

class UserPrefs {
  late SharedPreferences _prefs;
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // user
  void setForms(List<MFormData>? value) {
    if (value == null) {
      _prefs.remove(_keys.from);
    } else {
      _prefs.setString(_keys.from, jsonEncode(value.map((e) => e.toMap())));
    }
  }

  List<MFormData> getFrom() {
    final value = _prefs.getString(_keys.from) ?? '';
    try {
      if (value.isEmpty) {
        return [];
      } else {
        final map = jsonDecode(value);
        if (map is Iterable) {
          return map
              .map((e) => MFormData.fromMap(map as Map<String, dynamic>))
              .toList();
        } else {
          return [];
        }
      }
    } catch (e) {
      return [];
    }
  }
}