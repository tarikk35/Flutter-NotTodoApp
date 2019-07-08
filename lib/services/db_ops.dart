import 'package:ntd_app/models/ntd_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _dbHelper;
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    // Singleton
    if (_dbHelper == null) {
      _dbHelper = DatabaseHelper._createInstance();
    }
    return _dbHelper;
  }

  static Database _db; // Singleton instance

  Future<Database> get db async {
    // Getter of instance
    if (_db == null) {
      _db = await initDb();
      try {
        await createTable();
      } catch (e) {} // and creating again
    }
    return _db;
  }

  Future<Database> initDb() async {
    // Creating database
    final dir =
        await getApplicationDocumentsDirectory(); // getting phone's directory to create database
    String path = join(dir.path, 'mainDb.db'); // naming our database
    var database = await openDatabase(path, version: 1, onCreate: onDbCreate);
    return database;
  }

  String tableName = 'Tasks'; // our table name and column name variables
  String colId = 'id';
  String colTitle = 'title';
  String colDetails = 'details';
  String colCreationDate = 'creationdate';
  String colRecord = 'record';
  String colActive = 'isactive';

  void onDbCreate(Database db, int version) async {
    // when database created, run a function that creates our table
    await createTable();
  }

  Future<Null> createTable() async {
    // creating our table
    final dbClient = await db;
    try {
      await dbClient
          .execute('ALTER TABLE $tableName ADD $colActive BIT');
      await dbClient.execute(
          'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDetails TEXT, '
          '$colCreationDate TEXT,$colActive BIT)');
    } catch (e) {
      print('Table create error...');
    }
  }

  // CRUD operations
  Future<int> createNTD(Map<String, dynamic> ntd) async {
    final dbClient = await db;
    var table =
        await dbClient.rawQuery("SELECT MAX(id)+1 as id FROM $tableName");
    ntd['id'] = table.first['id'];
    int response = await dbClient.insert(tableName, ntd);
    print(response);
    return response;
  }

  Future<Map> getNTD(int id) async {
    // finding in database
    final dbClient = await db;
    final query = 'SELECT * FROM $tableName WHERE $colId = $id';
    final response = await dbClient.rawQuery(query);
    return response.length == 0 ? null : response.first;
  }

  Future<List<NotTodo>> getAll() async {
    // getting everything in our table
    final dbClient = await db;
    var result = await dbClient.query(tableName);
    return result.isNotEmpty
        ? result.map((c) => NotTodo.fromMap(c)).toList()
        : [];
  }

  Future<int> updateNTD(Map<String, dynamic> ntd) async {
    // updating
    final dbClient = await db;
    final response = await dbClient
        .update(tableName, ntd, where: '$colId = ?', whereArgs: [ntd['id']]);
    // NTDList.update(NotTodo.fromMap(ntd));  // after update, save changes to our list
    return response;
  }

  Future<int> deleteNTD(int id) async {
    // deleting
    final dbClient = await db;
    final response =
        await dbClient.delete(tableName, where: '$colId=?', whereArgs: [id]);
    print('$response deleted !!!!!!');
    return response;
  }

  Future closeDb() async {
    // closing database connection
    var dbClient = await db;
    return dbClient.close();
  }

  Future deleteAll() async {
    // deleting whole table's data
    var dbClient = await db;
    return dbClient.delete(tableName);
  }

  Future<int> getCount() async {
    // getting number of items
    final dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName');
    int result = Sqflite.firstIntValue(list);
    return result;
  }
}
