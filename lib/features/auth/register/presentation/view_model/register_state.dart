part of 'register_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess({required this.message});
}

class SignupError extends SignupState {
  final String error;
  SignupError({required this.error});
}
/// حالة تفيد انتهاء صلاحية التوكن أو عدم التفويض
class SignupUnauthorized extends SignupState {}
