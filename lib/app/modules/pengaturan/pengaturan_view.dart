import 'package:eng_app/app/modules/audio/audio_controller.dart';
import 'package:eng_app/app/modules/auth/auth_controller.dart';
import 'package:eng_app/app/modules/pengaturan/masukan_view.dart';
import 'package:eng_app/app/modules/pengaturan/profil_pencapaian_view.dart';
import 'package:eng_app/app/modules/pengaturan/pusat_bantuan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanView extends StatefulWidget {
  const PengaturanView({super.key});

  @override
  State<PengaturanView> createState() => _PengaturanViewState();
}

class _PengaturanViewState extends State<PengaturanView> {
  final authController = Get.put(AuthController());
  List musikList = [];
  String? selectedMusik;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    fetchMusik();
    loadSelectedMusik();
  }

  Future<void> loadMuteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isMuted = prefs.getBool('isMuted') ?? false;
    });
  }

  Future<void> saveMuteStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMuted', value);
    setState(() {
      isMuted = value;
    });

    if (value) {
      await AudioController.pause(); // kamu harus punya method pause()
    } else {
      await AudioController.resume(); // kamu harus punya method resume()
    }
  }

  Future<void> fetchMusik() async {
    final response = await Dio().get(
      'https://nngwj5fn-5006.asse.devtunnels.ms/api/musik',
    );
    setState(() {
      musikList = response.data;
    });
  }

  Future<void> loadSelectedMusik() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedMusik = prefs.getString('musik') ?? 'img/musik.mp3'; // default
    });
  }

  Future<void> saveSelectedMusik(String musik) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('musik', musik);
    setState(() {
      selectedMusik = musik;
    });
    await AudioController.playLoop(musik); // Ganti musik yang diputar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      body: ListView(
        children: [
          _sectionTitle("Pengaturan"),
          ListTile(
            title: const Text("Matikan Musik"),
            trailing: Switch(
              value: isMuted,
              onChanged: (value) => saveMuteStatus(value),
              activeColor: Colors.redAccent,
            ),
          ),
          ListTile(
            title: const Text("Musik Latar"),
            subtitle:
                musikList.isEmpty
                    ? const Text("Memuat...")
                    : DropdownButton<String>(
                      isExpanded: true,
                      value: selectedMusik,
                      items:
                          musikList.map<DropdownMenuItem<String>>((musik) {
                            return DropdownMenuItem<String>(
                              value: 'img/${musik['nama']}',
                              child: Text(musik['nama']),
                            );
                          }).toList(),
                      onChanged: (value) {
                        if (value != null) saveSelectedMusik(value);
                      },
                    ),
          ),
          ListTile(
            title: const Text("Profil dan Pencapain "),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: () => Get.to(ProfilPencapaianView()),
          ),
          // ListTile(
          //   title: const Text("Ubah Password "),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.black54,
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            title: const Text("Keluar Akun"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: () {
              authController.logout();
              Get.snackbar(
                'Berhasil',
                'Anda telah keluar dari akun',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          // ListTile(
          //   title: const Text("Hapus Akun "),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.black54,
          //   ),
          //   onTap: () {},
          // ),

          // _sectionTitle("Preference"),
          // ListTile(
          //   title: const Text("Bahasa "),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.black54,
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   title: const Text("Pengaturan suara "),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.black54,
          //   ),
          //   onTap: () {},
          // ),
          GestureDetector(
            child: _sectionTitle("Pusat bantuan"),
            onTap: () => Get.to(const PusatBantuanView()),
          ),
          GestureDetector(
            child: _sectionTitle("Masukan"),
            onTap: () => Get.to(const MasukanView()),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff9E7425),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontFamily: 'Arial',
        ),
      ),
    );
  }
}
