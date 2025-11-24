import 'package:projectuts/data/db/db_helper.dart';
import 'package:projectuts/data/model/user.dart';

class UserDao {
  final dbHelper = DBHelper();

  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('user', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await dbHelper.database;
    final res = await db.query('user', where: 'email = ?', whereArgs: [email]);
    if (res.isNotEmpty) return User.fromMap(res.first);
    return null;
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await dbHelper.database;
    var res = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (res.isNotEmpty) return User.fromMap(res.first);
    return null;
  }
}
