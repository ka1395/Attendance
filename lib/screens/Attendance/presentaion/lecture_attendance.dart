import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:attendance/core/resources/routs.dart';
import 'package:attendance/screens/Attendance/presentaion/widgets/custom_presencet_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/model/data_model/student.dart';
import 'widgets/custom_student_card.dart';

class LectureAttendance extends StatefulWidget {
  const LectureAttendance({
    super.key,
  });

  @override
  State<LectureAttendance> createState() => _LectureAttendanceState();
}

class _LectureAttendanceState extends State<LectureAttendance> {
  late List<Student> students;
  List absence = [];
  List presence = [];
  @override
  initState() {
    super.initState();

    students = AppCubit.get(context).lectureData!.students!;
    if (students.isNotEmpty) {
      absence = students
          .where(
            (element) => element.isAttend == false,
          )
          .toList();
      presence = students
          .where(
            (element) => element.isAttend == true,
          )
          .toList();
    }
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouts.searchScreen);
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      body: students.isEmpty
          ? const Center(
              child: CircleAvatar(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: IntrinsicHeight(
                            child: CustomPresencetDetails(
                                title: "الحضور",
                                number: presence.length.toString()),
                          ),
                        ),
                        Expanded(
                          child: IntrinsicHeight(
                            child: CustomPresencetDetails(
                                title: "الغياب",
                                number: absence.length.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return CustomStudenctCard(
                          name: students[index].name!,
                          status: students[index].isAttend ?? false,
                          imagePath: students[index].image ?? '',
                          date: students[index].checkInTime!,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

// class StudentData {
//   final String name;
//   final String status;

//   StudentData({required this.name, required this.status});
// }
