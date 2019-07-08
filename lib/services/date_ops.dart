DateTime toDateFormat(String dateStr) {
  int yyyy = int.parse(dateStr.substring(0, 4));
  int mm = int.parse(dateStr.substring(4, 6));
  int dd = int.parse(dateStr.substring(6, 8));
  DateTime date = DateTime(yyyy, mm, dd);
  return date;
}

String toStringDate(_creationDate) {
  String yyyy = _creationDate.year.toString();
  String mm = _creationDate.month < 10
      ? '0' + DateTime.now().month.toString()
      : DateTime.now().month.toString();
  String dd = _creationDate.day < 10
      ? '0' + DateTime.now().day.toString()
      : DateTime.now().day.toString();
  String date = (yyyy + mm + dd);
  return date;
}

String toShortDate(DateTime _date) {
  return _date.year.toString() + _date.month.toString() + _date.day.toString();
}
