import 'package:flutter/material.dart';
import 'package:projectuts/data/model/user.dart';
import 'package:projectuts/data/repository/app_repository.dart';

class ProfilPenggunaPage extends StatefulWidget {
  final String username;

  const ProfilPenggunaPage({super.key, required this.username});

  @override
  State<ProfilPenggunaPage> createState() => _ProfilPenggunaPageState();
}

class _ProfilPenggunaPageState extends State<ProfilPenggunaPage> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? u = await AppRepository().getUserByUsername(widget.username);
    setState(() {
      user = u;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0077B6),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Profil Pengguna",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text("Pengguna tidak ditemukan"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 57,
                    backgroundColor: Color(0xFF0077B6),
                    child: Text(
                      user!.nama.isNotEmpty ? user!.nama[0].toUpperCase() : "?",
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _infoRow(Icons.person, "Nama", user!.nama),
                          _infoRow(Icons.email, "Email", user!.email),
                          _infoRow(Icons.phone, "Telepon", user!.telepon),
                          _infoRow(Icons.location_city, "Alamat", user!.alamat),
                          _infoRow(
                            Icons.account_circle,
                            "Username",
                            user!.username,
                          ),
                          _infoRow(Icons.wc, "Gender", user!.gender),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF0077B6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
