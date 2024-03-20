import 'package:digital_secure_task/core/utils/image_constants.dart';
import 'package:digital_secure_task/features/login/model/login_model.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.isMaster, required this.loginModel});
  final LoginModel loginModel;
  final bool isMaster;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewModel, InitialMainViewModelState>(
        builder: (context, state) {
      // MainViewModel mainViewModel = MainViewModel.get(context);

      return Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: ParseUser.all().asStream().last,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  Logger().f(snapshot.data!.results.toString());
                  return Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.mainBackground,
                            ),
                            fit: BoxFit.fitWidth)),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      );
    });
  }
}
