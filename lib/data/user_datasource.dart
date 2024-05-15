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
        "CREATE TABLE Users("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            " name TEXT, "
            "email TEXT)",
      );
    }
    , version: 1);
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
    print("資料讀取${maps.length}");
    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        name: maps[index]['name'],
        email: maps[index]['email'],
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
  static Future<void> updateUser(User user) async {
    Database? database = await getDBConnet();
    if (database != null) {
      await database.update(
          "Users", {"name": user.name, "email": user.email},
          where: "id = ?",
          whereArgs: [user.id]);
    } else {
      throw extension('database connection error ');
    }
  }
