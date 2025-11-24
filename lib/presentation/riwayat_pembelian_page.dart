import 'package:flutter/material.dart';
import 'package:projectuts/data/model/pembelian.dart';
import 'package:projectuts/data/repository/app_repository.dart';
import 'package:projectuts/presentation/detail_pembelian_page.dart';
import 'package:projectuts/presentation/edit_pembelian_page.dart';
import 'package:projectuts/presentation/home_page.dart';

class RiwayatPembelianPage extends StatefulWidget {
  final String username;
  RiwayatPembelianPage({Key? key, required this.username}) : super(key: key);

  @override
  State<RiwayatPembelianPage> createState() => _RiwayatPembelianPageState();
}

class _RiwayatPembelianPageState extends State<RiwayatPembelianPage> {
  List<Pembelian> riwayat = [];
  final AppRepository _repository = AppRepository();

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "selesai":
        return Colors.green.shade300;
      case "pending":
        return Colors.orange.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  String _metodeText(String metode) => metode;

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    final data = await _repository.getRiwayatPembelian(widget.username);
    setState(() {
      riwayat = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0077B6),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Riwayat Pembelian",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: widget.username),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          var data = riwayat[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPembelianPage(
                    transaksi: data,
                    onDelete: () {
                      setState(() => riwayat.removeAt(index));
                      Navigator.pop(context);
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditTransaksiPage(
                            transaksi: data,
                            onUpdate: (updated) {
                              setState(() => riwayat[index] = updated);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        data.gambarObat ?? 'assets/obat/default.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.namaObat,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.kategori,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Pembeli: ${data.namaPembeli ?? '-'}",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rp ${data.total}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor(data.status),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            data.status,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
