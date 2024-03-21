import 'package:digital_secure_task/features/login/view_model/login_view_model.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initializeDependencyInjection() {
  debugPrint("setup is called");
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<MainViewModel>(() => MainViewModel());
}
