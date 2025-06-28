import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
import 'package:eng_app/app/modules/home/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class QuizView extends StatelessWidget {
//   final int userId;
//   final int levelId;
//   final int tileId;

//   const QuizView({
//     super.key,
//     required this.userId,
//     required this.levelId,
//     required this.tileId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(
//       QuizController(userId: userId, levelId: levelId, tileId: tileId),
//     );

//     if (tileId == 16 || tileId == 32 || tileId == 48 || tileId == 64) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.loadSoal(1);
//       });
//       return Scaffold(
//         appBar: AppBar(title: const Text('Quiz')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
//               const SizedBox(height: 16),
//               const Text(
//                 "Selamat! Anda telah mendapatkan pencapaian!",
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.offAll(DashboardView()); // atau arahkan ke halaman lain
//                 },
//                 child: const Text('Kembali'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.loadSoal(1);
//     });

//     return Scaffold(
//       appBar: AppBar(title: const Text('Quiz')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.errorMessage.isNotEmpty) {
//           return Center(child: Text(controller.errorMessage.value));
//         }

//         final soal = controller.currentSoal;
//         if (soal == null) {
//           return const Center(child: Text('Soal tidak tersedia'));
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (soal.gambarUrl.isNotEmpty)
//                 Center(child: Image.network(soal.gambarUrl, height: 150)),

//               const SizedBox(height: 12),
//               Text(
//                 'Soal ${controller.currentPage} / ${controller.totalSoal}',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(soal.pertanyaan, style: const TextStyle(fontSize: 18)),
//               const SizedBox(height: 20),

//               _buildPilihan(
//                 'A',
//                 soal.pilihanA,
//                 soal.gambarAUrl,
//                 controller: controller,
//               ),
//               _buildPilihan(
//                 'B',
//                 soal.pilihanB,
//                 soal.gambarBUrl,
//                 controller: controller,
//               ),
//               _buildPilihan(
//                 'C',
//                 soal.pilihanC,
//                 soal.gambarCUrl,
//                 controller: controller,
//               ),
//               _buildPilihan(
//                 'D',
//                 soal.pilihanD,
//                 soal.gambarDUrl,
//                 controller: controller,
//               ),

//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Lives: ${controller.lives}'),
//                   Text('Status: ${controller.status}'),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   // Widget _buildPilihan(
//   //   String label,
//   //   String teks,
//   //   String gambarUrl, {
//   //   required QuizController controller,
//   // }) {
//   //   return Card(
//   //     child: ListTile(
//   //       leading: CircleAvatar(child: Text(label)),
//   //       title: Text(teks),
//   //       subtitle:
//   //           gambarUrl.isNotEmpty
//   //               ? Padding(
//   //                 padding: const EdgeInsets.only(top: 8.0),
//   //                 child: Image.network(gambarUrl, height: 80),
//   //               )
//   //               : null,
//   //       onTap: () {
//   //         controller.jawabSoal(label);
//   //       },
//   //     ),
//   //   );
//   // }
//   Widget _buildPilihan(
//     String label,
//     String teks,
//     String gambarUrl, {
//     required QuizController controller,
//   }) {
//     final selected = controller.selectedAnswer.value == label;
//     final isCorrect = controller.isCorrectAnswer.value ?? false;
//     final isAnswering = controller.selectedAnswer.isNotEmpty;

//     Color? tileColor;
//     if (selected && isAnswering) {
//       tileColor = isCorrect ? Colors.lightGreen : Colors.redAccent;
//     } else if (selected) {
//       tileColor = Colors.grey.shade300;
//     }

//     return Obx(
//       () => Card(
//         color: tileColor,
//         child: ListTile(
//           leading: CircleAvatar(child: Text(label)),
//           title: Text(teks),
//           subtitle:
//               gambarUrl.isNotEmpty
//                   ? Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Image.network(gambarUrl, height: 80),
//                   )
//                   : null,
//           onTap: () {
//             if (controller.selectedAnswer.isEmpty) {
//               controller.jawabSoal(label);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class QuizPage extends StatelessWidget {
  final int levelId;
  final int tileId;

  QuizPage({
    super.key,
    required this.levelId,
    required this.tileId,
  });

  final List<String> pilihan = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      QuizController( levelId: levelId, tileId: tileId),
    );

    if (tileId == 16 || tileId == 32 || tileId == 48 || tileId == 64) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadSoal(1);
      });
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
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
      backgroundColor: const Color(0xFFFFF3B0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final soal = controller.currentSoal;
            if (soal == null) {
              return const Center(child: Text('Soal tidak tersedia'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.brown),
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
                    child: Image.network(soal.gambarUrl, fit: BoxFit.cover),
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
                      _buildPilihan('A', soal.pilihanA, controller),
                      _buildPilihan('B', soal.pilihanB, controller),
                      _buildPilihan('C', soal.pilihanC, controller),
                      _buildPilihan('D', soal.pilihanD, controller),
                      const SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     CircleAvatar(
                      //       backgroundColor: Colors.yellow,
                      //       child: Icon(Icons.arrow_back, color: Colors.brown),
                      //     ),
                      //     SizedBox(width: 24),
                      //     CircleAvatar(
                      //       backgroundColor: Colors.yellow,
                      //       child: Icon(
                      //         Icons.arrow_forward,
                      //         color: Colors.brown,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 12),
                      // Text(
                      //   '${controller.currentPage + 1}',
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPilihan(String label, String teks, QuizController controller) {
    final isSelected = controller.selectedAnswer.value == label;
    final isAnswered = controller.selectedAnswer.value.isNotEmpty;
    final isCorrect = controller.isCorrectAnswer.value ?? false;

    Color? bgColor;
    if (isSelected && isAnswered) {
      bgColor = isCorrect ? Colors.lightGreen : Colors.redAccent;
    } else {
      bgColor = Colors.white;
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
          if (!isAnswered) controller.jawabSoal(label);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            '$label. $teks',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
