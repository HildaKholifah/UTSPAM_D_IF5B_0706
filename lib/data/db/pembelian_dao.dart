import 'package:projectuts/data/db/db_helper.dart';
import 'package:projectuts/data/model/pembelian.dart';

class PembelianDao {
  final dbHelper = DBHelper();

  Future<int> insertPembelian(Pembelian pembelian) async {
    final db = await dbHelper.database;
    return await db.insert(DBHelper.tabelPembelian, pembelian.toMap());
  }

  Future<List<Pembelian>> getAllPembelian() async {
    final db = await dbHelper.database;
    final maps = await db.query(DBHelper.tabelPembelian, orderBy: "id DESC");
    return List.generate(maps.length, (i) {
      return Pembelian.fromMap(maps[i]);
    });
  }

  Future<int> updatePembelian(Pembelian pembelian) async {
    final db = await dbHelper.database;
    return await db.update(
      DBHelper.tabelPembelian,
      pembelian.toMap(),
      where: "id = ?",
      whereArgs: [pembelian.id],
    );
  }

  Future<int> deletePembelian(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      DBHelper.tabelPembelian,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
