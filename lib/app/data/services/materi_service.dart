import 'package:dio/dio.dart';
import 'package:eng_app/app/data/services/user_preference.dart';
import '../models/materi_model.dart';

class MateriService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://nngwj5fn-5006.asse.devtunnels.ms/materi-progress/';

  Future<List<MateriModel>> fetchMateri() async {
    print('Data materi berhasil dimuat: ${baseUrl} items');
    final userId = await UserPreference.getUserId();
    try {
      final response = await _dio.get("${baseUrl}${userId}");
      print('Data materi berhasil dimuat: ${baseUrl} items');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Data materi berhasil dimuat: ${data.length} items');
        return data.map((e) => MateriModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal memuat data materi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat memuat materi: $e');
    }
  }
}
