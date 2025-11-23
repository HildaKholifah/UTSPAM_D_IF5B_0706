import 'package:projectuts/data/db/user_dao.dart';
import 'package:projectuts/data/model/user.dart';

class UserRepository {
  final _userDao = UserDao();

  Future<void> register({
    required String nama,
    required String email,
    required String alamat,
    required String telepon,
    required String username,
    required String password,
    required String gender,
  }) async {
    User user = User(
      nama: nama,
      email: email,
      alamat: alamat,
      telepon: telepon,
      username: username,
      password: password,
      gender: gender,
    );
    await _userDao.insertUser(user);
  }

  Future<bool> login({required String email, required String password}) async {
    User? user = await _userDao.getUserByEmail(email);
    if (user == null) return false;
    return user.password == password;
  }

  Future<User?> getUserByUsername(String username) async {
    return await _userDao.getUserByUsername(username);
  }

  Future<String?> getUsernameByEmail(String email) async {
    User? user = await _userDao.getUserByEmail(email);
    return user?.username;
  }
}
