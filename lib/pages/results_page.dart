import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:communauto_calc/includes/trip_parameters.dart';
import 'package:communauto_calc/components/grid_list.dart';
import 'package:communauto_calc/includes/http_get_rates.dart';
import 'dart:io';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)!.settings.arguments as TripParameters;
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: Text(i18n.compareTripRates),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: HttpGetRates().getJSONData(params),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  //  TODO: Figure out why linter sees a possibility of this being null and thus remove hack -> "?? []"
                  child: GridListResults(key: null, data: snapshot.data ?? []));
            } else if (snapshot.hasError) {
              var errorMsg = "Unhandled exception: ${snapshot.error}";
              if (snapshot.error is SocketException) {
                //treat SocketException
                errorMsg = i18n.noConnectionError;
              } else if (snapshot.error is HttpException) {
                errorMsg = "Http exception: ${snapshot.error}}";
              }
              return Center(child: Text(errorMsg));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
