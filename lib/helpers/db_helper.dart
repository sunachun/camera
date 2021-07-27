import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath(); //作成しようとしているデータベースを保存できるパス
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    }, version: 1 //places.dbを作成して読み書きする
        ); //指定したデータベースを開く
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      //データベースにコマンド実行
      table, //挿入したいテーブル
      data, //挿入するデータ
      conflictAlgorithm:
          sql.ConflictAlgorithm.replace, //すでにデータベースにあるidのデータの場合上書きする
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
