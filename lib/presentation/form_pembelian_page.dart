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
  String metodePembelian = "langsung";
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
      namaObat: widget.nama,
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
        backgroundColor: Color(0xFF0077B6),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Pembelian Obat - ${widget.nama}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Obat
                    Row(
                      children: [
                        Image.asset(
                          _getGambarDummy(widget.nama),
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.nama,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.kategori,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Rp ${widget.harga}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      _namaPembeliCtr,
                      "Nama Pembeli",
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Nama wajib diisi";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      _jumlahCtr,
                      "Jumlah Pembelian",
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Jumlah wajib diisi";
                        if (int.tryParse(v) == null || int.parse(v) <= 0) {
                          return "Jumlah harus angka positif";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(_catatanCtr, "Catatan (Opsional)"),
                    const SizedBox(height: 20),

                    // Metode Pembelian
                    Text(
                      "Metode Pembelian",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                setState(() => metodePembelian = "langsung"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: metodePembelian == "langsung"
                                  ? Color(0xFF0077B6)
                                  : Colors.grey.shade300,
                              foregroundColor: metodePembelian == "langsung"
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                            child: const Text("Langsung"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                setState(() => metodePembelian = "resep"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: metodePembelian == "resep"
                                  ? Color(0xFF0077B6)
                                  : Colors.grey.shade300,
                              foregroundColor: metodePembelian == "resep"
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                            child: const Text("Resep Dokter"),
                          ),
                        ),
                      ],
                    ),

                    if (metodePembelian == "resep") ...[
                      const SizedBox(height: 16),
                      _buildTextField(
                        _nomorResepCtr,
                        "Nomor Resep Dokter",
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Nomor resep wajib diisi";
                          if (v.length < 6)
                            return "Nomor resep minimal 6 karakter";
                          if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(v))
                            return "Harus kombinasi huruf & angka";
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
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
                      if (fotoResep != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              fotoResep!,
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],

                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Total Harga: Rp$totalHarga",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0077B6),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _validasiDanSimpan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0077B6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Beli Obat",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
