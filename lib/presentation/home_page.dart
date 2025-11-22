import 'package:flutter/material.dart';
import 'package:projectuts/presentation/login_page.dart';
import 'package:projectuts/presentation/pembelian_obat_page.dart';
import 'package:projectuts/presentation/register_page.dart';
import 'package:projectuts/presentation/riwayat_pembelian_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color greenPastel = const Color(0xFF98E2C6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 61, 180, 223),
        title: Text('MediKlik'),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset(
              'assets/presentation/Logo MediKlik.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Halo, Pengguna!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            // MENU 4 FITUR UTAMA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _menuButton(
                  icon: Icons.shopping_cart,
                  title: "Beli Obat",
                  color: greenPastel,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PembelianObatPage(),
                      ),
                    );
                  },
                ),
                _menuButton(
                  icon: Icons.history,
                  title: "Riwayat",
                  color: Color(0xFF7EC8E3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiwayatPembelianPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _menuButton(
                  icon: Icons.person,
                  title: "Profil",
                  color: Color(0xFF7EC8E3),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
                _menuButton(
                  icon: Icons.logout,
                  title: "Logout",
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Rekomendasi Obat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  _itemObat(
                    nama: "Paracetamol",
                    kategori: "Pereda Demam",
                    harga: "Rp10000",
                    onTap: () {},
                  ),
                  _itemObat(
                    nama: "Amoxicillin",
                    kategori: "Antibiotik",
                    harga: "Rp25000",
                    onTap: () {},
                  ),
                  _itemObat(
                    nama: "Betadine",
                    kategori: "Antiseptik",
                    harga: "Rp15000",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemObat({
    required String nama,
    required String kategori,
    required String harga,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.medical_services, color: Colors.teal),
        title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(kategori),
            Text(harga, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          child: const Text("Beli"),
        ),
      ),
    );
  }
}
