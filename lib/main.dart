import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/features/settings/settings_controller.dart';
import 'src/features/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  GetIt.I.registerSingleton(settingsController);

  runApp(const MyApp());
}
