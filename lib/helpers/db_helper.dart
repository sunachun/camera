import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath(); //作成しようとしているデータベースを保存できるパス
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    }, version: 1 //places.dbを作成して読み書きする
        ); //指定したデータベースを開く

    await sqlDb.insert(
      //データベースにコマンド実行
      table, //挿入したいテーブル
      data, //挿入するデータ
      conflictAlgorithm:
          sql.ConflictAlgorithm.replace, //すでにデータベースにあるidのデータの場合上書きする
    );
  }
}
