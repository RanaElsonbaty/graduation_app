class Subject {
  final String id;
  final String courseName;
  final String courseCode;
  final String semster;
  final String level;
  final List<String> doctorId;

  Subject({
    required this.id,
    required this.courseName,
    required this.courseCode,
    required this.semster,
    required this.level,
    required this.doctorId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'] ?? '',
      courseName: json['courseName'] ?? '',
      courseCode: json['courseCode'] ?? '',
      semster: json['semster'] ?? '',
      level: json['level'] ?? '',
      doctorId: (json['doctorId'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }
}
