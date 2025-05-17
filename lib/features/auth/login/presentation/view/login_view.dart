import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/helper_functions/extension.dart';
import 'package:graduation/core/routing/routes.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/core/theming/images.dart';
import 'package:graduation/features/auth/login/presentation/view_model/login_cubit.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Success: ${state.message}')),
              );
              Future.delayed(const Duration(seconds: 1), () {
                context.pushReplacementNamed(Routes.selection);
              });
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 100.h, bottom: 200.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backgroundAuthImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logoImage, height: 80, width: 80),
                          Text(
                            "Log In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.primary,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter Your Email',
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              labelStyle: TextStyle(color: AppColors.primary),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppColors.primary,
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              labelStyle: TextStyle(color: AppColors.primary),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          state is LoginLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: const Text('Login'),
                          ),
                          SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushReplacementNamed(Routes.signUp);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
