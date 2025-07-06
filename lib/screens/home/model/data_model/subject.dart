import 'lecture.dart';

class Subject {
  String? subjectName;
  List<Lecture>? lectures;

  Subject({this.subjectName, this.lectures});

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectName: json['subjectName'] as String?,
        lectures: (json['lectures'] as List<dynamic>?)
            ?.map((e) => Lecture.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'subjectName': subjectName,
        'lectures': lectures?.map((e) => e.toJson()).toList(),
      };
}
