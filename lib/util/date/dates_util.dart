import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DatesUtil {

  static String toAmericanDate({required String date}) {
    return toFormatDate(
      dateFormatIn: PartnerDate.dateBR,
      dateFormatOut: PartnerDate.dateUS,
      date: date,
    );
  }

  static String toAmericanDateTime({required String date}) {
    return toFormatDate(
      dateFormatIn: PartnerDate.dateBR,
      dateFormatOut: PartnerDate.dateTimeUS,
      date: date,
    );
  }

  static String toBrazilianDate({required String date}) {
    return toFormatDate(
      dateFormatIn: PartnerDate.dateUS,
      dateFormatOut: PartnerDate.dateBR,
      date: date,
    );
  }

  static String toBrazilianDateTime({required String date}) {
    return toFormatDate(
      dateFormatIn: PartnerDate.dateTimeUS,
      dateFormatOut: PartnerDate.dateTimeBR,
      date: date,
    );
  }

  static String toFormatDate(
      {required PartnerDate dateFormatIn,
      required PartnerDate dateFormatOut,
      required String date}) {
    try {
      var dateIn = DateFormat(dateFormatIn.value).parse(date);
      var dateOut = DateFormat(dateFormatOut.value).format(dateIn);
      return dateOut;
    } catch (e) {
      debugPrint("Error format date - $e");
      return date;
    }
  }

  static bool isValidBirthDate(String date) {
    var dtR = date.split("/");
    var maxAge = DateTime.now().year - 120;
    var minAge = DateTime.now().year - 18;
    if(int.parse(dtR[1]) > 12 ||
        int.parse(dtR[1]) == 00 ||
        int.parse(dtR[0]) > 31 ||
        int.parse(dtR[0]) == 00 ||
        int.parse(dtR[2]) == 0000 ||
        int.parse(dtR[2]) < maxAge ||
        int.parse(dtR[2]) > minAge) {
      return false;
    }
    debugPrint("Date in - $date");
    try {
      var dateIn = DateTime.parse("${dtR[2]}-${dtR[1]}-${dtR[0]}");
      var now = DateTime.now();
      debugPrint("Date now - $now is after ${dateIn.isAfter(now)}");
      if (dateIn.isAfter(now)) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      debugPrint("Error validation date - $e");
      return false;
    }
  }
}

enum PartnerDate {
  dateUS("yyyy-MM-dd"),
  dateTimeUS("yyyy-MM-dd HH:mm:ss"),
  dateBR("dd/MM/yyyy"),
  dateTimeBR("dd/MM/yyyy HH:mm:ss");

  const PartnerDate(this.value);

  final String value;
}
