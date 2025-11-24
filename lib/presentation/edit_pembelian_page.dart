import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectuts/data/model/pembelian.dart';

class EditTransaksiPage extends StatefulWidget {
  final Pembelian transaksi;
  final Function(Pembelian) onUpdate;

  const EditTransaksiPage({
    super.key,
    required this.transaksi,
    required this.onUpdate,
  });

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _jumlahCtr;
  late TextEditingController _catatanCtr;
  late TextEditingController _nomorResepCtr;
  String? metodePembelian;
  int totalHarga = 0;
  File? gambarResep;

  @override
  void initState() {
    super.initState();
    _jumlahCtr = TextEditingController(
      text: widget.transaksi.jumlah.toString(),
    );
    _catatanCtr = TextEditingController(text: widget.transaksi.catatan ?? '');
    _nomorResepCtr = TextEditingController(
      text: widget.transaksi.nomorResep ?? '',
    );
    metodePembelian =
        widget.transaksi.metode?.toLowerCase().contains("resep") == true
        ? "resep"
        : "langsung";

    if (widget.transaksi.gambarResep != null &&
        File(widget.transaksi.gambarResep!).existsSync()) {
      gambarResep = File(widget.transaksi.gambarResep!);
    }

    _hitungTotal();
    _jumlahCtr.addListener(_hitungTotal);
  }

  void _hitungTotal() {
    int qty = int.tryParse(_jumlahCtr.text) ?? 0;
    setState(() {
      totalHarga = (widget.transaksi.harga ?? 0) * qty;
    });
  }

  Future<void> _pilihGambar(bool dariKamera) async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: dariKamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 70,
    );
    if (file != null) setState(() => gambarResep = File(file.path));
  }

  Color _badgeColor(String metode) {
    if (metode == "Resep Dokter") return Color(0xFF7EC8E3);
    if (metode == "Langsung") return Color(0xFF90BE6D);
    return Colors.grey;
  }

  void _validasiDanUpdate() {
    if (!_formKey.currentState!.validate()) return;
    if (metodePembelian == "resep" && gambarResep == null) {
      _showAlert(
        "Foto resep wajib diunggah untuk pembelian dengan resep dokter!",
      );
      return;
    }

    String metodeDisplay = metodePembelian == "resep"
        ? "Resep Dokter"
        : "Langsung";

    final updatedTransaksi = Pembelian(
      id: widget.transaksi.id,
      namaObat: widget.transaksi.namaObat,
      kategori: widget.transaksi.kategori,
      namaPembeli: widget.transaksi.namaPembeli,
      jumlah: int.parse(_jumlahCtr.text),
      catatan: _catatanCtr.text,
      harga: widget.transaksi.harga,
      total: totalHarga,
      metode: metodeDisplay,
      nomorResep: metodePembelian == "resep" ? _nomorResepCtr.text : null,
      gambarResep: gambarResep?.path ?? widget.transaksi.gambarResep,
      gambarObat: widget.transaksi.gambarObat,
      tanggal: widget.transaksi.tanggal,
      status: widget.transaksi.status,
    );

    widget.onUpdate(updatedTransaksi);
    Navigator.pop(context);
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
        title: const Text(
          "Edit Pembelian",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.transaksi.gambarObat != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.transaksi.gambarObat!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              Text(
                "Nama Obat: ${widget.transaksi.namaObat}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Kategori: ${widget.transaksi.kategori}",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                "Harga Satuan: Rp${widget.transaksi.harga}",
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Jumlah
              TextFormField(
                controller: _jumlahCtr,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) return "Jumlah wajib diisi";
                  if (int.tryParse(v) == null || int.parse(v) <= 0)
                    return "Jumlah harus angka positif";
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Jumlah Pembelian"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Catatan
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
                      onChanged: (val) => setState(() => metodePembelian = val),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Resep Dokter"),
                      value: "resep",
                      groupValue: metodePembelian,
                      onChanged: (val) => setState(() => metodePembelian = val),
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
                          onPressed: () => _pilihGambar(true),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Kamera"),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _pilihGambar(false),
                          icon: const Icon(Icons.image),
                          label: const Text("Galeri"),
                        ),
                      ],
                    ),
                    if (gambarResep != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            gambarResep!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
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
                  color: Color(0xFF0077B6),
                ),
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _validasiDanUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0077B6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Batal",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
