import 'package:flutter/material.dart';
import 'package:graduation/core/routing/routes.dart';
import 'package:graduation/features/auth/login/presentation/view/login_view.dart';
import 'package:graduation/features/auth/register/presentation/view/register_view.dart';
import 'package:graduation/features/selection/presentation/view/selection_view.dart';
import 'package:graduation/features/splash/presentation/view/splash_view.dart';
import 'package:graduation/features/subjects/presentation/view/subject_view.dart';

class AppRoutes {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) =>  SplashView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) =>  LoginView());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) =>  SignupView());
      case Routes.selection:
        return MaterialPageRoute(builder: (_) =>  SelectionScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}