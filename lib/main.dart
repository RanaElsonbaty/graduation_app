import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:graduation/core/helper_functions/global_storage.dart';
import 'package:graduation/core/helper_functions/shared_preferences.dart';
import 'package:graduation/core/routing/app_routing.dart';
import 'package:graduation/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:graduation/features/auth/register/presentation/view_model/register_cubit.dart';
import 'package:graduation/features/lectures/presentation/view_model/cubit/lecture_cubit.dart';
import 'package:graduation/features/stream/presentation/view_model/cubit/stream_cubit.dart';
import 'package:graduation/features/subjects/presentation/view_model/cubit/subject_cubit.dart';
import 'package:graduation/graduation_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.appInitialization();
  await GlobalStorage.loadData();

  runApp(
      MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>SignupCubit()),
        BlocProvider(create: (context)=>SubjectCubit()),
        BlocProvider(create: (context)=>LectureCubit()),
        BlocProvider(create: (context)=>StreamCubit()),
      ],
      child: GraduationApp(appRoutes: AppRoutes(),)));
}