import 'package:eng_app/app/data/models/achievement_model.dart';
import 'package:eng_app/app/data/services/achievement_service.dart';
import 'package:get/get.dart';

class AchievementController extends GetxController {
  final AchievementService _service = AchievementService();

  var userAchievement = Rxn<UserAchievement>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void loadAchievements(int userId) async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAchievements(userId);
      userAchievement.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
