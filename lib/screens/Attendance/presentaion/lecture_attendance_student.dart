import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/model/data_model/student.dart';
import '../data/model/attendance_model.dart';
import 'widgets/custom_student_card.dart';

class LectureAttendanceStudent extends StatefulWidget {
  const LectureAttendanceStudent({super.key});

  @override
  State<LectureAttendanceStudent> createState() =>
      _LectureAttendanceStudentState();
}

class _LectureAttendanceStudentState extends State<LectureAttendanceStudent> {
  Student? myStudentData;
  @override
  void initState() {
    myStudentData = AppCubit.get(context).myStudentData!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) => Text(
            "lecture ${AppCubit.get(context).lectureData!.lectureNumber}",
          ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomStudenctCard(
                name: myStudentData!.name!,
                status: myStudentData!.isAttend!,
                imagePath: myStudentData!.image!,
                date: myStudentData!.checkInTime!,
              ));
        },
      ),
    );
  }
}

class StudentData {
  final String name;
  final String status;

  StudentData({required this.name, required this.status});
}
