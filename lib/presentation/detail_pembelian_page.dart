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
    return metode == "Resep Dokter" ? Color(0xFF7EC8E3) : Color(0xFF98E2C6);
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case "Selesai":
        color = Colors.green;
        break;
      case "Diproses":
        color = Colors.orange;
        break;
      case "Dibatalkan":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String _metodeText(String metode) => metode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0077B6),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Detail Pembelian",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                if (transaksi.gambarObat != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        transaksi.gambarObat!,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                _infoRow("Nama Obat", transaksi.namaObat),
                _infoRow("Kategori", transaksi.kategori),
                _infoRow("Nama Pembeli", transaksi.namaPembeli ?? "—"),
                _infoRow("Jumlah", "${transaksi.jumlah}"),
                if (transaksi.catatan != null && transaksi.catatan!.isNotEmpty)
                  _infoRow("Catatan", transaksi.catatan!),
                _infoRow("Harga Satuan", "Rp${transaksi.harga}"),
                _infoRow("Total Harga", "Rp${transaksi.total}"),
                _infoRow("Tanggal", transaksi.tanggal),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Metode",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _badgeColor(transaksi.metode),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _metodeText(transaksi.metode),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                if (transaksi.metode == "Resep Dokter")
                  _infoRow("Nomor Resep", transaksi.nomorResep ?? "-"),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    _statusBadge(transaksi.status),
                  ],
                ),

                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onEdit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0077B6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onDelete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Batalkan",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
