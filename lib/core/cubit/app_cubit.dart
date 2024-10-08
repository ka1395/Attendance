import 'package:attendance/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';
import 'package:attendance/core/cubit/app_state.dart';
import '../../screens/Attendance/data/model/attendance_model.dart';
import '../model/user_data.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  final List<String> classNames = [
    "fundamental of programming",
    // "Object-oriented programming ",
    // "Data Structures",
    "Algorithmes",
    // "DataBase Administration",
    // "Big Data",
  ];
  String className = "";
  String lectureNumber = "";
  List<AttendanceModel> attendanceList = [];
  Excel? excel;
  UserData? userData;
  AttendanceModel? studentData;
  Future<void> getExcelSheet({String? className, String? lectureNumber}) async {
    try {
      emit(GetExcelSheetLoadingState());

      ByteData data = await rootBundle
          .load('assets/excel/$className/AttendanceSheet$lectureNumber.xlsx');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      excel = Excel.decodeBytes(bytes);

      emit(GetExcelSheetSuccessState());
    } catch (e) {
      print('Error loading Excel sheet: $e');
      emit(GetExcelSheetErrorState());
    }
  }

  void getDataFormExcel() {
    attendanceList = [];
    if (excel != null) {
      for (var table in excel!.tables.keys) {
        for (var row in excel!.tables[table]!.rows) {
          String? type = row[3]?.value.toString();
          String mappedType = "0";

          if (type != null) {
            if (type.contains("Late") || type.contains("Leave Early")) {
              mappedType = "1";
            } else if (type.contains("Absenteeism")) {
              mappedType = "0";
            }
          }
          String? name = row[0]?.value.toString();
          String trimmedName = name?.replaceAll(' ', '') ?? '';
          String imageName = trimmedName.toLowerCase();

          attendanceList.add(AttendanceModel(
              attend: mappedType,
              name: row[0]?.value.toString() ?? '',
              checkTime: row[1]?.value.toString() ?? '',
              id: row[5]?.value.toString() ?? '',
              image: "assets/images/6.png"));
        }
        if (attendanceList.isNotEmpty) {
          attendanceList.removeAt(0);
        }

        emit(GetDataFromExcelSheetSuccessState());
      }
    } else {
      emit(GetDataFromExcelSheetErrorState());
    }
  }

  login({String? email, String? pass}) {
    emit(LoginLoadingState());
    var respons = users.firstWhere(
        (element) => element.email == email && element.password == pass,
        orElse: () => UserData(
              email: "0",
              id: "",
              isStudent: "",
              name: "",
              password: "",
            ));
    if (respons.email != "0") {
      userData = respons;
      emit(LoginSuccessState());
      return true;
    } else {
      emit(LoginErrorState());
      return false;
    }
  }
}
