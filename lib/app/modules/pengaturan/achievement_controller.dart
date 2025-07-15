import 'package:eng_app/app/data/models/achievement_model.dart';
import 'package:eng_app/app/data/services/achievement_service.dart';
import 'package:eng_app/app/data/services/user_preference.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementController extends GetxController {
  final AchievementService _service = AchievementService();

  var userAchievement = Rxn<UserAchievement>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  Future<Map<String, String>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '-';
    final email = prefs.getString('email') ?? '-';
    return {'name': name, 'email': email};
  }

  void loadAchievements() async {
    try {
      final userId = await UserPreference.getUserId();
      isLoading.value = true;
      final result = await _service.fetchAchievements(userId ?? 0);
      userAchievement.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
