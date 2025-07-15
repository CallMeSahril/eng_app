import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/achievement_model.dart';

class AchievementService {
  final baseUrl = "https://nngwj5fn-5006.asse.devtunnels.ms/api/achievement";

  Future<UserAchievement> fetchAchievements(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/achievements/$userId"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserAchievement.fromJson(jsonData);
    } else {
      throw Exception("Failed to load achievement");
    }
  }
}
