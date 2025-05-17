import 'package:graduation/features/subjects/data/model/subject_model.dart';

abstract class SubjectState {}

class SubjectInitial extends SubjectState {}

class SubjectLoading extends SubjectState {}

class SubjectLoaded extends SubjectState {
  final List<Subject> subjects;
  SubjectLoaded(this.subjects);
}

class SubjectEmpty extends SubjectState {}

class SubjectError extends SubjectState {
  final String message;
  SubjectError(this.message);
}

/// حالة تفيد أن المستخدم غير مسجل دخول أو التوكن منتهي
class SubjectUnauthorized extends SubjectState {}
