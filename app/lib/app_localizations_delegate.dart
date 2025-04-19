import 'package:app/modules/common/l10n/generated/l10n.dart';
import 'package:app/modules/main/l10n/generated/l10n.dart';
import 'package:app/modules/onboard/l10n/generated/l10n.dart';
import 'package:app/modules/profile/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

class AppLocalizationsConfig {
  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      const [
        // Delegate của từng module
        OnboardLocalizations.delegate,
        CommonLocalizations.delegate,
        MainLocalizations.delegate,
        ProfileLocalizations.delegate,
        // DO NOT DELETE THIS COMMENT
      ];

  static Iterable<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('vi'),
        // Add more if needed
      ];
}
