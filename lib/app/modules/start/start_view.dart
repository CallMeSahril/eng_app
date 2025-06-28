import 'package:eng_app/app/modules/auth/login_view.dart';
import 'package:eng_app/app/widgets/custom_button_mulai.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F1B5),

      body: Center(
        child: Column(
          children: [
            Image.asset("assets/img/start.png", height: 700, fit: BoxFit.cover),
            CustomButtonMulai(
              onPressed: () {
                Get.offAll(LoginView());
                // print("Tombol Mulai ditekan");
                // Tambahkan aksi lain di sini
              },
            ),
          ],
        ),
      ),
    );
  }
}
