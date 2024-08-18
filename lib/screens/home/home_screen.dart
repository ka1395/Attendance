import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:attendance/core/resources/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/resources/app_colors.dart';
import 'widgets/custom_app_bar.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AppBarWidge(
            title: "الصفحه الرئيسيه",
            imagePath: "assets/images/6.png",
            nameUser: "اهلاً ,  د. احمد سلامه",
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) => ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: AppCubit.get(context).classNames.length,
              itemBuilder: (context, index) {
                var indexImgae = index;
                if (index > 6) indexImgae = index % 6;

                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * .17,
                  child: Stack(children: [
                    InkWell(
                      onTap: () {
                        AppCubit.get(context).className =
                            AppCubit.get(context).classNames[index];

                        Navigator.pushNamed(context, AppRouts.lectursScreen);
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .17,
                        margin: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            // color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                opacity: .8,
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    "assets/images/imageClass$indexImgae.jpg"))),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          AppCubit.get(context).classNames[index],
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppColors.colorWhite),
                        ),
                      ),
                    )
                  ]),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
