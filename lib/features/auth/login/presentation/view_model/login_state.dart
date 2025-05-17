part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess({required this.message});
}

class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}
/// حالة تفيد انتهاء صلاحية التوكن أو عدم التفويض (عادة في أماكن أخرى)
class LoginUnauthorized extends LoginState {}