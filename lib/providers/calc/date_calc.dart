import 'package:flutter/material.dart';

const int msPerDay = 86400000;
const int msPerWeek = 604800000;
const int msPerMonth = 2629800000;
const int msPerYear = 31557600000;

class DateCalcProvider extends ChangeNotifier {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  String difference = "Same dates";
  String differenceInDays = "";
  int selectedYear = 0;
  int selectedMonth = 0;
  int selectedDay = 0;
  DateTime? date;
  bool add = true;
  String getDifference(int ms) {
    String result = "";
    final int years = ms ~/ msPerYear;
    final int months = (ms % msPerYear) ~/ msPerMonth;
    final int weeks = ((ms % msPerYear) % msPerMonth) ~/ msPerWeek;
    final int days = (((ms % msPerYear) % msPerMonth) % msPerWeek) ~/ msPerDay;
    if (years > 0) {
      result += "$years ${years != 1 ? 'years' : 'year'}";
    }
    if (months > 0) {
      result +=
          "${result.isEmpty ? '' : ', '} $months ${months != 1 ? 'months' : 'month'}";
    }
    if (weeks > 0) {
      result +=
          "${result.isEmpty ? '' : ', '} $weeks ${weeks != 1 ? 'weeks' : 'week'}";
    }
    if (days > 0) {
      result +=
          "${result.isEmpty ? '' : ', '} $days ${days != 1 ? 'days' : 'day'}";
    }
    return result;
  }

  void setDate(BuildContext context, bool isFrom) {
    showDatePicker(
      context: context,
      initialDate: isFrom ? from : to,
      firstDate: DateTime(1550),
      lastDate: DateTime(2550),
      builder: (context, child) => Theme(
          data: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: const ColorScheme.dark(
              surface: Color.fromRGBO(50, 50, 50, 1),
              primary: Color.fromRGBO(118, 185, 237, 1),
            ),
          ),
          child: child!),
    ).then((DateTime? selectedDate) {
      if (isFrom) {
        from = selectedDate ?? from;
      } else {
        to = selectedDate ?? to;
      }

      final DateTime date1 = DateTime(from.year, from.month, from.day);
      final DateTime date2 = DateTime(to.year, to.month, to.day);
      final Duration diff = date2.difference(date1);
      if (diff.inMilliseconds.abs() == 0) {
        difference = "Same dates";
        differenceInDays = "";
      } else {
        difference = getDifference(diff.inMilliseconds.abs());
        final int diffInDays = diff.inDays.abs();
        if (diffInDays > 6) {
          differenceInDays = diffInDays.abs().toString();
        } else {
          differenceInDays = "";
        }
      }
      notify();
    });
  }

  void addOrSubtract() {
    final DateTime fromDate = DateTime(from.year, from.month, from.day);
    date = add
        ? DateTime(fromDate.year + selectedYear, fromDate.month + selectedMonth,
            fromDate.day + selectedDay)
        : DateTime(fromDate.year - selectedYear, fromDate.month - selectedMonth,
            fromDate.day - selectedDay);
  }

  void changeDuration(int option, int duration) {
    switch (option) {
      case 0:
        selectedYear = duration;
      case 1:
        selectedMonth = duration;
      case 2:
        selectedDay = duration;
    }
    addOrSubtract();
    notify();
  }

  void notify() => notifyListeners();
}
