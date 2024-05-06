class DialogDatePicker {
  var now = DateTime(2024, 2);

  void init() {
    // Getting the total number of days of the month
    var totalDays = daysInMonth(now);

    // Stroing all the dates till the last date
    // since we have found the last date using generate
    var listOfDates = List<int>.generate(totalDays, (i) => i + 1);
    print(listOfDates);
  }

// this returns the last date of the month using DateTime
  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}
