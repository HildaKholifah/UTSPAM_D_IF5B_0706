import 'package:flutter/material.dart';
import 'package:projectuts/presentation/form_pembelian_page.dart';

class PembelianObatPage extends StatelessWidget {
  PembelianObatPage({super.key});

  final List<Map<String, dynamic>> dataObat = [
    {
      "nama": "Paracetamol",
      "kategori": "Pereda Demam",
      "harga": 10000,
      "gambar": Icons.medication,
    },
    {
      "nama": "Amoxicillin",
      "kategori": "Antibiotik",
      "harga": 25000,
      "gambar": Icons.medical_services,
    },
    {
      "nama": "Betadine",
      "kategori": "Antiseptik",
      "harga": 15000,
      "gambar": Icons.healing,
    },
    {
      "nama": "Oralit",
      "kategori": "Diare",
      "harga": 5000,
      "gambar": Icons.local_drink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3DB4DF),
        title: const Text("Daftar Obat"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: dataObat.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Grid 2 kolom
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            var obat = dataObat[index];

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(obat['gambar'], size: 50, color: Colors.teal),
                    Text(
                      obat['nama'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      obat['kategori'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Rp${obat['harga']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPembelianPage(
                              nama: obat['nama'],
                              kategori: obat['kategori'],
                              harga: obat['harga'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Beli"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
