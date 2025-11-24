class Pembelian {
  int? id;
  String namaObat;
  String kategori;
  String? namaPembeli;
  int jumlah;
  String? catatan;
  int harga;
  int total;
  String metode;
  String? nomorResep;
  String? gambarResep;
  String? gambarObat;
  String tanggal;
  String status;

  Pembelian({
    this.id,
    required this.namaObat,
    required this.kategori,
    this.namaPembeli,
    required this.jumlah,
    this.catatan,
    required this.harga,
    required this.total,
    required this.metode,
    this.nomorResep,
    this.gambarResep,
    this.gambarObat,
    required this.tanggal,
    required this.status,
  });

  factory Pembelian.fromMap(Map<String, dynamic> map) {
    return Pembelian(
      id: map['id'],
      namaObat: map['namaObat'] ?? '',
      kategori: map['kategori'] ?? '',
      namaPembeli: map['namaPembeli'],
      jumlah: map['jumlah'] ?? 0,
      catatan: map['catatan'],
      harga: map['harga'],
      total: map['total'] ?? 0,
      metode: map['metode'] ?? 'langsung',
      nomorResep: map['nomorResep'],
      gambarResep: map['gambarResep'] ?? '',
      gambarObat: map['gambarObat'] ?? 'assets/obat/default.png',
      tanggal: map['tanggal'] ?? '',
      status: map['status'] ?? 'selesai',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaObat': namaObat,
      'kategori': kategori,
      'namaPembeli': namaPembeli,
      'jumlah': jumlah,
      'catatan': catatan,
      'harga': harga,
      'total': total,
      'metode': metode,
      'nomorResep': nomorResep,
      'gambarResep': gambarResep,
      'gambarObat': gambarObat,
      'tanggal': tanggal,
      'status': status,
    };
  }

  Pembelian copyWith({
    int? id,
    String? namaObat,
    String? kategori,
    String? namaPembeli,
    int? jumlah,
    String? catatan,
    int? harga,
    int? total,
    String? metode,
    String? gambarObat,
    String? nomorResep,
    String? gambarResep,
    String? tanggal,
    String? status,
  }) {
    return Pembelian(
      id: id ?? this.id,
      namaObat: namaObat ?? this.namaObat,
      kategori: kategori ?? this.kategori,
      namaPembeli: namaPembeli ?? this.namaPembeli,
      jumlah: jumlah ?? this.jumlah,
      catatan: catatan ?? this.catatan,
      harga: harga ?? this.harga,
      total: total ?? this.total,
      metode: metode ?? this.metode,
      nomorResep: nomorResep ?? this.nomorResep,
      gambarResep: gambarResep ?? this.gambarResep,
      gambarObat: gambarObat ?? this.gambarObat,
      tanggal: tanggal ?? this.tanggal,
      status: status ?? this.status,
    );
  }
}
