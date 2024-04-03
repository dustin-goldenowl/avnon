import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/features/create_form/create_form_page.dart';
import 'package:flutter_form_google/src/features/home/home_page.dart';
import 'package:flutter_form_google/src/features/response/response_page.dart';
import 'package:flutter_form_google/src/features/settings/settings_controller.dart';
import 'package:flutter_form_google/src/features/settings/settings_view.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case SettingsView.routeName:
            return SettingsView(controller: GetIt.I<SettingsController>());
          case CreateFormPage.routeName:
            return const CreateFormPage();
          case ResponsePage.routeName:
            return const ResponsePage();
          case HomePage.routeName:
          default:
            return const HomePage();
        }
      },
    );
  }
}