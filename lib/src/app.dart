import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:flutter_form_google/src/localization/localization_utils.dart';
import 'package:flutter_form_google/src/route/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.setting});
  final SettingsController setting;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
      ],
      child: ListenableBuilder(
        listenable: setting,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', '')],
            onGenerateTitle: (BuildContext context) => S.of(context).app_title,
            theme:
                ThemeData(elevatedButtonTheme: const ElevatedButtonThemeData()),
            darkTheme: ThemeData.dark(),
            themeMode: setting.themeMode,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
