import 'package:eng_app/app/modules/soal/soal_controller.dart';
import 'package:eng_app/app/widgets/custom_button_mulai.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SoalView extends StatelessWidget {
  final SoalController c = Get.put(SoalController());

  final List<String> options = [
    "Kampung Jawa",
    "Kampung Arab",
    "Kampung Cina",
    "Kampung India",
  ];
  final int correctAnswerIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Q4/4", style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.favorite, color: Colors.red),
                ],
              ),
            ),

            // Soal
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Kota tua Jakarta memiliki beberapa kawasan pecinan, sebutkan salah satunya?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            // Gambar
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const SizedBox(height: 24),

            // Jawaban
            Obx(
              () => Column(
                children: List.generate(options.length, (index) {
                  bool selected = c.selectedIndex.value == index;
                  bool correct = index == correctAnswerIndex;
                  Color bgColor = const Color(
                    0xff9D682B,
                  ); // default button color
                  Color borderColor = bgColor;

                  if (c.isAnswered.value) {
                    if (selected && correct) {
                      bgColor = Colors.green;
                      borderColor = Colors.green.shade700;
                    } else if (selected && !correct) {
                      bgColor = Colors.red;
                      borderColor = Colors.red.shade700;
                    }
                  }

                  return GestureDetector(
                    onTap:
                        c.isAnswered.value
                            ? null
                            : () => c.selectAnswer(
                              index,
                              index == correctAnswerIndex,
                            ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 2, color: borderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            options[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          if (selected && c.isAnswered.value)
                            Icon(
                              correct ? Icons.check : Icons.close,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            // Navigasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
