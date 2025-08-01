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
    final response = await Dio().get('http://195.88.211.177:5006/api/musik');
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

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      Get.snackbar("Gagal", "User ID tidak ditemukan di penyimpanan lokal");
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Hapus Akun"),
            content: const Text(
              "Apakah kamu yakin ingin menghapus akun ini secara permanen? Tindakan ini tidak dapat dibatalkan.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Ya, Hapus",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirm != true) return;

    try {
      final response = await Dio().delete(
        "http://195.88.211.177:5006/api/auth/delete/$userId",
      );

      if (response.statusCode == 200) {
        await prefs.clear();
        authController.logout(); // panggil logout
        Get.offAllNamed(
          '/login',
        ); // arahkan ke login page (ubah sesuai routing kamu)
        Get.snackbar(
          "Berhasil",
          "Akun berhasil dihapus secara permanen",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Gagal",
          response.data['message'] ?? "Gagal menghapus akun",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan koneksi saat menghapus akun",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Delete error: $e");
    }
  }

  Future<void> changePassword() async {
    final oldController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Ganti Password"),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password Lama",
                    ),
                    validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
                  ),
                  TextFormField(
                    controller: newController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password Baru",
                    ),
                    validator:
                        (val) => val!.length < 6 ? "Minimal 6 karakter" : null,
                  ),
                  TextFormField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Konfirmasi Password",
                    ),
                    validator:
                        (val) =>
                            val != newController.text ? "Tidak cocok" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("Batal")),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final prefs = await SharedPreferences.getInstance();
                  final userId = prefs.getInt('user_id');
                  if (userId == null) {
                    Get.snackbar("Error", "User tidak ditemukan");
                    return;
                  }

                  try {
                    final response = await Dio().put(
                      "http://195.88.211.177:5006/api/auth/change-password/$userId",
                      data: {
                        "old_password": oldController.text.trim(),
                        "new_password": newController.text.trim(),
                        "confirm_password": confirmController.text.trim(),
                      },
                    );

                    if (response.statusCode == 200) {
                      Get.back();
                      Get.snackbar(
                        "Berhasil",
                        response.data['message'],
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar(
                        "Gagal",
                        response.data['message'] ?? "Gagal mengganti password",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      "Error",
                      "Terjadi kesalahan koneksi",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    print("Change password error: $e");
                  }
                }
              },
              child: const Text("Ganti"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      body: ListView(
        children: [
          _sectionTitle("Akun"),

          ListTile(
            title: const Text("Profil dan Pencapain "),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: () => Get.to(ProfilPencapaianView()),
          ),
          ListTile(
            title: const Text("Ganti Password"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: changePassword,
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
            title: const Text("Hapus Akun"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: deleteAccount,
          ),

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
          _sectionTitle("Preference"),
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
                      value:
                          selectedMusik ??
                          (musikList.isNotEmpty
                              ? 'img/${musikList[0]['nama']}'
                              : null),
                      items:
                          musikList.map<DropdownMenuItem<String>>((musik) {
                            return DropdownMenuItem<String>(
                              value: 'img/${musik['nama']}',
                              child: Text(musik['nama']),
                            );
                          }).toList(),
                      onChanged: null, // Disable editing
                    ),
          ),
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
