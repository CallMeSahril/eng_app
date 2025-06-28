import 'soal_model.dart';

class QuizResponse {
  final Soal soal;
  final int page;
  final int totalSoal;
  final int lives;
  final String status;

  QuizResponse({
    required this.soal,
    required this.page,
    required this.totalSoal,
    required this.lives,
    required this.status,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      soal: Soal.fromJson(json),
      page: json['page'],
      totalSoal: json['total_soal'],
      lives: json['lives'],
      status: json['status'],
    );
  }
}
