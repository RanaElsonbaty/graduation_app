import 'dart:convert';
import 'package:graduation/core/helper_functions/api_constants.dart';
import 'package:graduation/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> appInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> cacheData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  static Future<bool> saveUser(UserModel user) async {
    return await sharedPreferences.setString(ApiConstants.USER, jsonEncode(user.toJson()));
  }

  static UserModel? getUser() {
    String? userData = sharedPreferences.getString(ApiConstants.USER);
    if (userData != null && userData.isNotEmpty) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(userData);
        if (jsonData.containsKey('user')) {  // Ensure 'user' key exists
          return UserModel.fromJson(jsonData);
        } else {
          print(" Cached user data is missing 'user' key");
        }
      } catch (e) {
        print(" Error decoding user data: $e");
      }
    }
    return null;
  }


  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

 static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
