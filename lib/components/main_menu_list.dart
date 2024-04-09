import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:communauto_calc/router/route_constants.dart';

class MainMenuList extends StatelessWidget {
  const MainMenuList({super.key});
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: SizedBox(
              height: 100,
              child: Image(image: AssetImage('assets/app-logo.png')),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              i18n.aboutUs,
              style: textStyle,
            ),
            onTap: () {
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              i18n.settings,
              style: textStyle,
            ),
            onTap: () {
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, settingsRoute);
            },
          ),
        ],
      ),
    );
  }
}
