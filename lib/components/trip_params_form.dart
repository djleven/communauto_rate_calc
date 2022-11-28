import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:communauto_calc/router/route_constants.dart';
import 'package:communauto_calc/includes/trip_parameters.dart';
import 'package:communauto_calc/includes/city_dropdown_items.dart';

class TripParametersForm extends StatefulWidget {
  const TripParametersForm({super.key});

  @override
  State<TripParametersForm> createState() => _TripParametersFormState();
}

class _TripParametersFormState extends State<TripParametersForm> {
  final _formKey = GlobalKey<FormState>();

  TripParameters params = TripParameters();
  var startDateTxt = TextEditingController();
  var endDateTxt = TextEditingController();
  var distanceInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loadCityList(context);
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(context),
        ));
  }

  List<Widget> getFormWidget(BuildContext context) {
    List<Widget> formWidget = [];
    final i18n = AppLocalizations.of(context)!;

    Future<void> selectDate(BuildContext context, bool isStartDate) async {
      DateTime initialDate = params.startDate;
      DateTime lastDate = isStartDate
          ? DateTimeUtils.addYearToDateTime(initialDate)
          : DateTimeUtils.addMonthToDateTime(initialDate);

      final DateTime? datePicked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: initialDate,
          lastDate: lastDate);
      if (datePicked != null) {
        final TimeOfDay? timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate),
        );
        if (timePicked != null) {
          setState(() {
            DateTime dateTimeSelected =
                DateTimeUtils.nearestQuarterHourDateTime(DateTime(
                    datePicked.year,
                    datePicked.month,
                    datePicked.day,
                    timePicked.hour,
                    timePicked.minute));
            String dateTimeDisplayed =
                DateTimeUtils.getDateTimeLabel(dateTimeSelected);
            if (isStartDate) {
              params.startDate = dateTimeSelected;
              startDateTxt.text = dateTimeDisplayed;
            } else {
              params.endDate = dateTimeSelected;
              endDateTxt.text = dateTimeDisplayed;
            }
          });
        }
      }
    }

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        Navigator.pushNamed(
          context,
          resultsRoute,
          arguments: params,
        );
      }
    }

    validateDate(String? value, bool isStartDate) {
      String label = isStartDate ? i18n.startDate : i18n.endDate;
      String msg = i18n.validationFieldError(label);
      if (value!.isEmpty) {
        return msg;
      }
      bool isValid = isStartDate
          ? params.startDate.isBefore(params.endDate)
          : params.endDate.isAfter(params.startDate);

      if (!isValid) {
        return msg;
      }
      return null;
    }

    validateStartDate(
      String? value,
    ) {
      return validateDate(value, true);
    }

    validateEndDate(String? value) {
      return validateDate(value, false);
    }

    formWidget.add(DropdownButtonFormField(
      iconSize: 24.0,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 22, 12, 14),
        border: OutlineInputBorder(),
      ),
      hint: Text(i18n.city),
      elevation: 16,
      items: loadCityList(context),
      value: params.selectedCity,
      onChanged: (value) {
        setState(() {
          params.selectedCity = int.parse(value.toString());
        });
      },
      onTap: () {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text(
            i18n.restOfOntarioExplanation,
          )));
      },
      isExpanded: true,
    ));

    formWidget.add(TextFormField(
      decoration: InputDecoration(labelText: i18n.startDate),
      validator: validateStartDate,
      readOnly: true,
      onTap: () => selectDate(context, true),
      controller: startDateTxt
        ..text = DateTimeUtils.getDateTimeLabel(params.startDate),
    ));

    formWidget.add(TextFormField(
      decoration: InputDecoration(labelText: i18n.endDate),
      readOnly: true,
      onTap: () => selectDate(context, false),
      validator: validateEndDate,
      controller: endDateTxt
        ..text = DateTimeUtils.getDateTimeLabel(params.endDate),
    ));

    formWidget.add(TextFormField(
      decoration: InputDecoration(
          hintText: i18n.hintDistance, labelText: i18n.distance),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: distanceInput..text = params.distance.toString(),
      validator: (value) {
        if (value!.isEmpty) {
          return i18n.validationFieldError(i18n.distance);
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          params.distance = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(CheckboxListTile(
      value: params.excludePromos,
      onChanged: (value) {
        setState(() {
          params.excludePromos = value.toString().toLowerCase() == 'true';
        });
      },
      title: Text(
        i18n.excludePromo,
      ),
      checkColor: const Color(0xFF000000),
      controlAffinity: ListTileControlAffinity.platform,
    ));

    formWidget.add(ElevatedButton(
        onPressed: onPressedSubmit, child: Text(i18n.submitInfo)));

    return formWidget;
  }
}
