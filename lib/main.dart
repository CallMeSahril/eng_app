import 'package:dio/dio.dart';
import 'package:eng_app/app/modules/audio/audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eng_app/app/modules/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mulai musik latar global
  final dio = Dio();
  try {
    final response = await dio.get(
      'https://gg0l3mpr-5006.asse.devtunnels.ms/api/musik/',
    );
    if (response.statusCode == 200 && response.data.isNotEmpty) {
      final firstMusic = response.data[0]['nama']; // Gunakan musik pertama
      print("musik ${firstMusic}");
      await AudioController.playLoop(
        'img/$firstMusic',
      ); // Asumsikan musik di folder lokal img/
    } else {
      await AudioController.playLoop('img/musik.mp3'); // Default fallback
    }
  } catch (e) {
    print("[ERROR] Gagal ambil musik: $e");
    await AudioController.playLoop(
      'img/musik.mp3',
    ); // Default fallback jika gagal
  }

  runApp(GetMaterialApp(title: "Application", home: SplashView()));
}
