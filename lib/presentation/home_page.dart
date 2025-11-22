import 'package:flutter/material.dart';
import 'package:projectuts/presentation/login_page.dart';
import 'package:projectuts/presentation/register_page.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menuButton(
                  icon: Icons.shopping_cart,
                  title: "Beli Obat",
                  color: greenPastel,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(), // sementara
                      ),
                    );
                  },
                ),
                _menuButton(
                  icon: Icons.history,
                  title: "Riwayat",
                  color: Color(0xFF7EC8E3),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(), // sementara
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menuButton(
                  icon: Icons.person,
                  title: "Profil",
                  color: Color(0xFF7EC8E3),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(), // sementara
                      ),
                    );
                  },
                ),
                _menuButton(
                  icon: Icons.logout,
                  title: "Logout",
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.pushReplacement(
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
                    harga: "Rp 10.000",
                    onTap: () {},
                  ),
                  _itemObat(
                    nama: "Amoxicillin",
                    kategori: "Antibiotik",
                    harga: "Rp 25.000",
                    onTap: () {},
                  ),
                  _itemObat(
                    nama: "Betadine",
                    kategori: "Antiseptik",
                    harga: "Rp 15.000",
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
        title: Text(nama),
        subtitle: Text(kategori),
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

