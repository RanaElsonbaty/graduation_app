import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/features/sections/data/model/section_model.dart';
import 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  SectionCubit() : super(SectionInitial());

  static SectionCubit get(context) => BlocProvider.of(context);

  final Dio dio = Dio();

  Future<void> getSections(String subjectId) async {
    emit(SectionLoading());
    try {
      final token = GlobalStorage.token;

      final response = await dio.get('https://graduation-project-lilac-five.vercel.app/users/getAllSections\\$subjectId',
          options: Options(
            headers: {
              'Authorization': token,
            },));

      if (response.statusCode == 200) {
        final sectionModel = SectionModel.fromJson(response.data);
        if (sectionModel.lectures.isEmpty) {
          emit(SectionEmpty());
        } else {
          emit(SectionSuccess(sectionModel));
        }
      } else {
        emit(SectionError('Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SectionError(e.toString()));
    }
  }
}
