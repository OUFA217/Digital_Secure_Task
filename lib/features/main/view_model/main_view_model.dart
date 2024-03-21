import 'package:digital_secure_task/features/main/view_model/main_view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewModel extends Cubit<InitialMainViewModelState> {
  MainViewModel() : super(SuperMainViewModelState());
  static MainViewModel get(context) => BlocProvider.of(context);
  final List<Color> usersContainerColors = [
    const Color.fromRGBO(251, 176, 59, 1),
    const Color.fromRGBO(216, 95, 95, 1),
    const Color.fromRGBO(157, 59, 251, 1),
  ];
  String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
