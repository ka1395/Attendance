import 'package:attendance/core/cubit/app_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:excel/excel.dart';
import '../../screens/Attendance/data/model/attendance_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  final List<String> classNames = [
    "fundamental of programming ",
    // "Object-oriented programming ",
    // "Data Structures",
    "Algorithmes",
    // "DataBase Administration",
    // "Big Data",
  ];
  String className = "";
  String lectureNumber = "";
  List<AttendanceModel> attendanceList = [];
  int numberOfExcel = 3;
  List<Excel>? excels = [];
  getExcelSheet() async {
    // emit(GetExcelSheetLoadingState());
    // FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['xlsx'],
    //   allowMultiple: false,
    // );
    // if (pickedFile != null) {
    //   var byte = File("assets/excel/AttendanceSheet.xlsx").readAsBytesSync();
    //   excel = Excel.decodeBytes(byte);

    //   emit(GetExcelSheetSuccessState());
    // } else {
    //   emit(GetExcelSheetErrorState());
    // }
    excels = [];
    emit(GetExcelSheetLoadingState());
    for (int i = 0; i < numberOfExcel; i++) {
      ByteData data =
          await rootBundle.load("assets/excel/AttendanceSheet${i + 1}.xlsx");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      excels!.add(Excel.decodeBytes(bytes));
    }

    emit(GetExcelSheetSuccessState());
  }

  getDataFormExcel(int index) {
    attendanceList = [];
    if (excels![index] != null) {
      for (var table in excels![index].tables.keys) {
        // print(table); //sheet Name
        // print(excel.tables[table]!.maxColumns);
        // print(excel.tables[table]!.maxRows);
        for (var row in excels![index].tables[table]!.rows) {
          // print(row.single!.value);
          attendanceList.add(AttendanceModel(
            id: row[0]!.value.toString(),
            name: row[1]!.value.toString(),
            attend: row[2]!.value.toString(),
            time: row[3]!.value.toString(),
            imgae: row[4]!.value.toString(),
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
