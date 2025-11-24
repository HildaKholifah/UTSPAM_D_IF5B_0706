import 'package:flutter/material.dart';
import 'package:projectuts/presentation/form_pembelian_page.dart';
import 'package:projectuts/presentation/login_page.dart';
import 'package:projectuts/presentation/pembelian_obat_page.dart';
import 'package:projectuts/presentation/profil_pengguna_page.dart';
import 'package:projectuts/presentation/riwayat_pembelian_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Color(0xFF0077B6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: const Text(
          "MediKlik",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset("assets/presentation/Logo MediKlik.png"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo, $username 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0077B6),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _menuCard(
                  icon: Icons.shopping_cart,
                  label: "Beli Obat",
                  colors: [Color(0xFF00B4D8), Color(0xFF0077B6)],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PembelianObatPage(username: username),
                      ),
                    );
                  },
                ),
                _menuCard(
                  icon: Icons.history,
                  label: "Riwayat",
                  colors: [Color(0xFF90BE6D), Color(0xFF57A773)],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RiwayatPembelianPage(username: username),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _menuCard(
                  icon: Icons.person,
                  label: "Profil",
                  colors: [Color(0xFF577590), Color(0xFF34495E)],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilPenggunaPage(username: username),
                      ),
                    );
                  },
                ),
                _menuCard(
                  icon: Icons.logout,
                  label: "Logout",
                  colors: [Colors.redAccent, Colors.red],
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),
            const Text(
              "Rekomendasi Obat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  _obatCard(
                    gambar: "assets/obat/Paracetamol.png",
                    nama: "Paracetamol",
                    kategori: "Pereda Demam",
                    harga: "Rp10.000",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormPembelianPage(
                            nama: "Paracetamol",
                            kategori: "Pereda Demam",
                            harga: 10000,
                            username: username,
                          ),
                        ),
                      );
                    },
                  ),
                  _obatCard(
                    gambar: "assets/obat/Amoxicillin.png",
                    nama: "Amoxicillin",
                    kategori: "Antibiotik",
                    harga: "Rp25.000",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormPembelianPage(
                            nama: "Amoxicillin",
                            kategori: "Antibiotik",
                            harga: 25000,
                            username: username,
                          ),
                        ),
                      );
                    },
                  ),
                  _obatCard(
                    gambar: "assets/obat/Betadine.png",
                    nama: "Betadine",
                    kategori: "Antiseptik",
                    harga: "Rp15.000",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormPembelianPage(
                            nama: "Betadine",
                            kategori: "Antiseptik",
                            harga: 15000,
                            username: username,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String label,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _obatCard({
    required String gambar,
    required String nama,
    required String kategori,
    required String harga,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(gambar, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(
          nama,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(kategori),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              harga,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: Size(60, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(Icons.add_shopping_cart, size: 16),
              label: Text("Beli", style: TextStyle(fontSize: 13)),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
