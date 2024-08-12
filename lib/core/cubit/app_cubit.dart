import 'dart:io';

import 'package:attendance/core/cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import '../../screens/Attendance/data/model/attendance_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  final List<String> classNames = [
    "fundamental of programming ",
    "Object-oriented programming ",
    "Data Structures",
    "Algorithmes",
    "DataBase Administration",
    "Big Data",
  ];
  String className = "";
  String lectureNumber = "";
  List<AttendanceModel> attendanceList = [];
  Excel? excel;
  getExcelSheet() async {
    emit(GetExcelSheetLoadingState());
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );
    if (pickedFile != null) {
      var byte = File(pickedFile.files.first.path!).readAsBytesSync();
      excel = Excel.decodeBytes(byte);

      emit(GetExcelSheetSuccessState());
    } else {
      emit(GetExcelSheetErrorState());
    }
  }

  getDataFormExcel() {
    attendanceList = [];
    if (excel != null) {
      for (var table in excel!.tables.keys) {
        // print(table); //sheet Name
        // print(excel.tables[table]!.maxColumns);
        // print(excel.tables[table]!.maxRows);
        for (var row in excel!.tables[table]!.rows) {
          // print(row.single!.value);
          attendanceList.add(AttendanceModel(
            id: row[0]!.value.toString(),
            name: row[1]!.value.toString(),
            attend: row[2]!.value.toString(),
            time: row[3]!.value.toString(),
          ));
        }
      }
      attendanceList.removeAt(0);
      emit(GetDataFromExcelSheetSuccessState());
    } else {
      emit(GetDataFromExcelSheetErrorState());
    }
  }
}
