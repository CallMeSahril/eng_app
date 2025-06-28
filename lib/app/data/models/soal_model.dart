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
    final soal = json['soal'];
    return Soal(
      id: soal['id'],
      pertanyaan: soal['pertanyaan'],
      pilihanA: soal['pilihan_a'],
      pilihanB: soal['pilihan_b'],
      pilihanC: soal['pilihan_c'],
      pilihanD: soal['pilihan_d'],
      gambar: soal['gambar'] ?? "",
      gambarUrl: soal['gambar_url'],
      gambarAUrl: soal['gambar_a_url'],
      gambarBUrl: soal['gambar_b_url'],
      gambarCUrl: soal['gambar_c_url'],
      gambarDUrl: soal['gambar_d_url'],
    );
  }
}
