import 'subject.dart';

class Data {
  List<Subject>? subjects;

  Data({this.subjects});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subjects: (json['subjects'] as List<dynamic>?)
            ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'subjects': subjects?.map((e) => e.toJson()).toList(),
      };
}
