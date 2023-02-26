String todaysDate() {
  var dateTimeObject = DateTime.now();
  String year = dateTimeObject.year.toString();
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

String dayNo() {
  var dateTimeObject = DateTime.now();
  String day = dateTimeObject.day.toString();
  return day;
}


