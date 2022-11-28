import 'package:flutter/material.dart';
import 'package:communauto_calc/localization/language.dart';
import 'package:communauto_calc/localization/language_constants.dart';
import 'package:communauto_calc/main.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  LanguagePickerState createState() => LanguagePickerState();
}

class LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
        underline: const SizedBox(),
        icon: const Icon(
          Icons.language,
          color: Colors.white,
        ),
        onChanged: (Language? language) async {
          if (language != null) {
            Locale _locale = await setLocale(language.languageCode);

            // When a BuildContext is used from a StatefulWidget, the mounted property
            // must be checked after an asynchronous gap.
            if (!mounted) return;

            MyApp.setLocale(context, _locale);
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
            .toList());
  }
}
