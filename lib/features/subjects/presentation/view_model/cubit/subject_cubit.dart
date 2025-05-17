import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/features/subjects/data/model/subject_model.dart';
import 'package:graduation/features/subjects/presentation/view_model/cubit/subject_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(SubjectInitial());

  final Dio _dio = Dio();

  Future<void> fetchSubjects({required String semster, required String level}) async {
    emit(SubjectLoading());

    try {
      print("Fetching subjects with semester=$semster and level=$level");

      await GlobalStorage.loadData(); // لو مش محملة قبل كده
      final token = GlobalStorage.token;

      final response = await _dio.get(
        'https://graduation-project-lilac-five.vercel.app/users/getAllSubjects',
        queryParameters: {
          'semster': semster,
          'level': level,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );


      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final subjectsData = response.data['subjects'];
        if (subjectsData == null) {
          emit(SubjectError('Response does not contain subjects'));
          return;
        }
        if (subjectsData.isEmpty) {
          emit(SubjectEmpty());
        } else {
          final subjects = (subjectsData as List).map((e) => Subject.fromJson(e)).toList();
          emit(SubjectLoaded(subjects));
        }
      } else if (response.statusCode == 401) {
        // 401 Unauthorized غالبا يعني التوكن غير صالح أو منتهي
        await _handleInvalidToken();
      } else {
        print("statusssss code${response.statusCode}");
        final message = response.data['message'] ?? 'Failed to fetch subjects';
        emit(SubjectError(message));
      }
    } on DioException catch (e) {
      print("DioException full: ${e.response?.data}");

      final errorMsg = e.response?.data['msg'] ?? e.response?.data['message'] ?? 'Server error';

      if (errorMsg.toLowerCase().contains('invalid token') ||
          (e.response?.statusCode == 401)) {
        await _handleInvalidToken();
      } else {
        emit(SubjectError(errorMsg));
      }
    } catch (e) {
      print("Unexpected error: $e");
      emit(SubjectError("Failed to load subjects"));
    }
  }

  Future<void> _handleInvalidToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    emit(SubjectUnauthorized());
  }

  /// وظيفة تسجيل الخروج (Logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    emit(SubjectUnauthorized());
  }
}
