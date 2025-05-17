import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/helper_functions/extension.dart';
import 'package:graduation/core/routing/routes.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/core/theming/images.dart';
import 'package:graduation/features/auth/register/presentation/view_model/register_cubit.dart';

class SignupView extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: Scaffold(
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Success: ${state.message}')),
              );
              Future.delayed(const Duration(seconds: 1), () {
                context.pushReplacementNamed(Routes.login);
              });
            } else if (state is SignupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 100.h,bottom: 100.h),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.backgroundAuthImage),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Image.asset(AppImages.logoImage, height: 80, width: 80),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: AppColors.primary),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            cursorColor: AppColors.primary,
                            keyboardType: TextInputType.name,
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Enter Your First Name',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            cursorColor: AppColors.primary,
                            keyboardType: TextInputType.name,
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Enter Your Last Name',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            cursorColor: AppColors.primary,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              // Email validation regex
                              String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regex = RegExp(emailPattern);
                              if (!regex.hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            cursorColor: AppColors.primary,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: true,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          state is SignupLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                final firstName = firstNameController.text;
                                final lastName = lastNameController.text;
                                final email = emailController.text;
                                final password = passwordController.text;
              
                                context.read<SignupCubit>().signup(
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  password: password,
                                );
                              }
                            },
                            child: const Text('Sign up'),
                          ),
                          SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Log In',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushReplacementNamed(Routes.login);
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