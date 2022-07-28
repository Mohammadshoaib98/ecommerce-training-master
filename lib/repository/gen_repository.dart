import 'package:ecommerce/models/base_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GenRepository<T extends BaseModel> {
  static const String _databaseName = "commerce_database.db";
  static Database? db;

  String get currentTypeTableName => runtimeType.toString();

  static Future prepareDatabase() async {
    if (db != null) return;
    var dir = await getApplicationDocumentsDirectory();
    var databasePath = join(dir.path, _databaseName);
    db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Product (id INTEGER PRIMARY KEY autoincrement, name TEXT)');
      },
    );
  }

  Future addEntity(T entity) async {
    try {
      db?.insert(entity.tableName, entity.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future editEntity(T entity) async {
    try {
      db?.update(entity.tableName, entity.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future deleteEntity(T entity) async {
    try {
      db?.delete(entity.tableName, where: "id = ?", whereArgs: [entity.id]);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, Object?>>> getAllEntities(String tableName) async {
    try {
      var entities = await db?.query(tableName, orderBy: "id desc");
      if (entities?.isNotEmpty ?? false) {
        return entities!;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, Object?>?> getEntityById(int id, String tableName) async {
    try {
      var entities = await db?.query(tableName,
          where: "id = ?", whereArgs: [id], orderBy: "id desc");
      if (entities?.isNotEmpty ?? false) {
        return entities!.first;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future deleteEntityWhere(String tableName, String where,
      {List<Object>? args}) async {
    try {
      await db?.delete(tableName, where: where, whereArgs: args);
    } catch (e) {
      print(e);
    }
  }

  Future<int> countEntities(String tableName) async {
    try {
      var entities = await db?.query(tableName);
      return entities?.length ?? 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> countEntitiesWhere(String tableName, String where,
      {List<Object>? args}) async {
    try {
      var entities = await db?.query(tableName, where: where, whereArgs: args);
      return entities?.length ?? 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
