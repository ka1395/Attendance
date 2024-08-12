import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:attendance/core/resources/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/resources/app_colors.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppCubit.get(context).className,
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
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: CustomLectures(
                            className: "Lecture ${index + 1}",
                            onTap: () {
                              AppCubit.get(context).lectureNumber =
                                  "Lecture ${index + 1}";
                              Navigator.pushNamed(
                                  context, AppRouts.attendanceScreen);
                            }));
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
