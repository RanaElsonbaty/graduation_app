import 'package:flutter/material.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/lectures/presentation/view/lecures_view.dart';
import 'package:graduation/features/sections/presentation/view/sections_view.dart';

class OptionsMaterial extends StatelessWidget {
  const OptionsMaterial({super.key, required this.subjectId});
  final String subjectId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Materials'),
          backgroundColor: AppColors.primary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Lectures'),
              Tab(text: 'Sections'),
            ],
            labelColor: Colors.white,
            indicatorColor: Colors.white,
          ),
        ),
        body:  TabBarView(
          children: [
            LectureScreen(subjectId: subjectId),
            SectionScreen(subjectId: subjectId),
          ],
        ),
      ),
    );
  }
}

