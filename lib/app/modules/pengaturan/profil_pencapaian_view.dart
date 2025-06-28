import 'package:cached_network_image/cached_network_image.dart';
import 'package:eng_app/app/modules/pengaturan/achievement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilPencapaianView extends StatelessWidget {
  const ProfilPencapaianView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AchievementController());
    final userId = 21; // Ganti dinamis sesuai user login
    controller.loadAchievements(userId);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F1B5),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final user = controller.userAchievement.value!;
        return Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Pencapaian",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children:
                        user.achievements.map((a) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              a.gambar == null || a.gambar!.isEmpty
                                  ? Image.asset(
                                    'assets/locked.png', // Pastikan file ini ada di folder assets
                                    width: 48,
                                    height: 48,
                                  )
                                  : CachedNetworkImage(
                                    imageUrl:
                                        "https://gg0l3mpr-5006.asse.devtunnels.ms/uploads/${a.gambar}",
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                  ),

                              // CircleAvatar(
                              //   radius: 24,
                              //   backgroundColor: Colors.blue[200],
                              //   child: Icon(Icons.emoji_events, size: 24, color: Colors.white),
                              // ),
                              const SizedBox(height: 4),
                              // Text(
                              //   "Tile ${a.tileId}",
                              //   style: const TextStyle(fontSize: 10),
                              // ),
                            ],
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildInfoHeader("Informasi akun"),
                  _buildInfoRow("Nama", user.name),
                  // _buildInfoRow("Jenis kelamin", "-"),
                  _buildInfoRow("Email", user.email),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xffB68E52),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.brown[900],
            onPressed: () => Get.back(),
          ),
          const Spacer(),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, size: 16, color: Colors.brown),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff9E7425),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black38)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          const Icon(Icons.edit, size: 16, color: Colors.black45),
        ],
      ),
    );
  }
}
