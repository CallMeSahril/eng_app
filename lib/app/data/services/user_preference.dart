import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
