import 'package:flutter/material.dart';
import 'package:projectuts/data/model/pembelian.dart';

class DetailPembelianPage extends StatelessWidget {
  final Pembelian transaksi;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const DetailPembelianPage({
    super.key,
    required this.transaksi,
    this.onDelete,
    this.onEdit,
  });

  Color _badgeColor(String metode) {
    return metode == "resep" ? Color(0xFF7EC8E3) : Color(0xFF98E2C6);
  }

  String _metodeText(String metode) {
    return metode == "resep" ? "Resep Dokter" : "Pembelian Langsung";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pembelian"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                if (transaksi.gambarObat != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        transaksi.gambarObat!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                _infoRow("Nama Obat", transaksi.nama),
                _infoRow("Kategori", transaksi.kategori),
                _infoRow("Nama Pembeli", transaksi.namaPembeli ?? "—"),
                _infoRow("Jumlah", "${transaksi.jumlah}"),
                _infoRow("Harga Satuan", "Rp${transaksi.harga}"),
                _infoRow("Total Harga", "Rp${transaksi.total}"),
                _infoRow("Tanggal", transaksi.tanggal),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Metode",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _badgeColor(transaksi.metode),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _metodeText(transaksi.metode),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),

                if (transaksi.metode == "resep")
                  _infoRow(
                    "Nomor Resep",
                    transaksi.nomorResep?.toString() ?? "-",
                  ),

                const SizedBox(height: 20),
                const Divider(),

                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Batalkan Transaksi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Edit Transaksi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
