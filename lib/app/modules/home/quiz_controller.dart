import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eng_app/app/data/models/quiz_response_model.dart';
import 'package:eng_app/app/data/models/soal_model.dart';
import 'package:eng_app/app/data/services/quiz_answer_service.dart';
import 'package:eng_app/app/data/services/quiz_service.dart';

class QuizController extends GetxController {
  final QuizService _quizService = QuizService();
  final QuizAnswerService _answerService = QuizAnswerService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var quizResponse = Rxn<QuizResponse>();
  var selectedAnswer = ''.obs;
  var isCorrectAnswer = RxnBool();
  var isSoalPertama = true.obs;

  final int levelId;
  final int tileId;

  QuizController({required this.levelId, required this.tileId});

  Future<void> loadSoal(int page) async {
    print('Loading soal for tileId: $tileId, page: $page');
    try {
      isLoading.value = true;
      selectedAnswer.value = '';
      isCorrectAnswer.value = null;
      isSoalPertama.value = true;

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

  Future<void> jawabSoal({required int soalId, required String jawaban}) async {
    try {
      final response = await _answerService.kirimJawaban(
        tileId: tileId,
        soalId: soalId,
        jawaban: jawaban,
      );

      selectedAnswer.value = jawaban;
      isCorrectAnswer.value = response['correct'] == true;

      // Tampilkan feedback dulu
      await Future.delayed(const Duration(milliseconds: 500));
      _showFeedbackDialog(jawaban, isCorrectAnswer.value!);
    } catch (e) {
      Get.snackbar('Gagal', e.toString());
    }
  }

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
                  Get.back(); // Tutup feedback

                  if (isSoalPertama.value) {
                    // Tampilkan soal ke-2
                    isSoalPertama.value = false;
                    selectedAnswer.value = '';
                    isCorrectAnswer.value = null;
                  } else {
                    // Jika soal ke-2 sudah dijawab, quiz selesai
                    Get.offAll(() => DashboardView());
                  }
                },
                child: Text(
                  isSoalPertama.value ? 'Lanjut ke Soal Berikutnya' : 'Selesai',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // === Getter logic ===

  Soal? get soalUntukDitampilkan {
    final list = quizResponse.value?.soalList ?? [];
    return list.length >= 2
        ? (isSoalPertama.value ? list[0] : list[1])
        : list.isNotEmpty
        ? list[0]
        : null;
  }

  // Soal? get soalUntukDijawab {
  //   final list = quizResponse.value?.soalList ?? [];
  //   return list.length >= 2 ? list[1] : list.isNotEmpty ? list[0] : null;
  // }

  int get currentPage => quizResponse.value?.page ?? 0;
  int get totalSoal => quizResponse.value?.totalSoal ?? 0;
  int get lives => quizResponse.value?.lives ?? 0;
  String get status => quizResponse.value?.status ?? '';
}
