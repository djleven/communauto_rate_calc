import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:communauto_calc/components/language_picker.dart';
import 'package:communauto_calc/components/main_menu_list.dart';
import 'package:communauto_calc/components/trip_params_form.dart';
import 'package:communauto_calc/includes/trip_parameters.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var params = TripParameters();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.homePage),
      ),
      drawer: const Drawer(
        child: MainMenuList(),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(8.0),
        child: LanguagePicker(),
      ),
      body: Column(
        //ROW 1
        children: <Widget>[
          const SizedBox(
            height: 100, // constrain height
            child: Image(image: AssetImage('assets/app-logo.png')),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: const TripParametersForm(),
            ),
          ),
        ],
      ),
    );
  }
}
