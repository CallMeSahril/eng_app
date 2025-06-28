import 'package:eng_app/app/modules/bab_materi/materi_controller.dart';
import 'package:eng_app/app/modules/bab_materi/pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BabMateriView extends StatelessWidget {
  final MateriController controller = Get.find<MateriController>();

  BabMateriView({super.key});

  // Warna-warna sesuai dengan gambar yang kamu upload (urutan 5 warna)
  final List<Color> colorList = [
    Color(0xFF9E7425), // Kuning emas - sudah tuntas dibaca
    Color(0xFFC5A66C), // Cokelat - belum tuntas dibaca
    Color(0xFFD3D3D3), // Abu terang - belum dibaca sama sekali
    Color(0xFFCFCFCF), // Abu 2
    Color(0xFFCCCCCC), // Abu 3
  ];

  final List<Color> textColorList = [
    Colors.black, // teks warna gelap untuk warna terang
    Colors.white,
    Colors.black,
    Colors.black,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.materiList.length,
          itemBuilder: (context, index) {
            final materi = controller.materiList[index];

            // Warna berdasarkan index (berulang setiap 5 item)
            final color = colorList[index % colorList.length];
            final textColor = textColorList[index % textColorList.length];

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => PDFViewerPage(url: materi.pdfUrl, title: materi.judul),
                );
              },
              child: Container(
                height: 70,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "${materi.bab} - ${materi.judul}",
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
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
