import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PusatBantuanView extends StatelessWidget {
  const PusatBantuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      appBar: AppBar(
        backgroundColor: const Color(0xff9E7425),
        title: const Text(
          "Pusat Bantuan",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _section("Pertanyaan Umum", [
            _faqTile("Bagaimana cara mengganti musik latar?",
                "Buka menu Pengaturan > Musik Latar, lalu pilih musik yang tersedia."),
            _faqTile("Bagaimana cara keluar dari akun?",
                "Buka menu Pengaturan > Keluar Akun."),
            _faqTile("Bagaimana jika saya lupa kata sandi?",
                "Saat ini fitur lupa kata sandi belum tersedia. Harap hubungi admin."),
          ]),
          const SizedBox(height: 16),
          _section("Bantuan Teknis", [
            _faqTile("Aplikasi tidak bisa dibuka", "Coba restart aplikasi atau periksa koneksi internet."),
            _faqTile("Gagal memuat gambar atau musik", "Pastikan koneksi internet stabil, atau hubungi admin."),
          ]),
          const SizedBox(height: 16),
          _section("Kontak Pengembang", [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email Bantuan"),
              subtitle: const Text("support@engapp.com"),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("No. WhatsApp"),
              subtitle: const Text("+62 812-3456-7890"),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xff9E7425),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            answer,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
