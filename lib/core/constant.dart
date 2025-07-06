import 'package:attendance/core/model/user_data.dart';

String baseUrl = "https://63bbe1ef-2f9e-4750-a31e-1c30d156def1.mock.pstmn.io";
bool isStudent = false;
List<UserData> users = [
  UserData(
    email: "salama@gmail.com",
    id: "",
    isStudent: "0",
    name: "د.احمد سلامه",
    password: "123456789",
  ),
  UserData(
    email: "ahmed@gmail.com",
    id: "2021045",
    isStudent: "1",
    name: "احمد محمد ابراهيم محمد محمد",
    password: "123456789",
  ),
  // UserData(
  //   email: "seif@gmail.com",
  //   id: "2023105",
  //   isStudent: "1",
  //   name: "سيف محمد زايد محمد",
  //   password: "123456789",
  // ),
];
