import 'package:projectuts/data/db/obat_dao.dart';
import 'package:projectuts/data/db/pembelian_dao.dart';
import 'package:projectuts/data/db/user_dao.dart';
import 'package:projectuts/data/model/obat.dart';
import 'package:projectuts/data/model/pembelian.dart';
import 'package:projectuts/data/model/user.dart';

class AppRepository {
  final _userDao = UserDao();
  final _obatDao = ObatDao();
  final _pembelianDao = PembelianDao();

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

  Future<int> tambahObat(Obat obat) =>
      _obatDao.insertObat(obat);

  Future<List<Obat>> getAllObat() =>
      _obatDao.getAllObat();

  Future<int> updateObat(Obat obat) =>
      _obatDao.updateObat(obat);

  Future<int> deleteObat(int id) =>
      _obatDao.deleteObat(id);

  Future<int> tambahPembelian(Pembelian pembelian) =>
      _pembelianDao.insertPembelian(pembelian);

  Future<List<Pembelian>> getAllPembelian() =>
      _pembelianDao.getAllPembelian();

  Future<int> updatePembelian(Pembelian pembelian) =>
      _pembelianDao.updatePembelian(pembelian);

  Future<int> deletePembelian(int id) =>
      _pembelianDao.deletePembelian(id);
}
