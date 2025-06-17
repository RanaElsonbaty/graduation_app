import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/lectures/presentation/view_model/cubit/lecture_cubit.dart';
import 'package:graduation/features/stream/presentation/view/stream_view.dart';

class LectureScreen extends StatelessWidget {
  final String subjectId;
  const LectureScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LectureCubit()..getLectures(subjectId),
      child: Scaffold(
        body: BlocBuilder<LectureCubit, LectureState>(
          builder: (context, state) {
            if (state is LectureLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LectureSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StreamScreen(fileId: state.lectureModel.id),
                      ),
                    );

                  },
                  child: Card(
                    color: AppColors.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(state.lectureModel.courseTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Lecture Number: ${state.lectureModel.numOfLec}'),
                    ),
                  ),
                ),
              );
            } else if (state is LectureEmpty) {
              return Center(child: Text('No lectures found.'));
            } else if (state is LectureError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
