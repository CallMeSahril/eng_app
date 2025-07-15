import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasukanView extends StatefulWidget {
  const MasukanView({super.key});

  @override
  State<MasukanView> createState() => _MasukanViewState();
}

class _MasukanViewState extends State<MasukanView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pesanController = TextEditingController();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Simulasikan pengiriman
      Get.snackbar(
        "Terima Kasih",
        "Masukan Anda telah dikirim",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );

      // Kosongkan form
      namaController.clear();
      emailController.clear();
      pesanController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F1B5),
      appBar: AppBar(
        backgroundColor: const Color(0xff9E7425),
        title: const Text("Masukan", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _label("Nama"),
              _inputField(
                controller: namaController,
                hintText: "Masukkan nama Anda",
              ),
              const SizedBox(height: 12),
              _label("Email"),
              _inputField(
                controller: emailController,
                hintText: "Masukkan email Anda",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              _label("Masukan / Saran"),
              _inputField(
                controller: pesanController,
                hintText: "Tulis masukan Anda di sini...",
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9E7425),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitFeedback,
                child: const Text(
                  "Kirim",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap diisi';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
