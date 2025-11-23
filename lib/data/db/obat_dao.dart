import 'package:projectuts/data/db/db_helper.dart';
import 'package:projectuts/data/model/obat.dart';

class ObatDao {
  final dbHelper = DBHelper();

  Future<int> insertObat(Obat obat) async {
    final db = await dbHelper.database;
    return await db.insert('obat', obat.toMap());
  }

  Future<List<Obat>> getAllObat() async {
    final db = await dbHelper.database;
    final maps = await db.query('obat');
    return maps.map((map) => Obat.fromMap(map)).toList();
  }

  Future<int> updateObat(Obat obat) async {
    final db = await dbHelper.database;
    return await db.update('obat', obat.toMap(), where: 'id = ?', whereArgs: [obat.id]);
  }

  Future<int> deleteObat(int id) async {
    final db = await dbHelper.database;
    return await db.delete('obat', where: 'id = ?', whereArgs: [id]);
  }
}
