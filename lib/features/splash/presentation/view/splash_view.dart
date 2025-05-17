import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/helper_functions/extension.dart';
import 'package:graduation/core/routing/routes.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:shimmer/shimmer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            (){
          context.pushReplacementNamed(Routes.login);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: FadeIn(
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: AppColors.primary,
            highlightColor: AppColors.secondary,
            child: Image.asset("assets/images/logo.png",
              height: 200.h,
              width: 150.w,
              color: AppColors.primary,
              fit: BoxFit.contain,),
          ),),
      ),
    );
  }
}