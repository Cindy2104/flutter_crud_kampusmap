import 'package:flutter/material.dart';
import '../model/kampus_model.dart';
import '../services/kampus_service.dart';

class FormKampusPage extends StatefulWidget {
  final Kampus? kampus;

  const FormKampusPage({super.key, this.kampus});

  @override
  State<FormKampusPage> createState() => _FormKampusPageState();
}

class _FormKampusPageState extends State<FormKampusPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaC, alamatC, telpC, kategoriC, latC, longC, jurusanC;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.kampus?.nama ?? '');
    alamatC = TextEditingController(text: widget.kampus?.alamat ?? '');
    telpC = TextEditingController(text: widget.kampus?.noTelp ?? '');
    kategoriC = TextEditingController(text: widget.kampus?.kategori ?? '');
    latC = TextEditingController(text: widget.kampus?.latitude.toString() ?? '');
    longC = TextEditingController(text: widget.kampus?.longitude.toString() ?? '');
    jurusanC = TextEditingController(text: widget.kampus?.jurusan ?? '');
  }

  @override
  void dispose() {
    namaC.dispose();
    alamatC.dispose();
    telpC.dispose();
    kategoriC.dispose();
    latC.dispose();
    longC.dispose();
    jurusanC.dispose();
    super.dispose();
  }

  void simpanData() async {
    if (_formKey.currentState!.validate()) {
      Kampus newData = Kampus(
        nama: namaC.text,
        alamat: alamatC.text,
        noTelp: telpC.text,
        kategori: kategoriC.text,
        latitude: double.parse(latC.text),
        longitude: double.parse(longC.text),
        jurusan: jurusanC.text,
      );

      if (widget.kampus == null) {
        await KampusService.createKampus(newData);
      } else {
        await KampusService.updateKampus(widget.kampus!.id!, newData);
      }

      if (context.mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kampus == null ? 'Tambah Kampus' : 'Edit Kampus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              textField(namaC, 'Nama Kampus'),
              textField(alamatC, 'Alamat'),
              textField(telpC, 'No Telepon'),
              textField(kategoriC, 'Kategori (Swasta/Negeri)'),
              textField(latC, 'Latitude', isNumber: true),
              textField(longC, 'Longitude', isNumber: true),
              textField(jurusanC, 'Jurusan'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: simpanData,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
      ),
    );
  }
}
