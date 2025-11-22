import 'package:flutter/material.dart';
import 'package:projectuts/presentation/detail_pembelian_page.dart';
import 'package:projectuts/presentation/form_pembelian_page.dart';
import 'package:projectuts/presentation/home_page.dart';

class RiwayatPembelianPage extends StatelessWidget {
  final Map<String, dynamic>? transaksiBaru;

  RiwayatPembelianPage({super.key, this.transaksiBaru});

  final List<Map<String, dynamic>> dummyRiwayat = [
    {
      "nama": "Paracetamol",
      "kategori": "Pereda Demam",
      "total": 20000,
      "gambar": Icons.medication,
      "metode": "langsung",
      "tanggal": "20 Nov 2025",
    },
    {
      "nama": "Amoxicillin",
      "kategori": "Antibiotik",
      "total": 25000,
      "gambar": Icons.medical_services,
      "metode": "resep",
      "tanggal": "21 Nov 2025",
    },
  ];

  Color _badgeColor(String metode) {
    return metode == "resep" ? Colors.orange : Colors.blue;
  }

  String _metodeText(String metode) {
    return metode == "resep" ? "Resep Dokter" : "Pembelian Langsung";
  }

  @override
  Widget build(BuildContext context) {
    if (transaksiBaru != null) {
      dummyRiwayat.insert(0, transaksiBaru!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3DB4DF),
        title: const Text("Riwayat Pembelian"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyRiwayat.length,
        itemBuilder: (context, index) {
          var data = dummyRiwayat[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(data["gambar"], size: 40, color: Colors.teal),
              title: Text(
                data["nama"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["kategori"]),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _badgeColor(data["metode"]),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _metodeText(data["metode"]),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        data["tanggal"],
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
                "Rp ${data["total"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
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
                        dummyRiwayat.removeAt(index);
                        Navigator.pop(context);
                      },
                      onEdit: () {
                        // buka halaman edit transaksi
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormPembelianPage(
                              nama: data['nama'],
                              kategori: data['kategori'],
                              harga:
                                  data['total'], // total bisa dipakai sebagai harga sementara
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
