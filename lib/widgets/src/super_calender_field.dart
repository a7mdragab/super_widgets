import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:super_widgets/utils/constants.dart';
import 'package:super_widgets/utils/helpers.dart';

import 'super_decorated_container.dart';
import 'txt.dart';

final Widget daysOfWeekRowWidget =
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(7, (index) => Expanded(child: Center(child: Txt(daysNames[index], textAlign: TextAlign.center)))));

// ignore: must_be_immutable
class SuperVerticalPaginatedCalender extends StatelessWidget {
  SuperVerticalPaginatedCalender({Key? key, this.firstDate, this.endDate, this.selectedDate, this.padding = 8, this.locale = 'en', this.onDayPressed}) : super(key: key) {
    firstDate ??= DateTime.now();
    firstDate = getDateOnly(firstDate!);
    selectedDate ??= firstDate;

    selectedDate = getDateOnly(selectedDate!);
    if (selectedDate!.isBefore(firstDate!)) {
      selectedDate = firstDate!;
    }

    endDate ??= firstDate!.add(365.days);

    mSelectedDate.value = selectedDate!;
  }

  DateTime? firstDate;
  DateTime? endDate;
  DateTime? selectedDate;
  double padding = 8;
  String locale = 'en';
  void Function(DateTime)? onDayPressed;

  final mSelectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: daysOfWeekRowWidget,
        ),
        Expanded(
          child: PagedVerticalCalendar(
            minDate: firstDate,
            maxDate: endDate,
            initialDate: mSelectedDate.value,
            invisibleMonthsThreshold: 1,
            startWeekWithSunday: false,
            monthBuilder: (BuildContext context, int month, int year) => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Txt(
                  '(${monthsFullNames[month - 1 % 12]}) $year',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
            dayBuilder: (context, date) {
              return Obx(() {
                return SuperDecoratedContainer(
                  color: mSelectedDate.value == date ? Colors.lightBlue : Colors.transparent,
                  shape: BoxShape.circle,
                  child: Center(
                    child: Txt(
                      DateFormat('dd').format(date),
                      color: isDateInRange(firstDate!, endDate!, date) ? (mSelectedDate.value == date ? Colors.white : Get.theme.primaryColor) : Colors.grey,
                    ),
                  ),
                );
              });
            },
            onDayPressed: (DateTime day) {
              if (isDateInRange(firstDate!, endDate!, day)) {
                mSelectedDate.value = day;
                onDayPressed?.call(day);
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<DateTime?> showFullCalenderBottomSheet({DateTime? firstDate, DateTime? endDate, DateTime? selectedDate, double padding = 8, String locale = 'en'}) {
  final mSelectedDate = DateTime.now().obs;

  Completer<DateTime?> completer = Completer<DateTime?>();
  showModalBottomSheet<void>(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpace32,
              IconButton(
                  onPressed: () {
                    completer.complete(null);
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.lightBlue)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Txt('When are you going?', fontSize: 24, fontWeight: FontWeight.w900, color: Get.theme.primaryColor),
              ),
              Expanded(
                child: SuperVerticalPaginatedCalender(
                  firstDate: firstDate,
                  endDate: endDate,
                  selectedDate: selectedDate,
                  padding: padding,
                  locale: locale,
                  onDayPressed: (date) {
                    mSelectedDate.value = date;
                    completer.complete(date);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  return completer.future;
}

Future<DateTime?> showFullCalenderDialog({DateTime? firstDate, DateTime? endDate, DateTime? selectedDate, double padding = 8, String locale = 'en'}) async {
  final mSelectedDate = DateTime.now().obs;

  Completer<DateTime?> completer = Completer<DateTime?>();
  await mShowDialog(
    backDismiss: true,
    maskColor: Colors.white,
    alignment: Alignment.center,
    builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpace8,
              IconButton(
                  onPressed: () {
                    completer.complete(null);
                    mHide();
                  },
                  icon: const Icon(Icons.close, color: Colors.lightBlue)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Txt('When are you going?', fontSize: 24, fontWeight: FontWeight.w900, color: Get.theme.primaryColor),
              ),
              Expanded(
                child: SuperVerticalPaginatedCalender(
                  firstDate: firstDate,
                  endDate: endDate,
                  selectedDate: selectedDate,
                  padding: padding,
                  locale: locale,
                  onDayPressed: (date) {
                    mSelectedDate.value = date;
                    completer.complete(date);
                    mHide();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return completer.future;
}

///end of code
