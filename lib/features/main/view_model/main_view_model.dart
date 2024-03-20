import 'package:digital_secure_task/features/main/view_model/main_view_model_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewModel extends Cubit<InitialMainViewModelState> {
  MainViewModel() : super(SuperMainViewModelState());
  static MainViewModel get(context) => BlocProvider.of(context);
  void fetchingWalletMoney() {}
  void fetchingLastSpend() {}
  void fetchingTotalSpending() {}
  String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
