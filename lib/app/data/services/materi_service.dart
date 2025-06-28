import 'package:dio/dio.dart';
import '../models/materi_model.dart';

class MateriService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://gg0l3mpr-5006.asse.devtunnels.ms/materi-progress/9';

  Future<List<MateriModel>> fetchMateri() async {
    print('Data materi berhasil dimuat: ${baseUrl} items');

    try {
      final response = await _dio.get(baseUrl);
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
