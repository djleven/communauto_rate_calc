import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageCodeStringConst = 'languageCode';

const String englishCode = 'en';
const String frenchCode = 'fr';
const Locale english = Locale('en', '');
const Locale french = Locale('fr', '');

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCodeStringConst, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String code = prefs.getString(languageCodeStringConst) ?? "en";
  return _locale(code);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case frenchCode:
      return french;
    default:
      return english;
  }
}
