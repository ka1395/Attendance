import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/routs.dart';
import '../home/model/data_model/subject.dart';

class LecturesScreen extends StatefulWidget {
  const LecturesScreen({
    super.key,
  });

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  late Subject subjectLectures;
  @override
  void initState() {
    subjectLectures = AppCubit.get(context).subjectData!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            subjectLectures.subjectName!,
          ),
          centerTitle: true,
        ),
        body: state is GetExcelSheetLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : AnimationLimiter(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: subjectLectures.lectures!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var lecture = subjectLectures.lectures![index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: CustomLectures(
                        className: "Lecture ${lecture.lectureNumber}",
                        onTap: () async {
                          if (lecture.students!.isNotEmpty) {
                            if (AppCubit.get(context).userData!.isStudent ==
                                "1") {
                              String id = AppCubit.get(context).userData!.id!;

                              AppCubit.get(context).myStudentData =
                                  lecture.students!.firstWhere(
                                (element) => element.id == id,
                              );

                              Navigator.pushNamed(
                                  context, AppRouts.attendanceScreenStudent);
                            } else {
                              Navigator.pushNamed(
                                  context, AppRouts.attendanceScreen);
                            }
                            AppCubit.get(context).lectureData = lecture;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text("المحاضره لم تبدا بعد"),
                              ),
                            );
                          }
                          // await AppCubit.get(context).getExcelSheet(
                          //   className: AppCubit.get(context).className,
                          //   lectureNumber: (index + 1).toString(),
                          // );

                          // AppCubit.get(context).getDataFormExcel();

                          // if (AppCubit.get(context).attendanceList.isNotEmpty) {
                          //   if (AppCubit.get(context).userData!.isStudent ==
                          //       "1") {
                          //     String id = AppCubit.get(context).userData!.id!;

                          //     AppCubit.get(context).studentData =
                          //         AppCubit.get(context)
                          //             .attendanceList
                          //             .firstWhere(
                          //               (element) => element.id == id,
                          //             );

                          //     AppCubit.get(context).lectureNumber =
                          //         "Lecture ${index + 1}";

                          //     Navigator.pushNamed(
                          //         context, AppRouts.attendanceScreenStudent);
                          //   } else {
                          //     AppCubit.get(context).lectureNumber =
                          //         "Lecture ${index + 1}";

                          //     Navigator.pushNamed(
                          //         context, AppRouts.attendanceScreen);
                          //   }
                          //   //if student
                          // } else {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) => const AlertDialog(
                          //       content: Text("المحاضره لم تبدا بعد"),
                          //     ),
                          //   );
                          // }
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class CustomLectures extends StatelessWidget {
  const CustomLectures({
    super.key,
    required this.className,
    this.onTap,
  });
  final String className;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
        verticalOffset: 50.0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 7),
            decoration: const BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(className,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.colorWhite)),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.colorWhite,
                ),
              ],
            ),
          ),
        ));
  }
}
