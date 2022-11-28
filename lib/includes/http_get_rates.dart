import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:communauto_calc/includes/trip_parameters.dart';

class HttpGetRates {
  HttpGetRates();
  final basePath = "restapifrontoffice.reservauto.net";
  final endpoint = "/api/v2/Billing/TripCostEstimate";

  List data = [];
  Future<List<dynamic>> getJSONData(TripParameters params) async {
    final queryParameters = {
      'CityId': params.selectedCity.toString(),
      'StartDate': params.startDate.toIso8601String(),
      'EndDate': params.endDate.toIso8601String(),
      'Distance': params.distance.toString(),
      // 'AcceptLanguage': 'en',
      'ExcludePromotion': params.excludePromos.toString(),
    };

    final uri = Uri.https(basePath, endpoint, queryParameters);
    var response = await http.get(uri, headers: {"Accept": "application/json"});

    try {
      if (response.statusCode == 200) {
        var dataConvertedToJSON = json.decode(response.body);

        return dataConvertedToJSON['tripPackageCostEstimateList'];
      }
    } catch (e) {
      // print(e);
    }
    throw Exception('Failed to load cost data');
  }
}
