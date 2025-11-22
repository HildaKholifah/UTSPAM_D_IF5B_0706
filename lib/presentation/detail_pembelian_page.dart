import 'package:flutter/material.dart';
import 'package:projectuts/presentation/edit_transaksi_page.dart';

class DetailPembelianPage extends StatelessWidget {
  final Map<String, dynamic> transaksi;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const DetailPembelianPage({
    super.key,
    required this.transaksi,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pembelian"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Nama Obat: ${transaksi['nama']}"),
            Text("Kategori: ${transaksi['kategori']}"),
            Text("Nama Pembeli: ${transaksi['namaPembeli'] ?? '–'}"),
            Text("Jumlah: ${transaksi['jumlah']}"),
            Text("Harga Satuan: Rp${transaksi['harga']}"),
            Text("Total Harga: Rp${transaksi['total']}"),
            Text("Tanggal: ${transaksi['tanggal']}"),
            Text(
              "Metode: ${transaksi['metode'] == 'resep' ? 'Resep Dokter' : 'Langsung'}",
            ),
            if (transaksi['metode'] == 'resep')
              Text("Nomor Resep: ${transaksi['nomorResep']}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 223, 61, 61),
              ),
              child: const Text(
                "Batalkan Transaksi",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onEdit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 61, 180, 223),
              ),
              child: const Text(
                "Edit Transaksi",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Kembali ke Riwayat"),
            ),
          ],
        ),
      ),
    );
  }
}
