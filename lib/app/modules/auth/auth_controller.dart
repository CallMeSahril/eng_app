import 'package:eng_app/app/data/models/user_model.dart';
import 'package:eng_app/app/data/services/auth_service.dart';
import 'package:eng_app/app/modules/auth/login_view.dart';
import 'package:eng_app/app/modules/dashboard/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var user = Rxn<UserModel>();

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    if (result != null) {
      user.value = result;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', result.id);
      await prefs.setString('name', result.name);
      await prefs.setString('email', result.email);
      Get.snackbar('Success', 'Login berhasil');
      Get.offAll(DashboardView()); // Ganti dengan route dashboard yang sesuai
    } else {
      Get.snackbar('Error', 'Login gagal');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final result = await _authService.register(name, email, password);
    print('Register result: $result');
    if (result) {
      Get.snackbar('Success', 'Registrasi berhasil');
      Get.offAll(LoginView());
    } else {
      Get.snackbar('Error', 'Registrasi gagal');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user.value = null;
    Get.offAll(() => LoginView());
  }
}
