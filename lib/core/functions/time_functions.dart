import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static TimeOfDay stringToTimeOfDay(String tod) {
    var hour = int.parse(tod.split(":")[0]);
    var minute = int.parse(tod.split(":")[1].split(" ")[0]);
    var am_pm = tod.split(":")[1].split(" ")[1];
    if (am_pm == "PM" && hour != 12) hour += 12;
    if (am_pm == "AM" && hour == 12) hour = 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String formatDateTime(int time, {bool onlyDate = false}) {
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    var formatter = onlyDate
        ? DateFormat('EEE, MMM dd yyyy')
        : DateFormat('EEE, MMM dd yyyy HH:mm:ss a');
    return formatter.format(date);
  }
}
