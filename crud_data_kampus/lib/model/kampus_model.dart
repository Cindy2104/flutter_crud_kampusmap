class Kampus {
  final int? id;
  final String nama;
  final String alamat;
  final String noTelp;
  final String kategori;
  final double latitude;
  final double longitude;
  final String jurusan;

  Kampus({
    this.id,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    required this.kategori,
    required this.latitude,
    required this.longitude,
    required this.jurusan,
  });

  factory Kampus.fromJson(Map<String, dynamic> json) {
    return Kampus(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['no_telp'],
      kategori: json['kategori'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      jurusan: json['jurusan'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'alamat': alamat,
    'no_telp': noTelp,
    'kategori': kategori,
    'latitude': latitude,
    'longitude': longitude,
    'jurusan': jurusan,
  };
}
