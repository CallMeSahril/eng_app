// import 'package:eng_app/app/data/models/quiz_response_model.dart';
// import 'package:eng_app/app/data/models/soal_model.dart';
// import 'package:eng_app/app/data/services/quiz_answer_service.dart';
// import 'package:eng_app/app/data/services/quiz_service.dart';
// import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class QuizController extends GetxController {
//   final QuizService _quizService = QuizService();
//   final QuizAnswerService _answerService = QuizAnswerService();

//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var quizResponse = Rxn<QuizResponse>();
//   var selectedAnswer = ''.obs;
//   var isCorrectAnswer = RxnBool();
//   final int userId;
//   final int levelId;
//   final int tileId;

//   QuizController({
//     required this.userId,
//     required this.levelId,
//     required this.tileId,
//   });

//   Future<void> loadSoal(int page) async {
//     print('Loading soal for tileId: $tileId, page: $page');
//     try {
//       isLoading.value = true;
//       selectedAnswer.value = '';
//       isCorrectAnswer.value = null;

//       final response = await _quizService.fetchQuiz(
//         levelId: tileId,
//         page: page,
//       );

//       quizResponse.value = response;
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Future<void> jawabSoal(String jawaban) async {
//   //   final soal = quizResponse.value?.soal;
//   //   if (soal == null) return;

//   //   try {
//   //     final response = await _answerService.kirimJawaban(
//   //       tileId: tileId,
//   //       soalId: soal.id,
//   //       jawaban: jawaban,
//   //     );

//   //     final correct = response['correct'] == true;
//   //     final remaining = response['remaining_lives'];

//   //     final message = correct ? 'Jawaban benar!' : 'Jawaban salah.';
//   //     final color = correct ? Colors.green : Colors.red;

//   //     Get.snackbar(
//   //       'Hasil Jawaban',
//   //       '$message Sisa nyawa: $remaining',
//   //       backgroundColor: color,
//   //       colorText: Colors.white,
//   //     );

//   //     // Reload soal berikutnya jika masih tersedia
//   //     if (currentPage < totalSoal) {
//   //       loadSoal(currentPage + 1);
//   //     } else {
//   //       Get.snackbar('Selesai', 'Semua soal telah dijawab');
//   //       Get.offAll(DashboardView()); // Kembali ke dashboard
//   //     }
//   //   } catch (e) {
//   //     Get.snackbar('Gagal', e.toString());
//   //   }
//   // }
//   Future<void> jawabSoal(String jawaban) async {
//     final soal = quizResponse.value?.soal;
//     if (soal == null) return;

//     try {
//       final response = await _answerService.kirimJawaban(
//         tileId: tileId,
//         soalId: soal.id,
//         jawaban: jawaban,
//       );

//       selectedAnswer.value = jawaban;
//       isCorrectAnswer.value = response['correct'] == true;

//       await Future.delayed(
//         const Duration(milliseconds: 600),
//       ); // kasih waktu animasi
//       _showFeedbackDialog(jawaban, isCorrectAnswer.value!);
//     } catch (e) {
//       Get.snackbar('Gagal', e.toString());
//     }
//   }

//   Soal? get currentSoal => quizResponse.value?.soal;
//   int get currentPage => quizResponse.value?.page ?? 0;
//   int get totalSoal => quizResponse.value?.totalSoal ?? 0;
//   int get lives => quizResponse.value?.lives ?? 0;
//   String get status => quizResponse.value?.status ?? '';
//   void _showFeedbackDialog(String jawaban, bool isCorrect) {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: Colors.white,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               isCorrect
//                   ? 'assets/images/bear_happy.png'
//                   : 'assets/images/bear_sad.png',
//               height: 80,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               isCorrect ? 'JAWABAN BENAR' : 'JAWABAN SALAH',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: isCorrect ? Colors.green : Colors.red,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text('Jawaban Anda: $jawaban'),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isCorrect ? Colors.lightGreen : Colors.orange,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Get.back(); // tutup dialog
//                 if (currentPage < totalSoal) {
//                   loadSoal(currentPage + 1);
//                 } else {
//                   Get.offAll(DashboardView());
//                 }
//               },
//               child: const Text('Lanjutkan'),
//             ),
//           ],
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eng_app/app/data/models/quiz_response_model.dart';
import 'package:eng_app/app/data/models/soal_model.dart';
import 'package:eng_app/app/data/services/quiz_answer_service.dart';
import 'package:eng_app/app/data/services/quiz_service.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';

class QuizController extends GetxController {
  final QuizService _quizService = QuizService();
  final QuizAnswerService _answerService = QuizAnswerService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var quizResponse = Rxn<QuizResponse>();
  var selectedAnswer = ''.obs;
  var isCorrectAnswer = RxnBool();

  final int levelId;
  final int tileId;

  QuizController({
    required this.levelId,
    required this.tileId,
  });

  Future<void> loadSoal(int page) async {
    print('Loading soal for tileId: $tileId, page: $page');
    try {
      isLoading.value = true;
      selectedAnswer.value = '';
      isCorrectAnswer.value = null;

      final response = await _quizService.fetchQuiz(
        levelId: tileId,
        page: page,
      );

      quizResponse.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> jawabSoal(String jawaban) async {
    final soal = quizResponse.value?.soal;
    if (soal == null) return;

    try {
      final response = await _answerService.kirimJawaban(
        tileId: tileId,
        soalId: soal.id,
        jawaban: jawaban,
      );

      selectedAnswer.value = jawaban;
      isCorrectAnswer.value = response['correct'] == true;

      await Future.delayed(const Duration(milliseconds: 600));
      _showFeedbackDialog(jawaban, isCorrectAnswer.value!);
    } catch (e) {
      Get.snackbar('Gagal', e.toString());
    }
  }

  // void _showFeedbackDialog(String jawaban, bool isCorrect) {
  //   Get.dialog(
  //     AlertDialog(
  //       backgroundColor: Colors.white,
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Image.asset(
  //             isCorrect
  //                 ? 'assets/img/bear_happy.png'
  //                 : 'assets/img/bear_sad.png',
  //             height: 80,
  //           ),
  //           const SizedBox(height: 12),
  //           Text(
  //             isCorrect ? 'JAWABAN BENAR' : 'JAWABAN SALAH',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 16,
  //               color: isCorrect ? Colors.green : Colors.red,
  //             ),
  //           ),
  //           const SizedBox(height: 4),
  //           Text('Jawaban Anda: $jawaban'),
  //           const SizedBox(height: 16),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: isCorrect ? Colors.lightGreen : Colors.orange,
  //               foregroundColor: Colors.black,
  //             ),
  //             onPressed: () {
  //               Get.back();
  //               if (currentPage < totalSoal) {
  //                 loadSoal(currentPage + 1);
  //               } else {
  //                 Get.offAll(DashboardView());
  //               }
  //             },
  //             child: const Text('Lanjutkan'),
  //           ),
  //         ],
  //       ),
  //     ),
  //     barrierDismissible: false,
  //   );
  // }
  void _showFeedbackDialog(String jawaban, bool isCorrect) {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isCorrect
                    ? 'assets/img/bear_happy.png'
                    : 'assets/img/bear_sad.png',
                height: 80,
              ),
              const SizedBox(height: 12),
              Text(
                isCorrect ? 'JAWABAN BENAR' : 'JAWABAN SALAH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Jawaban Anda: $jawaban',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isCorrect ? Colors.lightGreen : Colors.orange,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.back(); // Tutup bottom sheet
                  if (currentPage < totalSoal) {
                    loadSoal(currentPage + 1);
                  } else {
                    Get.offAll(DashboardView());
                  }
                },
                child: const Text('Lanjutkan'),
              ),
            ],
          ),
        );
      },
    );
  }

  Soal? get currentSoal => quizResponse.value?.soal;
  int get currentPage => quizResponse.value?.page ?? 0;
  int get totalSoal => quizResponse.value?.totalSoal ?? 0;
  int get lives => quizResponse.value?.lives ?? 0;
  String get status => quizResponse.value?.status ?? '';
}
