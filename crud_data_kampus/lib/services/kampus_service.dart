import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/kampus_model.dart';

const String baseUrl = 'http://your_Ip_here:8000/api/kampus';

class KampusService {
  static Future<List<Kampus>> fetchKampus() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("ISI RESPONSE: ${response.body}"); // ✅ debug dipindah ke dalam method

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Kampus.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data kampus');
    }
  }

  static Future<void> createKampus(Kampus kampus) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kampus.toJson()),
    );
  }

  static Future<void> updateKampus(int id, Kampus kampus) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kampus.toJson()),
    );
  }

  static Future<void> deleteKampus(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
