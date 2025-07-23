class MateriModel {
  final int id;
  final String bab;
  final String judul;
  final String filename;
  final bool isWatched;
  final bool isCompleted;
   String? watchedAt;
   String? completedAt;
  final String pdfUrl;

  MateriModel({
    required this.id,
    required this.bab,
    required this.judul,
    required this.filename,
    required this.isWatched,
    required this.isCompleted,
    required this.watchedAt,
    required this.completedAt,
    required this.pdfUrl,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'http://195.88.211.177:5006/uploads';
    String filename = json['filename'];
    return MateriModel(
      id: json['id'],
      bab: json['bab'],
      judul: json['judul'],
      filename: filename,
      isWatched: json['is_watched'],
      isCompleted: json['is_completed'],
      watchedAt: json['watched_at'],
      completedAt: json['completed_at'],
      pdfUrl: '$baseUrl/$filename',
    );
  }
}
