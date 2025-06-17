import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/features/stream/data/model/stream_model.dart';
import 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  StreamCubit() : super(StreamInitial());

  static StreamCubit get(context) => BlocProvider.of(context);

  Future<void> getVideoStream(String fileId) async {
    emit(StreamLoading());
    try {
      final token = GlobalStorage.token;
      final response = await Dio().get(
        'https://graduation-project-lilac-five.vercel.app/users/stream/$fileId',
          options: Options(
        headers: {
          'Authorization': token,
        },
          )
      );

      final data = StreamModel.fromJson(response.data);

      if (data.file == null) {
        emit(StreamEmpty());
      } else {
        emit(StreamSuccess(data));
      }
    } catch (e) {
      emit(StreamError(e.toString()));
    }
  }
}
