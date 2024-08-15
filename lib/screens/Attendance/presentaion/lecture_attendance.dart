import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:attendance/core/resources/routs.dart';
import 'package:attendance/screens/Attendance/presentaion/widgets/custom_presencet_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/custom_student_card.dart';

class LectureAttendance extends StatelessWidget {
  const LectureAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    // List<StudentData> nameStudent = [
    //   StudentData(name: 'Ahmed (أحمد)', status: "حضور"),
    //   StudentData(name: 'Mohammed (محمد)', status: "غياب"),
    //   StudentData(name: 'Ali (علي)', status: "حضور"),
    //   StudentData(name: 'Omar (عمر)', status: "غياب"),
    //   StudentData(name: 'Yusuf (يوسف)', status: "حضور"),
    //   StudentData(name: 'Ibrahim (إبراهيم)', status: "حضور"),
    //   StudentData(name: 'Khalid (خالد)', status: "حضور"),
    //   StudentData(name: 'Hassan (حسن)', status: "غياب"),
    //   StudentData(name: 'Faisal (فيصل)', status: "حضور"),
    //   StudentData(name: 'Abdullah (عبد الله)', status: "غياب"),
    //   StudentData(name: 'Fatima (فاطمة)', status: "غياب"),
    //   StudentData(name: 'Aisha (عائشة)', status: "حضور"),
    //   StudentData(name: 'Zainab (زينب)', status: "حضور"),
    //   StudentData(name: 'Mariam (مريم)', status: "حضور"),
    //   StudentData(name: 'Noor (نور)', status: "حضور"),
    //   StudentData(name: 'Layla (ليلى)', status: "حضور"),
    //   StudentData(name: 'Salma (سلمى)', status: "غياب"),
    // ];
    List absence = [];
    List presence = [];
    if (AppCubit.get(context).attendanceList.isNotEmpty) {
      absence = AppCubit.get(context)
          .attendanceList
          .where(
            (element) => element.attend == "0",
          )
          .toList();
      presence = AppCubit.get(context)
          .attendanceList
          .where(
            (element) => element.attend == "1",
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) => Text(
            AppCubit.get(context).lectureNumber,
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
      body: AppCubit.get(context).attendanceList.isEmpty
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
                      itemCount: AppCubit.get(context).attendanceList.length,
                      itemBuilder: (context, index) {
                        return CustomStudenctCard(
                          name:
                              AppCubit.get(context).attendanceList[index].name!,
                          status: AppCubit.get(context)
                              .attendanceList[index]
                              .attend!,
                          imagePath: AppCubit.get(context)
                              .attendanceList[index]
                              .imgae!,
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

class StudentData {
  final String name;
  final String status;

  StudentData({required this.name, required this.status});
}
