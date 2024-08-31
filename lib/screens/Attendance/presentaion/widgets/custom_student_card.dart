import 'package:flutter/material.dart';

import '../../../../core/resources/app_colors.dart';

class CustomStudenctCard extends StatelessWidget {
  const CustomStudenctCard(
      {super.key,
      required this.name,
      required this.status,
      required this.imagePath,
      required this.date});
  final String name;
  final String status;
  final String imagePath;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .15,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        color: AppColors.colorWhite,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 15, bottom: 20),
                    child: CircleAvatar(
                        foregroundImage: AssetImage(imagePath), radius: 30)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الاسم",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.colorGray),
                            ),
                            Text(
                              "الحاله",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.colorGray),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 180,
                              child: Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              status == "0" ? "غياب" : "حضور",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: status == "0"
                                          ? AppColors.colorRed
                                          : AppColors.primaryColorLight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  decoration: BoxDecoration(
                      color: status == "0"
                          ? AppColors.colorRed
                          : AppColors.primaryColorLight),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.colorGray),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
