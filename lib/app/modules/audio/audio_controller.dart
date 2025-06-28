import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';

class AudioController {
  static final AudioPlayer _player = AudioPlayer();
  static bool isMuted = false;

  static Future<void> playLoop(String path) async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource(path));
    isMuted = false;
  }

  static Future<void> stop() async {
    await _player.stop();
  }

  static Future<void> dispose() async {
    await _player.dispose();
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static Future<void> resume() async {
    await _player.resume();
  }

  static Future<bool> toggle() async {
    print(isMuted);
    if (isMuted) {
      await AudioController.playLoop('img/musik.mp3');
      isMuted = isMuted;
      return isMuted;
    } else {
      await pause();
      isMuted = !isMuted;
      return isMuted;
    }
  }
}

Future<List<String>> fetchMusikNames() async {
  final dio = Dio();
  try {
    final response = await dio.get(
      'https://gg0l3mpr-5006.asse.devtunnels.ms/api/musik/',
    );
    List<dynamic> data = response.data;
    return data.map<String>((item) => item['nama'] as String).toList();
  } catch (e) {
    throw Exception("Gagal ambil data musik: $e");
  }
}
