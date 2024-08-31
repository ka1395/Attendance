import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/resources/app_colors.dart';
import 'package:attendance/core/resources/routs.dart';
import 'package:flutter/material.dart';

import '../../../core/model/user_data.dart';

class AppBarWidge extends StatelessWidget {
  const AppBarWidge({
    super.key,
    required this.title,
    required this.nameUser,
    required this.imagePath,
  });
  final String title;
  final String nameUser;
  final String imagePath;
  // final String locationName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .2,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      decoration: const BoxDecoration(
        color: AppColors.primaryColorLight,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppColors.colorWhite)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).userData = UserData();
                    Navigator.pushReplacementNamed(
                        context, AppRouts.loginScreen);
                  },
                  icon:
                     const  Icon(Icons.logout_outlined, color: AppColors.colorWhite))
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                nameUser,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppColors.colorWhite),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
