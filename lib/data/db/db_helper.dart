import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static final String tabelPembelian = "pembelian";

  final String columnId = 'id';
  final String columnNamaPembeli = 'namaPembeli';
  final String columnNamaObat = 'namaObat';
  final String columnJumlah = 'jumlah';
  final String columnMetode = 'metode';
  final String columnNomorResep = 'nomorResep';
  final String columnGambarResep = 'gambarResep';
  final String columnGambarObat = 'gambarObat';
  final String columnTanggal = 'tanggal';

  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "mediklik.db");
    deleteDatabase(path);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        email TEXT NOT NULL,
        alamat TEXT NOT NULL,
        telepon TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        gender TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE obat(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        kategori TEXT NOT NULL,
        harga INTEGER NOT NULL,
        gambar TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pembelian (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        kategori TEXT NOT NULL,
        namaPembeli TEXT,
        jumlah INTEGER NOT NULL,
        catatan TEXT,
        harga INTEGER NOT NULL,
        total INTEGER NOT NULL,
        metode TEXT NOT NULL,
        nomorResep TEXT,
        gambarResep TEXT,
        gambarObat TEXT,
        tanggal TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE pembelian ADD COLUMN kategori TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN namaPembeli TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN catatan TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN total INTEGER;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN metode TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN nomorResep TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN gambarResep TEXT;");
      await db.execute("ALTER TABLE pembelian ADD COLUMN gambarObat TEXT;");
    }
  }
}
