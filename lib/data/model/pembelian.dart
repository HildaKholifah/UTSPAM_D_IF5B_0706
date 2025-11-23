class Pembelian {
  int? id;
  String nama;
  String kategori;
  String? namaPembeli;
  int jumlah;
  int harga;
  int total;
  String metode;
  String? nomorResep;
  String? gambarResep;
  String tanggal;

  Pembelian({
    this.id,
    required this.nama,
    required this.kategori,
    this.namaPembeli,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.metode,
    this.nomorResep,
    this.gambarResep,
    required this.tanggal,
  });

  factory Pembelian.fromMap(Map<String, dynamic> map) {
    return Pembelian(
      id: map['id'],
      nama: map['nama'],
      kategori: map['kategori'],
      namaPembeli: map['namaPembeli'],
      jumlah: map['jumlah'],
      harga: map['harga'],
      total: map['total'],
      metode: map['metode'],
      nomorResep: map['nomorResep'],
      gambarResep: map['gambarResep'],
      tanggal: map['tanggal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'namaPembeli': namaPembeli,
      'jumlah': jumlah,
      'harga': harga,
      'total': total,
      'metode': metode,
      'nomorResep': nomorResep,
      'gambarResep': gambarResep,
      'tanggal': tanggal,
    };
  }
}
