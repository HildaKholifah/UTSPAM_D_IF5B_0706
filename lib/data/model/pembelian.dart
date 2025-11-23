class Pembelian {
  int? id;
  String nama;
  String kategori;
  String? namaPembeli;
  int jumlah;
  int harga;
  int total;
  String tanggal;
  String metode;
  String? nomorResep;
  String? gambar;

  Pembelian({
    this.id,
    required this.nama,
    required this.kategori,
    this.namaPembeli,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.tanggal,
    required this.metode,
    this.nomorResep,
    this.gambar,
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
      tanggal: map['tanggal'],
      metode: map['metode'],
      nomorResep: map['nomorResep'],
      gambar: map['gambar'],
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
      'tanggal': tanggal,
      'metode': metode,
      'nomorResep': nomorResep,
      'gambar': gambar,
    };
  }
}
