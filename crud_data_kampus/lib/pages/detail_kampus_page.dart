import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/kampus_model.dart';
import '../services/kampus_service.dart';

class DetailKampusPage extends StatelessWidget {
  final Kampus kampus;

  const DetailKampusPage({super.key, required this.kampus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kampus.nama),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                '/form',
                arguments: kampus,
              );
              if (result == true) {
                Navigator.pop(context, true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text('Yakin ingin menghapus kampus ini?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
                  ],
                ),
              );

              if (confirm == true) {
                await KampusService.deleteKampus(kampus.id!);
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(kampus.latitude, kampus.longitude),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("lokasi"),
                      position: LatLng(kampus.latitude, kampus.longitude),
                      infoWindow: InfoWindow(title: kampus.nama),
                    )
                  },
                  zoomControlsEnabled: false,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                detailCard(Icons.location_on, "Alamat", kampus.alamat),
                detailCard(Icons.phone, "Telepon", kampus.noTelp),
                detailCard(Icons.school, "Kategori", kampus.kategori),
                detailCard(Icons.book, "Jurusan", kampus.jurusan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailCard(IconData icon, String label, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}
