import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Sql extends ChangeNotifier{
  List allData = [];
  late Database database;
  Future openDp() async {
    var databasePath = await getDatabasesPath();
    String path = await databasePath + "todo.dp";
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute("CREATE TABLE Todos (id INTEGER PRIMARY KEY , text TEXT)");
      },
    );
    notifyListeners();
  }

  Future insert(String todo) async {
    await openDp();
    await database.transaction(
      (txn) async {
        int id1 =
            await txn.rawInsert('INSERT INTO Todos (text) VALUES("$todo")');
        print('inserted1: $id1');
      },
    );
    notifyListeners();
  }

  Future update(String todoWillChange, int idWillChange) async {
    await openDp();
    int count = await database.rawUpdate(
        'UPDATE Todos SET text = $todoWillChange WHERE id = $idWillChange');
    print('updated: $count');
    notifyListeners();
  }

  Future<List> read() async {
    await openDp();
    allData = await database.rawQuery('SELECT * FROM Todos');
    notifyListeners();
    print(allData);
    return allData;
    
  }

  Future delete(int idWillDeleted) async {
    await openDp();
    int count =
        await database.rawDelete('DELETE FROM Todos WHERE id = $idWillDeleted');
    print(count);
    notifyListeners();
  }
}
