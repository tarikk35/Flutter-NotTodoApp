import 'package:ntd_app/services/date_ops.dart';

class NotTodo {
  int _id;
  String _title;
  String _details;
  DateTime _creationDate;
  String _record;
  bool _isActive;

  NotTodo(this._id, this._title, this._details, _creationDate, this._record)
      : this._creationDate = DateTime(
            _creationDate.year, _creationDate.month, _creationDate.year),
        this._isActive = true;

  NotTodo.map(item) {
    _id = item['id'];
    _title = item['title'];
    _details = item['details'];
    _creationDate = toDateFormat(item['creationdate']);
    _record = item['record'] == null ? '_record' : item['record'];
    _isActive = item['isactive'];
  }

  NotTodo.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _details = map['details'];
    _creationDate = toDateFormat(map['creationdate']);
    _record = map['record'] == null ? '_record' : map['record'];
    _isActive = map['isactive'] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    final map = {
      'id': _id,
      'title': _title,
      'details': _details,
      'creationdate': toStringDate(_creationDate),
      'record': _record,
      'isactive': _isActive ? 1 : 0
    };
    return map;
  }

  int get id => _id;
  String get title => _title;
  String get details => _details;
  DateTime get creationDate => _creationDate;
  String get record =>
      _record; // Kayıt yoksa boilerplate uygulamadan gelen kayıt çalışsın.
  bool get isActive => _isActive;

  void update(NotTodo ntd) {
    this._title = ntd.title;
    this._details = ntd.details;
    this._isActive = ntd.isActive;
  }
}
