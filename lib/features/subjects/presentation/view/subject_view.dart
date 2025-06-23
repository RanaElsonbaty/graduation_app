import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/auth/register/presentation/view/register_view.dart';
import 'package:graduation/features/stream/presentation/view/main%20option_materail.dart';
import 'package:graduation/features/subjects/presentation/view_model/cubit/subject_cubit.dart';
import 'package:graduation/features/subjects/presentation/view_model/cubit/subject_state.dart';

class SubjectScreen extends StatelessWidget {
  final String semster;
  final String level;

  const SubjectScreen({required this.semster, required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectCubit()..fetchSubjects(semster: semster, level: level),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subjects'),
          backgroundColor: AppColors.primary,
        ),
        body: BlocConsumer<SubjectCubit, SubjectState>(
          listener: (context, state) {
            if (state is SubjectUnauthorized) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Session expired, please login again.'),
                  backgroundColor: Colors.red.shade700,
                ),
              );

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupView()));
            }
          },
          builder: (context, state) {
            if (state is SubjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SubjectError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<SubjectCubit>().fetchSubjects(
                            semster: semster,
                            level: level,
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SubjectEmpty) {
              return const Center(
                child: Text(
                  'No subjects available.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            } else if (state is SubjectLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: state.subjects.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final subject = state.subjects[index];
                  return Card(
                    elevation: 2,
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.book, color:AppColors.primary),
                      title: Text(
                        subject.courseName,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OptionsMaterial (subjectId: subject.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
