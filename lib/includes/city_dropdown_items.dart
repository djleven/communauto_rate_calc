import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<DropdownMenuItem<int>> loadCityList(BuildContext context) {
  List<DropdownMenuItem<int>> cityList = [];

  final i18n = AppLocalizations.of(context)!;

  cityList.add(DropdownMenuItem(
    value: 107,
    child: Text(i18n.calgary),
  ));
  cityList.add(DropdownMenuItem(
    value: 106,
    child: Text(i18n.edmonton),
  ));
  cityList.add(DropdownMenuItem(
    value: 92,
    child: Text(i18n.halifax),
  ));
  cityList.add(DropdownMenuItem(
    value: 103,
    child: Text(i18n.restOfOntario),
  ));
  cityList.add(DropdownMenuItem(
    value: 105,
    child: Text(i18n.toronto),
  ));
  cityList.add(DropdownMenuItem(
    value: 94,
    child: Text(i18n.gatineau),
  ));
  cityList.add(DropdownMenuItem(
    value: 59,
    child: Text(i18n.montreal),
  ));
  cityList.add(DropdownMenuItem(
    value: 90,
    child: Text(i18n.quebec),
  ));
  cityList.add(DropdownMenuItem(
    value: 2089,
    child: Text(i18n.sherbrooke),
  ));

  return cityList;
}
