import 'soal_model.dart';

class QuizResponse {
  final List<Soal> soalList;
  final int page;
  final int totalSoal;
  final int lives;
  final String status;

  QuizResponse({
    required this.soalList,
    required this.page,
    required this.totalSoal,
    required this.lives,
    required this.status,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> soalJson = json['soal'];
    final soalList = soalJson.map((e) => Soal.fromJson(e)).toList();

    return QuizResponse(
      soalList: soalList,
      page: json['page'],
      totalSoal: json['total_soal'],
      lives: json['lives'],
      status: json['status'],
    );
  }
}
