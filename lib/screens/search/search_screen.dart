import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/core/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../core/resources/app_colors.dart';
import '../Attendance/presentaion/widgets/custom_student_card.dart';
import '../home/model/data_model/student.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Student> students;

  @override
  void initState() {
    students = AppCubit.get(context).lectureData!.students!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SuggestionsController<Student>? suggestionsController =
        SuggestionsController();
    TextEditingController customSearch = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("البحث"),
      ),
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TypeAheadField<Student>(
              suggestionsController: suggestionsController,
              suggestionsCallback: (search) {
                return students.where((element) {
                  return element.name!
                      .toUpperCase()
                      .contains(search.toUpperCase());
                }).toList();
              },
              builder: (context, controller, focusNode) {
                customSearch = controller;
                suggestionsController.refresh();

                return TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColorLight,
                    ),
                    hintText: "بحث عن طالب",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColorLight)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColorLight)),
                  ),
                  controller: customSearch,
                  focusNode: focusNode,
                  onChanged: (value) {},
                );
              },
              itemBuilder: (context, item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStudenctCard(
                    name: item.name!,
                    status: item.isAttend!,
                    imagePath: item.image!,
                    date: item.checkInTime !,
                  ),
                );
              },
              onSelected: (item) {
                customSearch.clear();
                suggestionsController.close();
              },
            ),
          ),
        );
      }),
    );
  }
}
