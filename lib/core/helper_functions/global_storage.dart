
import 'package:graduation/core/helper_functions/api_constants.dart';
import 'package:graduation/core/helper_functions/shared_preferences.dart';
import 'package:graduation/user/user_model.dart';

class GlobalStorage {
  static String token = "";
  static int userId = 0;
  static String userName = "";
  static String userPassword = "";
  static String userEmail = "";

  static Future<void> loadData() async {
    token = CacheHelper.getData(key: ApiConstants.TOKEN) as String? ?? "";
    userId = CacheHelper.getData(key: ApiConstants.USER_ID) as int? ?? 0;
    userName = CacheHelper.getData(key: ApiConstants.USER_NAME) as String? ?? "";
    userPassword = CacheHelper.getData(key: ApiConstants.USER_PASSWORD) as String? ?? "";
    userEmail = CacheHelper.getData(key: ApiConstants.USER_EMAIL) as String? ?? "";
  }

  static Future<void> saveUserData(UserModel user) async {
    await CacheHelper.cacheData(key: ApiConstants.USER_ID, value: user.id);
    await CacheHelper.cacheData(key: ApiConstants.USER_NAME, value: user.name);
    await CacheHelper.cacheData(key: ApiConstants.TOKEN, value: user.token);
    //loadData(); // Remove this line
  }
  static Future<void> clearData() async {
    await CacheHelper.clearData();
    token = "";
    userId = 0;
    userName = "";
    userPassword = "";
  }
}
