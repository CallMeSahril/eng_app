import 'package:dio/dio.dart';
import 'package:eng_app/app/data/services/user_preference.dart';

class QuizAnswerService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://195.88.211.177:5006',
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> kirimJawaban({
    required int tileId,
    required int soalId,
    required String jawaban,
  }) async {
    try {
      final userId = await UserPreference.getUserId();

      final response = await _dio.post(
        '/api/soal/jawab',
        data: {
          'user_id': userId,
          'tile_id': tileId,
          'soal_id': soalId,
          'jawaban': jawaban,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception('Gagal kirim jawaban: ${e.message}');
    }
  }
}
