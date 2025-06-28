import 'package:dio/dio.dart';
import 'package:eng_app/app/data/services/user_preference.dart';
import '../models/quiz_response_model.dart';

class QuizService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://gg0l3mpr-5006.asse.devtunnels.ms',
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<QuizResponse> fetchQuiz({
    required int page,
    required int levelId,
  }) async {
    try {
      final userId = await UserPreference.getUserId();
print(levelId);
      final response = await _dio.get(
        '/api/soal/$levelId',
        queryParameters: {'user_id': userId, 'page': page},
      );

      return QuizResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Gagal mengambil data soal: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}
