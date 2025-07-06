
import 'package:attendance/core/constant.dart';
import 'package:attendance/core/network/dio.dart';
import 'package:attendance/screens/home/model/data_model/data_model.dart';
import 'package:attendance/screens/home/model/data_model/lecture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';
import 'package:attendance/core/cubit/app_state.dart';
import '../../screens/Attendance/data/model/attendance_model.dart';
import '../../screens/home/model/data_model/student.dart';
import '../../screens/home/model/data_model/subject.dart';
import '../model/user_data.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  String lectureNumber = "";
  Excel? excel;
  UserData? userData;
  Student? myStudentData;
  DataModel? dataModel;
  Subject? subjectData;
  Lecture? lectureData;
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

  getData() async {
    emit(GetDataLoadingState());
    await DioHelper.get(url: '/getLecturesAttendance').then(
      (value) {
        Future.delayed(const Duration(seconds: 3));
        dataModel = DataModel.fromJson(value.data);
        emit(GetDataSuccessState());
      },
    ).catchError((error) {
      emit(GetDataErrorState());
    });
  }

}
