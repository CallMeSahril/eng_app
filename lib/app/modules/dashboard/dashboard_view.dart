import 'package:eng_app/app/modules/audio/audio_controller.dart';
import 'package:eng_app/app/modules/bab_materi/bab_materi.dart';
import 'package:eng_app/app/modules/bab_materi/materi_controller.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:eng_app/app/modules/home/home_view.dart';
import 'package:eng_app/app/modules/pengaturan/pengaturan_view.dart';
import 'package:eng_app/app/modules/story_telling/story_telling_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final List<Widget> pages = [
    StoryProgressView(),
    BabMateriView(),
    StoryTellingView(),
    PengaturanView(),
  ];

  BottomNavigationBarItem buildNavItem(
    IconData icon,
    String label,
    int index,
    RxInt selectedIndex,
  ) {
    bool isSelected = selectedIndex.value == index;
    return BottomNavigationBarItem(
      icon: Container(
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                )
                : null,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.brown : Colors.grey),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.brown : Colors.grey),
            ),
          ],
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xffF9F1B5),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: pages[controller.selectedIndex.value],
            ),

            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: Icon(
                  AudioController.isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.brown[800],
                  size: 30,
                ),
                onPressed: () async {
                  await AudioController.toggle();
                },
                tooltip: AudioController.isMuted ? 'Unmute' : 'Mute',
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            buildNavItem(
              Icons.sports_esports,
              'Game',
              0,
              controller.selectedIndex,
            ),

            buildNavItem(
              Icons.menu_book,
              'Materi',
              1,
              controller.selectedIndex,
            ),
            buildNavItem(
              Icons.record_voice_over,
              'Story Telling',
              2,
              controller.selectedIndex,
            ),
            buildNavItem(
              Icons.settings,
              'Setting',
              3,
              controller.selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
