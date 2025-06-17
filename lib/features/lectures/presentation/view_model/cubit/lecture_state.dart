part of 'lecture_cubit.dart';

abstract class LectureState {}

class LectureInitial extends LectureState {}

class LectureLoading extends LectureState {}

class LectureSuccess extends LectureState {
  final LectureModel lectureModel;
  LectureSuccess(this.lectureModel);
}

class LectureEmpty extends LectureState {}

class LectureError extends LectureState {
  final String message;
  LectureError(this.message);
}
