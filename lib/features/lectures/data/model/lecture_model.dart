class LectureModel {
  final String id;
  final int numOfLec;
  final String fileName;
  final String courseTitle;

  LectureModel({
    required this.id,
    required this.numOfLec,
    required this.fileName,
    required this.courseTitle,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    final lecture = json['lectures'].isNotEmpty ? json['lectures'][0] : null;
    return LectureModel(
      id: lecture?['_id'] ?? '',
      numOfLec: lecture?['numOfLec'] ?? 0,
      fileName: lecture?['fileName'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
    );
  }
}
