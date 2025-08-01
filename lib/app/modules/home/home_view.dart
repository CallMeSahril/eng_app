import 'package:eng_app/app/data/services/story_progress_service.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:eng_app/app/modules/home/quiz_view.dart';
import 'package:eng_app/app/modules/home/story_progress_controller.dart';
import 'package:eng_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Posisi tetap (fixed steps)
List<Offset> generateFixedSteps() {
  List<double> xList = [
    65,
    61,
    70,
    99,
    157,
    214,
    256,
    269,
    268,
    250,
    213,
    160,
    108,
    64,
    60,
    62,
  ];

  List<double> yList = [
    10,
    64,
    117,
    169,
    185,
    201,
    242,
    296,
    353,
    407,
    448,
    461,
    482,
    529,
    589,
    644,
  ];

  List<Offset> result = [];

  for (int i = 0; i < 16; i++) {
    result.add(Offset(xList[i], yList[i]));
  }

  return result;
}

class StoryProgressView extends StatelessWidget {
  const StoryProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoryProgressController(StoryProgressService()));
    final scrollController = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final firstUnlockedIndex = controller.storyLevels.indexWhere(
            (level) => level.tiles.any((tile) => tile.status == 'unlocked'),
          );
          if (firstUnlockedIndex != -1) {
            scrollController.animateTo(
              firstUnlockedIndex * 600,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        });
        return ListView.builder(
          controller: scrollController,
          itemCount: controller.storyLevels.length,
          itemBuilder: (context, levelIndex) {
            final level = controller.storyLevels[levelIndex];
            final positions = generateFixedSteps();
            if (level.lives <= 0) {
              // Pastikan hanya sekali tampil per level
              if (level.lives <= 0) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.defaultDialog(
                    title: "Out of Lives",
                    middleText:
                        "You have no more lives left.\nPlease read the material or watch the story to continue.",
                    // textConfirm: "Go to Material",
                    textCancel: "OK",
                    confirmTextColor: Colors.white,
                    // onConfirm: () {
                    //   Get.back(); // tutup dialog
                    //   // TODO: arahkan ke halaman materi
                    //   Get.toNamed(
                    //     '/material',
                    //   ); // atau panggil Get.to(MaterialPage());
                    // },
                    onCancel: () {
                      Get.back(); // tutup dialog
                      // TODO: arahkan ke halaman storytelling
                    },
                  );
                });
              }
            }
            // return SizedBox(
            //   width: 360, // FIXED WIDTH sesuai desain (misal: 392px)
            //   height: 700, // FIXED HEIGHT sesuai desain posisi tile
            //   child: Stack(
            //     children: [
            //       Align(
            //         alignment:
            //             Alignment
            //                 .centerLeft, // atau Alignment.center, sesuai kebutuhan
            //         child: Container(
            //           width: 390,
            //           height: 700,
            //           decoration: BoxDecoration(
            //             image: DecorationImage(
            //               fit: BoxFit.cover,
            //               image: NetworkImage(
            //                 'http://195.88.211.177:5006/uploads/${level.backgroundImage}',
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),

            //       ...List.generate(positions.length, (index) {
            //         return _ClickableTile(
            //           status: level.tiles[index].status,
            //           image: level.tiles[index].icon,
            //           position: positions[index],
            //           index: index + 1,
            //           onTap: () {
            //             if (level.tiles[index].status == 'unlocked') {
            //               Get.to(
            //                 () => QuizPage(
            //                   levelId: level.tiles[index].levelId,
            //                   tileId: level.tiles[index].id,
            //                 ),
            //               );
            //             }
            //           },
            //         );
            //       }),
            //     ],
            //   ),
            // );
            return Container(
              width: double.infinity, // ambil seluruh lebar layar
              color:
                  levelIndex == 0
                      ? Color(0xffDFF9AE)
                      : levelIndex == 1
                      ? Color(0xffFFEBEC)
                      : levelIndex == 3
                      ? const Color(0xffE5E8EB)
                      : levelIndex == 4
                      ? Color(0xffF5F5F5)
                      : Colors.transparent, // atau warna background yang cocok
              child: Center(
                child: SizedBox(
                  width: 390,
                  height: 700,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'http://195.88.211.177:5006/uploads/${level.backgroundImage}',
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(positions.length, (index) {
                        return _ClickableTile(
                          status: level.tiles[index].status,
                          image: level.tiles[index].icon,
                          position: positions[index],
                          index: index + 1,
                          onTap: () {
                            if (level.tiles[index].status == 'unlocked') {
                              Get.to(
                                () => QuizPage(
                                  levelId: level.tiles[index].levelId,
                                  tileId: level.tiles[index].id,
                                ),
                              );
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _ClickableTile extends StatefulWidget {
  final Offset position;
  final int index;
  final String image;
  final String status;
  final Function()? onTap;

  const _ClickableTile({
    required this.position,
    required this.index,
    required this.image,
    required this.status,
    super.key,
    this.onTap,
  });

  @override
  State<_ClickableTile> createState() => _ClickableTileState();
}

class _ClickableTileState extends State<_ClickableTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position.dy,
      left: widget.position.dx,
      child: GestureDetector(
        onTap: widget.onTap,
        child:
            widget.status == 'unlocked'
                ? ScaleTransition(scale: _scaleAnimation, child: _buildTile())
                : _buildTile(),
      ),
    );
  }

  Widget _buildTile() {
    if (widget.status == 'locked') {
      return Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.6),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.lock, color: Colors.white),
      );
    } else if (widget.status == 'completed') {
      return Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
          border: Border.all(color: Colors.green, width: 3),
          image: DecorationImage(
            image: NetworkImage(
              'http://195.88.211.177:5006/uploads/${widget.image}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Icon(Icons.check_circle, color: Colors.green, size: 28),
      );
    } else {
      // unlocked
      return Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
          border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(
            image: NetworkImage(
              'http://195.88.211.177:5006/uploads/${widget.image}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
