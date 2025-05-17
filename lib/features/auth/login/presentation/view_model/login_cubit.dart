import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/api_constants.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/core/helper_functions/shared_preferences.dart';
import 'package:graduation/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio _dio = Dio();
  Future<void> login({required String email, required String password}) async {
    await CacheHelper.removeData(key: ApiConstants.TOKEN);

    emit(LoginLoading());

    final url = 'https://graduation-project-lilac-five.vercel.app/users/login';

    try {
      final response = await _dio.post(
        url,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        final token = response.data['token'];
        print("Saved token: $token");

        await CacheHelper.cacheData(key: ApiConstants.TOKEN, value: token);
        await GlobalStorage.saveUserData(user);
        await CacheHelper.cacheData(key: ApiConstants.USER_PASSWORD, value: password);
        await CacheHelper.cacheData(key: ApiConstants.USER_EMAIL, value: email);

        emit(LoginSuccess(message: response.data['message']));
      } else {
        emit(LoginError(error: response.data['message'] ?? 'Login failed'));
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? 'user not found';

      if (errorMsg.toLowerCase().contains('invalid token') ||
          errorMsg.toLowerCase().contains('expired token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        emit(LoginUnauthorized());
      } else {
        emit(LoginError(error: errorMsg));
      }
    } catch (e) {
      emit(LoginError(error: 'Unexpected error: $e'));
    }
  }

}
