import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectuts/data/model/pembelian.dart';
import 'package:projectuts/data/repository/app_repository.dart';
import 'package:projectuts/presentation/riwayat_pembelian_page.dart';

class FormPembelianPage extends StatefulWidget {
  final String nama;
  final String kategori;
  final int harga;
  final String username;

  FormPembelianPage({
    super.key,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.username,
  });

  @override
  State<FormPembelianPage> createState() => _FormPembelianPageState();
}

class _FormPembelianPageState extends State<FormPembelianPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaPembeliCtr = TextEditingController();
  final _jumlahCtr = TextEditingController();
  final _catatanCtr = TextEditingController();
  final _nomorResepCtr = TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool _pilihGambar = false;
  String? metodePembelian = "langsung"; // default
  int totalHarga = 0;
  File? fotoResep;

  String _getGambarDummy(String namaObat) {
    final Map<String, String> gambarObatDummy = {
      'Paracetamol': 'assets/obat/Paracetamol.png',
      'Amoxicillin': 'assets/obat/Amoxicillin.png',
      'Oralit': 'assets/obat/Oralit.png',
      'Betadine': 'assets/obat/Betadine.png',
    };
    return gambarObatDummy[namaObat] ?? 'assets/obat/default.png';
  }

  @override
  void initState() {
    super.initState();
    _jumlahCtr.addListener(_hitungTotal);
  }

  void _hitungTotal() {
    int qty = int.tryParse(_jumlahCtr.text) ?? 0;
    setState(() {
      totalHarga = widget.harga * qty;
    });
  }

  Future<void> pilihGambar({required bool dariKamera}) async {
    if (_pilihGambar) return;
    _pilihGambar = true;

    try {
      XFile? file = await picker.pickImage(
        source: dariKamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
      );

      if (file != null) {
        setState(() {
          fotoResep = File(file.path);
        });
      }
    } catch (e) {
      print("Gagal mengambil gambar: $e");
    } finally {
      _pilihGambar = false;
    }
  }

  void _validasiDanSimpan() async {
    if (!_formKey.currentState!.validate()) return;

    if (metodePembelian == "resep" && fotoResep == null) {
      _showAlert(
        "Foto resep wajib diunggah untuk pembelian dengan resep dokter!",
      );
      return;
    }

    Pembelian pembelian = Pembelian(
      namaObat: widget.nama, //error
      kategori: widget.kategori,
      namaPembeli: widget.username,
      jumlah: int.parse(_jumlahCtr.text),
      catatan: _catatanCtr.text,
      harga: widget.harga,
      total: totalHarga,
      tanggal: DateTime.now().toString().substring(0, 10),
      metode: metodePembelian == "resep" ? "Resep Dokter" : "Langsung",
      nomorResep: metodePembelian == "resep" ? _nomorResepCtr.text : null,
      gambarResep: fotoResep?.path,
      gambarObat: _getGambarDummy(widget.nama),
      status: "Selesai",
    );

    await AppRepository().tambahPembelian(pembelian);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pembelian berhasil disimpan!")),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => RiwayatPembelianPage(username: widget.username),
      ),
      (route) => false,
    );
  }

  void _showAlert(String pesan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Validasi"),
        content: Text(pesan),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3DB4DF),
        title: Text("Pembelian Obat - ${widget.nama}"),
        // centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Obat: ${widget.nama}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Kategori: ${widget.kategori}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),

                Text(
                  "Harga: Rp ${widget.harga}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _namaPembeliCtr,
                  validator: (v) => v!.isEmpty ? "Nama wajib diisi" : null,
                  decoration: const InputDecoration(
                    label: Text("Nama Pembeli"),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _jumlahCtr,
                  validator: (v) {
                    if (v!.isEmpty) return "Jumlah wajib diisi";
                    if (int.tryParse(v) == null || int.parse(v) <= 0) {
                      return "Jumlah harus angka positif";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Jumlah Pembelian"),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _catatanCtr,
                  decoration: const InputDecoration(
                    label: Text("Catatan (Opsional)"),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Metode Pembelian",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Langsung"),
                        value: "langsung",
                        groupValue: metodePembelian,
                        onChanged: (val) {
                          setState(() => metodePembelian = val);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Resep Dokter"),
                        value: "resep",
                        groupValue: metodePembelian,
                        onChanged: (val) {
                          setState(() => metodePembelian = val);
                        },
                      ),
                    ),
                  ],
                ),

                if (metodePembelian == "resep")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _nomorResepCtr,
                        validator: (v) {
                          if (metodePembelian == "resep") {
                            if (v!.isEmpty) return "Nomor resep wajib diisi";
                            if (v.length < 6)
                              return "Nomor resep minimal 6 karakter";
                            if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(v))
                              return "Harus kombinasi huruf & angka";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text("Nomor Resep Dokter"),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => pilihGambar(dariKamera: true),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Kamera"),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => pilihGambar(dariKamera: false),
                            icon: const Icon(Icons.image),
                            label: const Text("Galeri"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      if (fotoResep != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            fotoResep!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),

                const SizedBox(height: 20),
                Text(
                  "Total Harga: Rp$totalHarga",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _validasiDanSimpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Beli Obat"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
