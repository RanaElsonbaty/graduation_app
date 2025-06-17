class SectionModel {
  final String message;
  final List<Lecture> lectures;
  final String courseTitle;

  SectionModel({required this.message, required this.lectures, required this.courseTitle});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      message: json['message'],
      lectures: (json['lectures'] as List).map((e) => Lecture.fromJson(e)).toList(),
      courseTitle: json['courseTitle'],
    );
  }
}

class Lecture {
  final String id;
  final int numOfLec;
  final String fileName;

  Lecture({required this.id, required this.numOfLec, required this.fileName});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['_id'],
      numOfLec: json['numOfLec'],
      fileName: json['fileName'],
    );
  }
}
