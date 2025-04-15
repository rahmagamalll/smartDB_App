import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get getdb async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'smartdb.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    //   await db.execute('''
    // CREATE TABLE "deletedtodolist" (
    //   "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    //   "title" TEXT NOT NULL,
    //   "subtitle" TEXT NOT NULL,
    //   "date" TEXT NOT NULL,
    //   "color" INTEGER NOT NULL
    // )
    // ''');
    //   print("onUpgrade ======");
  }

  _onCreate(
    Database db,
    int version,
  ) async {
//     await db.execute('''
//   CREATE TABLE "todo" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "title" TEXT NOT NULL,
//     "subtitle" TEXT NOT NULL,
//     "date" TEXT NOT NULL,
//     "color" INTEGER NOT NULL
//   )
//  ''');

//     await db.execute('''
//   CREATE TABLE "deletedtodolist" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "title" TEXT NOT NULL,
//     "subtitle" TEXT NOT NULL,
//     "date" TEXT NOT NULL,
//     "color" INTEGER NOT NULL
//   )
//   ''');
//     print(" onCreate ===============");
  }

  readData(String sql) async {
    Database? mydb = await getdb;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await getdb;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await getdb;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await getdb;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

// create table
  Future<void> createTable(
      String tableName, Map<String, String> columns) async {
    Database? mydb = await getdb;

    String columnDefs = columns.entries.map((entry) {
      return '"${entry.key}" ${entry.value}';
    }).join(', ');

    String sql = 'CREATE TABLE IF NOT EXISTS "$tableName" ($columnDefs)';
    await mydb!.execute(sql);
    print('Table "$tableName" created.');
  }

// get all table names
  Future<List<String>> getAllTableNames() async {
    Database? db = await getdb;
    List<Map<String, dynamic>> result = await db!.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';");

    List<String> tableNames =
        result.map((row) => row['name'] as String).toList();
    return tableNames;
  }

// insert into table
  Future<int> insertIntoTable(
      String tableName, Map<String, dynamic> data) async {
    Database? mydb = await getdb;

    String columns = data.keys.map((key) => '"$key"').join(', ');
    String valuesPlaceholders = data.keys.map((key) => '?').join(', ');
    List<dynamic> values = data.values.toList();

    String sql =
        'INSERT INTO "$tableName" ($columns) VALUES ($valuesPlaceholders)';
    int response = await mydb!.rawInsert(sql, values);
    print('Inserted into $tableName: $data');
    return response;
  }

  // read table
  Future<List<Map<String, dynamic>>> readTable(String tableName) async {
    Database? mydb = await getdb;
    String sql = 'SELECT * FROM "$tableName"';
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  // update table
  Future<int> updateTable(
      String tableName, Map<String, dynamic> data, String whereClause) async {
    Database? mydb = await getdb;
    String setClause = data.entries.map((entry) {
      return '"${entry.key}" = ?';
    }).join(', ');
    List<dynamic> values = data.values.toList();
    String sql = 'UPDATE "$tableName" SET $setClause WHERE $whereClause';
    int response = await mydb!.rawUpdate(sql, values);
    print('Updated $tableName: $data');
    return response;
  }

//get specific table data
  Future<List<Map<String, dynamic>>> getTableData({
    required String tableName,
    String? whereClause, // اختياري //age>50
  }) async {
    Database? mydb = await getdb;

    String sql = 'SELECT * FROM "$tableName"';
    if (whereClause != null && whereClause.trim().isNotEmpty) {
      sql += ' WHERE $whereClause';
    }

    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  // get columssssssssss name
  Future<List<String>> getTableColumns(String tableName) async {
    Database? mydb = await getdb;
    List<Map> result = await mydb!.rawQuery('PRAGMA table_info("$tableName")');
    List<String> columnNames =
        result.map((row) => row['name'] as String).toList();
    return columnNames;
  }
  Future<List<String>> getTableColumnsTypes(String tableName) async {
    Database? mydb = await getdb;
    List<Map> result = await mydb!.rawQuery('PRAGMA table_info("$tableName")');
   
     List<String> columnTypes = result.map((e) => e['type'] as String).toList();
    return columnTypes;
  }

// drop table

  Future<void> dropTable(String tableName) async {
    Database? mydb = await getdb;
    String sql = 'DROP TABLE IF EXISTS "$tableName"';
    await mydb!.execute(sql);
    print('Table "$tableName" dropped.');
  }

  //delete specific table data or drop table
  Future<void> deleteTableDataOrDropIt({
    required String tableName,
    String? whereClause, // اختياري //age>50
  }) async {
    Database? mydb = await getdb;

    String sql = ' ';
    if (whereClause != null && whereClause.trim().isNotEmpty) {
      sql += 'DELETE * FROM "$tableName" WHERE $whereClause';
    } else if (whereClause == null) {
      sql = 'DROP TABLE IF EXISTS "$tableName"';
    }
    await mydb!.execute(sql);
  }
}
