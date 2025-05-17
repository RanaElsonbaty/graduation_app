import 'package:flutter/material.dart';
import 'package:graduation/features/subjects/presentation/view/subject_view.dart';

class SelectionScreen extends StatefulWidget {
  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String? selectedSemester;
  String? selectedLevel;

  final List<String> semesters = ['first', 'second'];
  final List<String> levels = ['level2', 'level3', 'level4'];

  void navigateToSubjectScreen() {
    if (selectedSemester != null && selectedLevel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SubjectScreen(
            semster: selectedSemester!,
            level: selectedLevel!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both semester and level')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Semester & Level"),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Semester'),
              items: semesters
                  .map((sem) => DropdownMenuItem(value: sem, child: Text(sem)))
                  .toList(),
              onChanged: (value) => setState(() => selectedSemester = value),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Level'),
              items: levels
                  .map((lvl) => DropdownMenuItem(value: lvl, child: Text(lvl)))
                  .toList(),
              onChanged: (value) => setState(() => selectedLevel = value),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: navigateToSubjectScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              child: Text('Show Subjects'),
            ),
          ],
        ),
      ),
    );
  }
}
