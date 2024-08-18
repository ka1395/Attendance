import 'package:attendance/core/cubit/app_cubit.dart';
import 'package:attendance/screens/Attendance/presentaion/lecture_attendance.dart';
import 'package:attendance/screens/home/home_screen.dart';
import 'package:attendance/screens/search/search_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/resources/bloc_observer.dart';
import 'core/resources/get_it.dart';
import 'core/resources/routs.dart';
import 'core/resources/theme_app.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/lectuers/lectuers_screen.dart';
import 'screens/login/new_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      theme: lightTheme(),
      initialRoute: AppRouts.loginScreen,
      routes: {
        AppRouts.loginScreen: (context) {
          initAppCubit();
          return const LoginScreen();
        },
        AppRouts.mainScreen: (context) {
          initAppCubit();
          return BlocProvider.value(
              value: instance.get<AppCubit>(), child: const HomeScreens());
        },
        AppRouts.lectursScreen: (context) {
          initAppCubit();

          return BlocProvider.value(
              value: instance.get<AppCubit>()..getExcelSheet(),
              child: const LecturesScreen());
        },
        AppRouts.attendanceScreen: (context) {
          initAppCubit();
          return BlocProvider.value(
              value: instance.get<AppCubit>(),
              child: const LectureAttendance());
        },
        AppRouts.searchScreen: (context) {
          initAppCubit();
          return BlocProvider.value(
              value: instance.get<AppCubit>(), child: const SearchScreen());
        },
      },
    );
  }
}
