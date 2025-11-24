import 'package:flutter/material.dart';
import 'package:projectuts/presentation/form_pembelian_page.dart';

class PembelianObatPage extends StatelessWidget {
  final String username;

  PembelianObatPage({super.key, required this.username});

  final List<Map<String, dynamic>> dataObat = [
    {
      "nama": "Paracetamol",
      "kategori": "Pereda Demam",
      "harga": 10000,
      "gambar": "assets/obat/Paracetamol.png",
    },
    {
      "nama": "Amoxicillin",
      "kategori": "Antibiotik",
      "harga": 25000,
      "gambar": "assets/obat/Amoxicillin.png",
    },
    {
      "nama": "Betadine",
      "kategori": "Antiseptik",
      "harga": 15000,
      "gambar": "assets/obat/Betadine.png",
    },
    {
      "nama": "Oralit",
      "kategori": "Diare",
      "harga": 5000,
      "gambar": "assets/obat/Oralit.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0077B6),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Daftar Obat",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: dataObat.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            var obat = dataObat[index];

            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(obat['gambar'], fit: BoxFit.contain),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      obat['nama'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),

                    Text(
                      obat['kategori'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Rp${obat['harga']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormPembelianPage(
                                nama: obat['nama'],
                                kategori: obat['kategori'],
                                harga: obat['harga'],
                                username: username,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                        ),
                        child: const Text(
                          "Beli",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
