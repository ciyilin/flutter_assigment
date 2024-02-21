import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertest/models/User.dart';

class UserDatasource {
  //私有構造函數
  UserDatasource._();

  static Database? _database;
  static final UserDatasource instance = UserDatasource._();

  //初始化及創建用戶列表
  static Future<Database?> _initDatabase() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), 'Users.db'), onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE Users(id TEXT PRIMARY KEY, name TEXT, email TEXT)",
      );
    }, version: 1);
    return _database;
  }

  //判斷數據是否已初始化即返回，預防每次可能重建資料庫
  static Future<Database?> getDBConnet() async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  //拿取資料
  static Future<List<User>> getUsers() async {
    final Database? db = await getDBConnet();
    final List<Map<String, dynamic>> maps =
        await db?.query('Users') ?? []; //空值檢查
    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        name: maps[index]['name'],
        email: maps[index]['index'],
      );
    });
  }

  //新增
  static Future<void> addUser(User user) async {
    final Database? db = await getDBConnet();
    await db?.insert(
      'Users', user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //處理衝突時刪除已有數據,新數據替換
    );
  }

  //刪除
  static Future<void> deleteUser(int id) async {
    final Database? db = await getDBConnet();
    await db?.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //update
  static Future<void> updateUser(int id, String name, String email) async {
    await _database?.update(
        "Users", {"name": name, "email": email},
        where: "id = ?",
        whereArgs: [id]);
  }
}
