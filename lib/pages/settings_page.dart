import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:communauto_calc/localization/language.dart';
import 'package:communauto_calc/localization/language_constants.dart';
import 'package:communauto_calc/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.settings),
      ),
      body: Center(
          child: DropdownButton<Language>(
        iconSize: 30,
        hint: Text(i18n.changeLanguage),
        onChanged: (Language? language) async {
          if (language != null) {
            Locale locale = await setLocale(language.languageCode);

            // When a BuildContext is used from a StatefulWidget, the mounted property
            // must be checked after an asynchronous gap.
            if (!mounted) return;

            MyApp.setLocale(context, locale);
          }
        },
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
            .toList(),
      )),
    );
  }
}
