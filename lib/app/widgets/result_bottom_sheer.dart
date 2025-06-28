import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultBottomSheet extends StatelessWidget {
  final bool isCorrect;
  const ResultBottomSheet({super.key, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/img/cat_${isCorrect ? "success" : "fail"}.png',
            height: 60,
          ),
          const SizedBox(height: 12),
          Text(
            isCorrect ? "JAWABAN BENAR" : "JAWABAN SALAH",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Lanjutkan",
              style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
