import 'package:eng_app/app/data/models/story_model.dart';
import 'package:eng_app/app/data/services/story_service.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  final StoryService _service = StoryService();

  var storyList = <Story>[].obs;
  var isLoading = true.obs;

  Future<void> fetchStories() async {
    try {
      isLoading(true);
      final data = await _service.getStoryProgressByUser();
      storyList.assignAll(data);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
