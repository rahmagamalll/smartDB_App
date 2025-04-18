import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
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
    Database mydb = await openDatabase(path);
    return mydb;
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
    return response;
  }

//get specific table data
  Future<List<Map<String, dynamic>>> getTableData({
    required String tableName,
    String? whereClause,
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
  }

  //delete specific table data or drop table
  Future<void> deleteTableDataOrDropIt({
    required String tableName,
    String? whereClause, 
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
