class Obat {
  int? id;
  String nama;
  String kategori;
  int harga;
  String gambar;

  Obat({
    this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.gambar,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'kategori': kategori, 'harga': harga};
  }

  factory Obat.fromMap(Map<String, dynamic> map) {
    return Obat(
      id: map['id'],
      nama: map['nama'],
      kategori: map['kategori'],
      harga: map['harga'],
      gambar: map['gambar'],
    );
  }
}
