import 'package:eng_app/app/data/services/story_progress_service.dart';
import 'package:eng_app/app/data/services/user_preference.dart';
import 'package:eng_app/app/modules/home/story_progress_controller.dart';
import 'package:eng_app/main.dart';
import 'package:get/get.dart';
import '../bab_materi/materi_controller.dart';
// import controller lainnya jika dibutuhkan

class DashboardController extends GetxController {
  final MateriController materiController = Get.put(MateriController());

  var selectedIndex = 0.obs;

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
        Get.put(StoryProgressController(StoryProgressService(),));
        break;

      // Tambahkan case lain jika tab lain juga perlu controller
    }
  }


}
