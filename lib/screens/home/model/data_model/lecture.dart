import 'student.dart';

class Lecture {
  int? lectureNumber;
  String? dateLecture;
  String? week;
  List<Student>? students;

  Lecture({this.lectureNumber, this.dateLecture, this.week, this.students});

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        lectureNumber: json['lectureNumber'] as int?,
        dateLecture: json['dateLecture'] as String?,
        week: json['week'] as String?,
        students: (json['students'] as List<dynamic>?)
            ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'lectureNumber': lectureNumber,
        'dateLecture': dateLecture,
        'week': week,
        'students': students?.map((e) => e.toJson()).toList(),
      };
}
