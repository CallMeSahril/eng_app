import 'package:eng_app/app/modules/auth/login_view.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
import 'package:eng_app/app/modules/start/start_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    await Future.delayed(Duration(seconds: 2));

    if (userId == null) {
      
      Get.offAll(() => StartView());
    } else {
      Get.offAll(() => DashboardView());
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();

    return Scaffold(
      backgroundColor: Color(0xffF9F1B5),
      body: Center(
        child: Image.asset(
          "assets/img/logo.png",
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
