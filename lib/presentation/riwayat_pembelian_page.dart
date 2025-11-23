// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projectuts/presentation/detail_pembelian_page.dart';
import 'package:projectuts/presentation/edit_transaksi_page.dart';
import 'package:projectuts/presentation/home_page.dart';

class RiwayatPembelianPage extends StatefulWidget {
  final Map<String, dynamic>? transaksiBaru;
  final String username;

  RiwayatPembelianPage({Key? key, this.transaksiBaru, required this.username});

  @override
  State<RiwayatPembelianPage> createState() => _RiwayatPembelianPageState();
}

class _RiwayatPembelianPageState extends State<RiwayatPembelianPage> {
  final List<Map<String, dynamic>> dummyRiwayat = [
    {
      "nama": "Paracetamol",
      "kategori": "Pereda Demam",
      "namaPembeli": "Hilda",
      "jumlah": 2,
      "harga": 10000,
      "total": 20000,
      "gambar": "assets/obat/Paracetamol.png",
      "metode": "langsung",
      "tanggal": "20 Nov 2025",
    },
    {
      "nama": "Amoxicillin",
      "kategori": "Antibiotik",
      "namaPembeli": "Rahma",
      "jumlah": 1,
      "harga": 25000,
      "total": 25000,
      "gambar": "assets/obat/Amoxicillin.png",
      "metode": "resep",
      "tanggal": "21 Nov 2025",
      "nomorResep": 123456,
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
    if (widget.transaksiBaru != null) {
      dummyRiwayat.insert(0, widget.transaksiBaru!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Riwayat Pembelian"),
        centerTitle: true,
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
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  data["gambar"],
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
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
                        setState(() => dummyRiwayat.removeAt(index));
                        Navigator.pop(context);
                      },
                      onEdit: () {
                        // buka halaman edit transaksi
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditTransaksiPage(
                              transaksi: data,
                              onUpdate: (updated) {
                                setState(() {
                                  dummyRiwayat[index] = updated;
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
