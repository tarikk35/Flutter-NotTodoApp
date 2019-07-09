import 'package:flutter/material.dart';
import 'package:ntd_app/services/sound_ops.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ntd_model.dart';
import 'package:ntd_app/services/db_ops.dart';

class AppModel extends Model with SoundOps {
  static final AppModel _appModel = AppModel._internal();

  factory AppModel() => _appModel;

  AppModel._internal();

  List<NotTodo> _items = [];
  bool isActive = false;

  NotTodo _selectedItem;

  int selectedId = 0;

  static PageController controller;

  NotTodo get selectedItem => _selectedItem;

  List<NotTodo> get items => _items;

  Future<Null> fetchAll() async {
    _items = await DatabaseHelper().getAll();
  }

  void selectItem(NotTodo ntd) {
    _selectedItem = ntd;
    isActive = ntd != null ? _selectedItem.isActive : false;
    selectedId = ntd != null ? ntd.id : 0;
    notifyListeners();
  }

  Future<Null> unselectItem() {
    _selectedItem = null;
    notifyListeners();
    isActive = false;
    return null;
  }

  Future<Null> addNTD(NotTodo ntd) async {
    await DatabaseHelper().createNTD(ntd.toMap());
    _items.add(ntd);
    notifyListeners();
  }

  Future<Null> removeNTD(int id) async {
    _items.removeWhere((item) => item.id == id);
    await DatabaseHelper().deleteNTD(id);
    notifyListeners();
  }

  Future<Null> updateNTD(NotTodo ntd) async {
    await DatabaseHelper().updateNTD(ntd.toMap());
    _items.firstWhere((item) => item.id == ntd.id).update(ntd);
    notifyListeners();
  }

  NotTodo getNTD(id) {
    return _items.firstWhere((item) => item.id == id);
  }
}
