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
        title: const Text("Profil Pengguna"),
        backgroundColor: Color.fromARGB(255, 61, 180, 223)
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // UPDATE: loading
          : user == null
          ? const Center(
              child: Text("Pengguna tidak ditemukan"),
            ) // UPDATE: jika user null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Nama", user!.nama),
                      _infoRow("Email", user!.email),
                      _infoRow("Telepon", user!.telepon),
                      _infoRow("Alamat", user!.alamat),
                      _infoRow("Username", user!.username),
                      _infoRow("Gender", user!.gender),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
