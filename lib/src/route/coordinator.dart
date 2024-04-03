import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/features/create_form/create_form_page.dart';
import 'package:flutter_form_google/src/features/response/response_page.dart';

class AppCoordinator {
  static showCreateForm(BuildContext context) {
    Navigator.restorablePushNamed(context, CreateFormPage.routeName);
  }

  static showResponse(BuildContext context) {
    Navigator.restorablePushNamed(context, ResponsePage.routeName);
  }
}
