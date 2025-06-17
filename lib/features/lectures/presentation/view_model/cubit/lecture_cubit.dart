import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/features/lectures/data/model/lecture_model.dart';
part 'lecture_state.dart';

class LectureCubit extends Cubit<LectureState> {
  LectureCubit() : super(LectureInitial());

  Future<void> getLectures(String subjectId) async {
    emit(LectureLoading());
    try {
      final token = GlobalStorage.token;
      final response = await Dio().get(
          'https://graduation-project-lilac-five.vercel.app/users/getAllSubjects/$subjectId',
        options: Options(
      headers: {
      'Authorization': token,
      },
        validateStatus: (status) => status != null && status < 500,
      ),);

      if (response.statusCode == 200 && response.data['lectures'].isNotEmpty) {
        final model = LectureModel.fromJson(response.data);
        emit(LectureSuccess(model));
      } else {
        emit(LectureEmpty());
      }
    } catch (e) {
      emit(LectureError(e.toString()));
    }
  }
}
