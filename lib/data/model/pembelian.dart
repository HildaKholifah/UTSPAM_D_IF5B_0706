import 'dart:io';

class Pembelian {
  String nama;
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

  Pembelian({
    required this.nama,
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
  });

  factory Pembelian.fromMap(Map<String, dynamic> map) {
    return Pembelian(
      nama: map['nama'] ?? '',
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
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
    };
  }

  Pembelian copyWith({
    String? nama,
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
  }) {
    return Pembelian(
      nama: nama ?? this.nama,
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
    );
  }
}
