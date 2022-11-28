import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ServiceFamily {
  open,
  value,
}

enum ServiceType {
  StationBased,
  FreeFloating,
}

class ServicePlan {
  final String title;
  final ServiceFamily packageFamily;
  final int packageId;
  final List<RatePlan> ratePlans = [];

  ServicePlan({
    required this.title,
    required this.packageFamily,
    required this.packageId,
  });

  void addRatePlan(RatePlan ratePlan) {
    ratePlans.add(ratePlan);
  }
}

class RatePlan {
  final int packageId;
  final ServiceType serviceType;
  late String title;
  double distanceCost;
  double durationCost;
  double totalCost;

  RatePlan({
    required this.serviceType,
    required this.packageId,
    this.distanceCost = 0,
    this.durationCost = 0,
    this.totalCost = 0,
    required BuildContext context,
  }) {
    title = getTitle(context);
  }

  String getTitle(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    if (serviceType == ServiceType.StationBased) {
      return i18n.modeFlex;
    }
    return i18n.modeRoundTrip;
  }
}

List<ServicePlan> getServicePlans(BuildContext context) {
  final i18n = AppLocalizations.of(context)!;

  return [
    ServicePlan(
      title: i18n.planOpen,
      packageId: 8,
      packageFamily: ServiceFamily.open,
    ),
    ServicePlan(
      title: i18n.planOpenPlus,
      packageId: 4,
      packageFamily: ServiceFamily.open,
    ),
    ServicePlan(
      title: i18n.planValue,
      packageId: 3,
      packageFamily: ServiceFamily.value,
    ),
    ServicePlan(
      title: i18n.planValuePlus,
      packageId: 2,
      packageFamily: ServiceFamily.value,
    ),
    ServicePlan(
      title: i18n.planValueExtra,
      packageId: 1,
      packageFamily: ServiceFamily.value,
    ),
  ];
}

List<ServicePlan> populateServicePlans(
    BuildContext context, List<dynamic> data) {
  List<ServicePlan> servicePlans = getServicePlans(context);

// as of DArt 2.1 https://medium.com/dartlang/dart-2-15-7e7a598e508a
  final serviceTypeEnumStringMap = ServiceType.values.asNameMap();

  for (var servicePlan in servicePlans) {
    int plansCreated = 0;
    for (var i = 0; i < data.length; i++) {
      var plan = data[i];

      if (servicePlan.packageId == plan['packageId']) {
        ServiceType? serviceType =
            serviceTypeEnumStringMap[plan["serviceType"]];
        if (serviceType == null) {
          continue;
        }
        RatePlan ratePlan = RatePlan(
            serviceType: serviceType,
            packageId: servicePlan.packageId,
            distanceCost: plan['distanceCost'].toDouble(),
            durationCost: plan['durationCost'].toDouble(),
            totalCost: plan['totalCost'].toDouble(),
            context: context);

        servicePlan.ratePlans.add(ratePlan);
        // remove plan from data, no need to iterate over it again
        // data.removeWhere((p) =>
        //     p["packageId"] == plan["packageId"] &&
        //     serviceTypeEnumStringMap[p["serviceType"]] == plan["serviceType"]);
        plansCreated++;
      }
      if (plansCreated == 2) {
        plansCreated = 0;
        break;
      }
    }
  }

  return servicePlans;
}
