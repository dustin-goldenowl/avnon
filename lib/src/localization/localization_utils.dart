import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as al;

class S {
  static get delegate => al.AppLocalizations.delegate;
  static al.AppLocalizations of(BuildContext context) {
    return al.AppLocalizations.of(context)!;
  }
}
