import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/features/create_form/create_form_page.dart';
import 'package:flutter_form_google/src/features/create_response/create_response_page.dart';
import 'package:flutter_form_google/src/features/response/response_page.dart';

class AppCoordinator {
  static showCreateForm(BuildContext context, {MFormData? editItem}) {
    Navigator.pushNamed(
      context,
      CreateFormPage.routeName,
      arguments: editItem,
    );
  }

  static showResponse(BuildContext context,
      {required MFormData item, required List<MFormData> results}) {
    Navigator.pushNamed(context, ResponsePage.routeName, arguments: {
      'item': item,
      'result': results,
    });
  }

  static showCreateResponse(BuildContext context, {required MFormData item}) {
    Navigator.pushNamed(context, CreateResponsePage.routeName, arguments: item);
  }
}
