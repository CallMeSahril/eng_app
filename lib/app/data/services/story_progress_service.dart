import 'package:eng_app/app/data/services/user_preference.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/story_progress_model.dart';

class StoryProgressService {
  final String baseUrl = 'https://gg0l3mpr-5006.asse.devtunnels.ms/api/map';

  Future<List<StoryLevel>> fetchStoryProgress() async {
    final userId = await UserPreference.getUserId();
    print('User ID: $userId');

    final response = await http.get(Uri.parse('$baseUrl?user_id=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => StoryLevel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data progress');
    }
  }
}
