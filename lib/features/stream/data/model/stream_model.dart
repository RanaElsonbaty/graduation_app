class StreamModel {
  final String message;
  final FileData? file;
  final String? videoStream;

  StreamModel({required this.message, this.file, this.videoStream});

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      message: json['message'],
      file: json['file'] != null ? FileData.fromJson(json['file']) : null,
      videoStream: json['videoStream'],
    );
  }
}

class FileData {
  final String id;
  final String courseTitle;
  final String courseId;
  final String videoType;
  final int numOfLec;
  final String fileName;
  final String videoUrl;
  final String videoId;
  final String createdAt;
  final String pdfUrl;

  FileData({
    required this.id,
    required this.courseTitle,
    required this.courseId,
    required this.videoType,
    required this.numOfLec,
    required this.fileName,
    required this.videoUrl,
    required this.videoId,
    required this.createdAt,
    required this.pdfUrl,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      id: json['_id'],
      courseTitle: json['courseTitle'],
      courseId: json['courseId'],
      videoType: json['videoType'],
      numOfLec: json['numOfLec'],
      fileName: json['fileName'],
      videoUrl: json['videoUrl'],
      videoId: json['videoId'],
      createdAt: json['createdAt'],
      pdfUrl: json['file']['secure_url'],
    );
  }
}
