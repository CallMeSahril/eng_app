import 'package:eng_app/app/data/services/user_preference.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/story_progress_model.dart';

class StoryProgressService {
  final String baseUrl = 'http://195.88.211.177:5006/api/map';

  Future<List<StoryLevel>> fetchStoryProgress() async {
    final userId = await UserPreference.getUserId();

    final response = await http.get(Uri.parse('$baseUrl?user_id=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => StoryLevel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data progress');
    }
  }

  Future<Map<String, dynamic>> addLife({
    required int userId,
    required int amount,
  }) async {
    final url = Uri.parse('$baseUrl/add-life');
    print('Adding life for user $userId with amount $amount');
    print('Request URL: $url');
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'user_id': userId, 'amount': amount}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add life: ${response.statusCode}');
    }
  }
}
