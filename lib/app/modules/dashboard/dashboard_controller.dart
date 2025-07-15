import 'package:eng_app/app/data/services/story_progress_service.dart';
import 'package:eng_app/app/modules/home/story_progress_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bab_materi/materi_controller.dart';
// import controller lainnya jika dibutuhkan

class DashboardController extends GetxController {
  final MateriController materiController = Get.put(MateriController());

  var selectedIndex = 0.obs;
  var userId = 0.obs;
  var name = ''.obs;
  var email = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void changePage(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 1: // Tab Materi
        if (Get.isRegistered<MateriController>()) {
          Get.delete<MateriController>();
        }
        Get.put(MateriController());
        break;

      case 0: // Tab Story Telling (misal)
        if (Get.isRegistered<StoryProgressController>()) {
          Get.delete<StoryProgressController>();
        }
        Get.put(StoryProgressController(StoryProgressService()));
        break;

      // Tambahkan case lain jika tab lain juga perlu controller
    }
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('user_id') ?? 0;
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
  }
}
