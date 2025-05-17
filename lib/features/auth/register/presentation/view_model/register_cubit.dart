import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/api_constants.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/core/helper_functions/shared_preferences.dart';
import 'package:graduation/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final Dio _dio = Dio();

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    final url = 'https://graduation-project-lilac-five.vercel.app/users/signup';

    try {
      final response = await _dio.post(
        url,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel user = UserModel.fromJson(response.data);
        await GlobalStorage.saveUserData(user);
        await CacheHelper.cacheData(key: ApiConstants.USER_PASSWORD, value: password);
        await CacheHelper.cacheData(key: ApiConstants.USER_EMAIL, value: email);
        final message = response.data['message'] ?? 'Signup succeeded';
        emit(SignupSuccess(message: message));
      } else {
        final errorMsg = response.data['message'] ?? 'Signup failed';
        emit(SignupError(error: errorMsg));
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Signup error';

      if (msg.toLowerCase().contains('invalid token') ||
          msg.toLowerCase().contains('expired token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        emit(SignupUnauthorized());
      } else {
        emit(SignupError(error: msg));
      }
    } catch (e) {
      emit(SignupError(error: 'Unexpected error: ${e.toString()}'));
    }
  }
}
