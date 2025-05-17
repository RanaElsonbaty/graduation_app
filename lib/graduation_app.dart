import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_routing.dart';
import 'core/routing/routes.dart';

class GraduationApp extends StatelessWidget {
  final AppRoutes appRoutes;
  const GraduationApp({super.key, required this.appRoutes});
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        navigatorKey: navKey,
        title: "GraduationApp",
        onGenerateRoute: appRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
      ),
    );
  }
}