// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class MainLocalizations {
  MainLocalizations();

  static MainLocalizations? _current;

  static MainLocalizations get current {
    assert(_current != null,
        'No instance of MainLocalizations was loaded. Try to initialize the MainLocalizations delegate before accessing MainLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<MainLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = MainLocalizations();
      MainLocalizations._current = instance;

      return instance;
    });
  }

  static MainLocalizations of(BuildContext context) {
    final instance = MainLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of MainLocalizations present in the widget tree. Did you add MainLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static MainLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<MainLocalizations>(context, MainLocalizations);
  }

  /// `Hello from Main`
  String get greeting {
    return Intl.message(
      'Hello from Main',
      name: 'greeting',
      desc: 'A greeting message from the main module',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<MainLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<MainLocalizations> load(Locale locale) =>
      MainLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
