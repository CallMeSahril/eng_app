import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_app/app/data/services/story_progress_service.dart';
import 'package:eng_app/app/modules/audio/audio_controller.dart';
import 'package:eng_app/app/modules/home/story_progress_controller.dart';
import 'package:eng_app/app/modules/story_telling/story_controller.dart';
import 'package:eng_app/app/modules/story_telling/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryTellingView extends StatelessWidget {
  final StoryController controller = Get.put(StoryController());
  final StoryProgressController controllerA = StoryProgressController(
    StoryProgressService(),
  );

  StoryTellingView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchStories();

    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      // appBar: AppBar(title: const Text("Pembahasan Materi")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: ListView.builder(
            itemCount: controller.storyList.length,
            itemBuilder: (context, index) {
              final story = controller.storyList[index];
              return GestureDetector(
                onTap: () async {
                  final videoUrl = "assets/img/${story.videoUrl}";
                  print("Video URL: $videoUrl");
                  await controllerA.addLife(3);
                  await AudioController.pause(); // kamu harus punya method pause()

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerScreen(videoUrl: videoUrl),
                    ),
                  );
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CachedNetworkImage sebagai Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: story.thumbnailUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                height: 180,
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                height: 180,
                                color: Colors.grey,
                                child: const Center(
                                  child: Icon(Icons.broken_image),
                                ),
                              ),
                        ),
                      ),
                      // Judul
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          story.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Deskripsi
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          story.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Status Progress & Favorite
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Progress: ${story.progressSeconds} detik",
                                  ),
                                  Text(
                                    "Sudah Ditonton: ${story.isWatched ? "Ya" : "Belum"}",
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color:
                                  story.isFavorite
                                      ? Colors.yellow
                                      : Colors.grey,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
