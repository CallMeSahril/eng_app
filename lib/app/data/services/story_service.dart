import 'dart:convert';
import 'package:eng_app/app/data/services/user_preference.dart';
import 'package:http/http.dart' as http;
import '../models/story_model.dart';

class StoryService {
  final String baseUrl = 'http://195.88.211.177:5006/api';

  Future<List<Story>> getStoryProgressByUser() async {
    final userId = await UserPreference.getUserId();

    final response = await http.get(
      Uri.parse('$baseUrl/storytelling-progress/$userId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Story.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data storytelling');
    }
  }
}
