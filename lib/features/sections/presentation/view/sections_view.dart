import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/sections/presentation/view_model/cubit/section_cubit.dart';
import 'package:graduation/features/sections/presentation/view_model/cubit/section_state.dart';
import 'package:graduation/features/stream/presentation/view/stream_view.dart';

class SectionScreen extends StatelessWidget {
  final String subjectId;

  const SectionScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SectionCubit()..getSections(subjectId),
      child: Scaffold(
        body: BlocBuilder<SectionCubit, SectionState>(
          builder: (context, state) {
            if (state is SectionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SectionError) {
              return Center(child: Text(state.message));
            } else if (state is SectionEmpty) {
              return const Center(child: Text("No sections available"));
            } else if (state is SectionSuccess) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.sectionModel.lectures.length,
                itemBuilder: (context, index) {
                  final lecture = state.sectionModel.lectures[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StreamScreen(fileId: lecture.id),
                        ),
                      );
                    },
                    child: Card(
                      color: AppColors.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(lecture.fileName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Section Number: ${lecture.numOfLec}'),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox(); // Initial state
          },
        ),
      ),
    );
  }
}
