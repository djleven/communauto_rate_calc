// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:communauto_calc/includes/service_plans.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GridListResults extends StatelessWidget {
  const GridListResults({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  final double runSpacing = 16;
  final double spacing = 8;
  final int listSize = 5;
  final columns = 2;

  @override
  Widget build(BuildContext context) {
    final List<ServicePlan> ratePlans = populateServicePlans(context, data);

    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: ratePlans.map<Widget>((card) {
          return SizedBox(
            width: w,
            child: GridCardItem(
              card: card,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class GridTitleText extends StatelessWidget {
  const GridTitleText(this.text, this.style, {super.key});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.center,
      child: Text(text, style: style),
    );
  }
}

class GridPlanItem extends StatelessWidget {
  const GridPlanItem({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final RatePlan plan;
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 0.25,
          ),
          shape: BoxShape.rectangle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 3.0,
            )
          ],
        ),
        child: Container(
            padding: const EdgeInsets.fromLTRB(12, 22, 12, 14),
            child: Column(
              children: [
                Text(plan.title),
                Text("\$${plan.totalCost.toString()}"),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        GridTitleText(
                            "${i18n.durationCost}: \$${plan.durationCost.toString()}",
                            const TextStyle(fontSize: 10)),
                        GridTitleText(
                            "${i18n.distanceCost}: \$${plan.distanceCost.toString()}",
                            const TextStyle(fontSize: 10)),
                      ],
                    )),
              ],
            )));
  }
}

class GridCardItem extends StatelessWidget {
  const GridCardItem({
    Key? key,
    required this.card,
  }) : super(key: key);

  final ServicePlan card;

  Color getBackgroundColor(ServiceFamily type) {
    if (type == ServiceFamily.open) {
      return Colors.grey;
    }
    return Colors.green;
  }

  Color getFontColor(ServiceFamily type) {
    if (type == ServiceFamily.open) {
      return Colors.black;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 18) / 4;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              color: getFontColor(card.packageFamily),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: getBackgroundColor(card.packageFamily),
                title: GridTitleText(card.title, null),
              ),
            ),
          ),
          DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 0.25,
              ),
              shape: BoxShape.rectangle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromARGB(102, 243, 233, 233),
                  blurRadius: 3.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: card.ratePlans.map<Widget>((plan) {
                return SizedBox(
                  width: w,
                  child: GridPlanItem(
                    plan: plan,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
