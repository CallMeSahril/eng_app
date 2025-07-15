class Soal {
  final int id;
  final String pertanyaan;
  final String pilihanA;
  final String pilihanB;
  final String pilihanC;
  final String pilihanD;
  final String gambar;
  final String gambarUrl;
  final String gambarAUrl;
  final String gambarBUrl;
  final String gambarCUrl;
  final String gambarDUrl;

  Soal({
    required this.id,
    required this.pertanyaan,
    required this.pilihanA,
    required this.pilihanB,
    required this.pilihanC,
    required this.pilihanD,
    required this.gambar,
    required this.gambarUrl,
    required this.gambarAUrl,
    required this.gambarBUrl,
    required this.gambarCUrl,
    required this.gambarDUrl,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      id: json['id'],
      pertanyaan: json['pertanyaan'],
      pilihanA: json['pilihan_a'],
      pilihanB: json['pilihan_b'],
      pilihanC: json['pilihan_c'],
      pilihanD: json['pilihan_d'],
      gambar: json['gambar'] ?? "",
      gambarUrl: json['gambar_url'] ?? "",
      gambarAUrl: json['gambar_a_url'] ?? "",
      gambarBUrl: json['gambar_b_url'] ?? "",
      gambarCUrl: json['gambar_c_url'] ?? "",
      gambarDUrl: json['gambar_d_url'] ?? "",
    );
  }
}
