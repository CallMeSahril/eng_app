import 'package:eng_app/app/data/models/soal_model.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
import 'package:eng_app/app/modules/home/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatelessWidget {
  final int levelId;
  final int tileId;

  QuizPage({super.key, required this.levelId, required this.tileId});

  final List<String> pilihan = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      QuizController(levelId: levelId, tileId: tileId),
    );

    if (tileId == 16 || tileId == 32 || tileId == 48 || tileId == 64) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadSoal(1);
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
              const SizedBox(height: 16),
              const Text(
                "Selamat! Anda telah mendapatkan pencapaian!",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(DashboardView()); // atau arahkan ke halaman lain
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadSoal(1);
    });

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Quiz'),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {

      //     },
      //   ),
      //   actions: [],
      // ),
      backgroundColor: const Color(0xFFFFF3B0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final soal = controller.soalUntukDitampilkan;

            if (soal == null) {
              return const Center(child: Text('Soal tidak tersedia'));
            }
            print("soal gambar: ${soal.gambarUrl}");
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.brown,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${controller.lives}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    soal.pertanyaan,
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (soal.gambarUrl.isNotEmpty)
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(soal.gambarUrl, fit: BoxFit.contain),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5822B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    child: Column(
                      children: [
                        _buildPilihan('A', soal.pilihanA, soal, controller),
                        _buildPilihan('B', soal.pilihanB, soal, controller),
                        _buildPilihan('C', soal.pilihanC, soal, controller),
                        _buildPilihan('D', soal.pilihanD, soal, controller),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPilihan(
    String label,
    String teks,
    Soal soal,
    QuizController controller,
  ) {
    final isSelected = controller.selectedAnswer.value == label;
    final isAnswered = controller.selectedAnswer.value.isNotEmpty;
    final isCorrect = controller.isCorrectAnswer.value ?? false;

    Color? bgColor;
    if (isSelected && isAnswered) {
      bgColor = isCorrect ? Colors.lightGreen : Colors.redAccent;
    } else {
      bgColor = Colors.white;
    }

    // Ambil gambar URL sesuai label
    String imageUrl = '';
    switch (label) {
      case 'A':
        imageUrl = soal.gambarAUrl;
        break;
      case 'B':
        imageUrl = soal.gambarBUrl;
        break;
      case 'C':
        imageUrl = soal.gambarCUrl;
        break;
      case 'D':
        imageUrl = soal.gambarDUrl;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.yellowAccent, width: 2),
      ),
      width: double.infinity,
      child: InkWell(
        onTap: () {
          if (!isAnswered) {
            controller.jawabSoal(soalId: soal.id, jawaban: label);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(teks, style: const TextStyle(color: Colors.black)),
              const SizedBox(height: 8),
              if (imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
