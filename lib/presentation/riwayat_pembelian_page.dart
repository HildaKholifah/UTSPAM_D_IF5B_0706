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

  Color _badgeColor(String metode) {
    return metode == "Resep Dokter" ? Color(0xFF7EC8E3) : Color(0xFF98E2C6);
  }

  String _metodeText(String metode) {
    return metode; 
  }

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
        backgroundColor: Color.fromARGB(255, 61, 180, 223),
        title: const Text("Riwayat Pembelian"),
        // centerTitle: true,
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

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  data.gambarObat ?? 'asset/obat/default.png',
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                data.namaObat,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.kategori),
                  Text("Pembeli: ${data.namaPembeli ?? '-'}"),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _badgeColor(data.metode),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _metodeText(data.metode),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        data.tanggal,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                "Rp ${data.total}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPembelianPage(
                      transaksi: data,
                      onDelete: () {
                        // hapus dari list
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
                                setState(() {
                                  riwayat[index] = updated;
                                });
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
            ),
          );
        },
      ),
    );
  }
}
