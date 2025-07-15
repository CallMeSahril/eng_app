import 'package:eng_app/app/data/models/story_progress_model.dart';
import 'package:eng_app/app/data/services/story_progress_service.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class StoryProgressController extends GetxController {
  final StoryProgressService service;

  StoryProgressController(this.service);

  var storyLevels = <StoryLevel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStory();
  }

  void fetchStory() async {
    try {
      isLoading(true);
      final result = await service.fetchStoryProgress(
      );
      storyLevels.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
