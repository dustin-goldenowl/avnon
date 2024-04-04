import 'dart:convert';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class _keys {
  static const String from = 'from';
  static String responseOf(String id) => 'response-$id';
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
      final data = jsonEncode(value.map((e) => e.toMap()).toList());
      _prefs.setString(_keys.from, data);
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
          return map.map((e) {
            return MFormData.fromMap(e as Map<String, dynamic>);
          }).toList();
        } else {
          return [];
        }
      }
    } catch (e) {
      return [];
    }
  }

  // setResponse
  void setResponse(String fromId, MFormData newResponse) {
    final responses = getResponse(fromId);
    responses.add(newResponse);
    final data = jsonEncode(responses.map((e) => e.toMap()).toList());
    _prefs.setString(_keys.responseOf(fromId), data);
  }

  List<MFormData> getResponse(String fromId) {
    final value = _prefs.getString(_keys.responseOf(fromId)) ?? '';
    try {
      if (value.isEmpty) {
        return [];
      } else {
        final map = jsonDecode(value);
        if (map is Iterable) {
          return map.map((e) {
            return MFormData.fromMap(e as Map<String, dynamic>);
          }).toList();
        } else {
          return [];
        }
      }
    } catch (e) {
      return [];
    }
  }
}
