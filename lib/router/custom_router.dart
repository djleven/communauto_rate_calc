import 'package:flutter/material.dart';
import 'package:communauto_calc/pages/home_page.dart';
import 'package:communauto_calc/pages/results_page.dart';
import 'package:communauto_calc/pages/about_page.dart';
import 'package:communauto_calc/pages/not_found_page.dart';
import 'package:communauto_calc/pages/settings_page.dart';
import 'package:communauto_calc/router/route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case resultsRoute:
        return MaterialPageRoute(
          builder: (_) => const ResultsPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
