import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/user_prefs.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/features/settings/settings_controller.dart';
import 'src/features/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  final userPrefs = UserPrefs();
  await userPrefs.initialize();
  GetIt.I.registerSingleton(settingsController);
  GetIt.I.registerSingleton(userPrefs);

  runApp(MyApp(setting: settingsController));


}
