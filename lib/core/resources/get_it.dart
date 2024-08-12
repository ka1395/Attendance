import 'package:get_it/get_it.dart';

import '../cubit/app_cubit.dart';

final instance = GetIt.instance;

initAppCubit() {
  if (!GetIt.I.isRegistered<AppCubit>()) {
      print("create instance");
   
    instance.registerLazySingleton<AppCubit>(() => AppCubit());
  }
}
