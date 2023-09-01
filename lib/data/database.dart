import 'package:hive_flutter/hive_flutter.dart';

class AppDatabase {
  List tasksList = [];

  // prendo un riferimento alla box
  final _myBox = Hive.box('taskbox');


  /*
  carica dati dal database e li salva sulla variabile,
  viene usata una sorta di key per accedere al value della box
   */
  void loadData() {
    tasksList = _myBox.get("TASKSLIST");
  }

  // update del database
  void updateDataBase() {
    _myBox.put("TASKSLIST", tasksList);
  }
}