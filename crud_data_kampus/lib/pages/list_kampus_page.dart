import 'package:flutter/material.dart';
import '../model/kampus_model.dart';
import '../services/kampus_service.dart';
import 'detail_kampus_page.dart';

class ListKampusPage extends StatefulWidget {
  const ListKampusPage({super.key});

  @override
  State<ListKampusPage> createState() => _ListKampusPageState();
}

class _ListKampusPageState extends State<ListKampusPage> {
  late Future<List<Kampus>> kampusList;

  @override
  void initState() {
    super.initState();
    kampusList = KampusService.fetchKampus();
  }

  void refreshData() {
    setState(() {
      kampusList = KampusService.fetchKampus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kampus'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/form');
          if (result == true) refreshData();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Kampus>>(
        future: kampusList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final kampus = snapshot.data![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo.shade100,
                    child: const Icon(Icons.school, color: Colors.indigo),
                  ),
                  title: Text(
                    kampus.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    kampus.kategori,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/form',
                            arguments: kampus,
                          );
                          if (result == true) refreshData();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Hapus Data'),
                              content: const Text('Yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await KampusService.deleteKampus(kampus.id!);
                            refreshData();
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailKampusPage(kampus: kampus),
                      ),
                    );
                    if (result == true) refreshData();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
