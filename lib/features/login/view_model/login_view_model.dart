import 'dart:developer';

import 'package:digital_secure_task/features/login/model/login_model.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginViewModel extends Cubit<InitialLoginViewModelState> {
  LoginViewModel() : super(SuperLoginViewModelState());
  static LoginViewModel get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isCredentialWrong = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp(LoginModel loginModel) async {
    isLoading = true;
    emit(IsLoadingState());
    if (loginModel.emailAddress.contains('@')) {
      final indexOfAt = loginModel.emailAddress.indexOf('@');

      loginModel.userName = emailController.text.substring(0, indexOfAt);
      final user = ParseUser(
          loginModel.userName, loginModel.password, loginModel.emailAddress);
      user.set('UserName', loginModel.userName);
      user.set('Password', loginModel.password);
      user.set('EmailAddress', loginModel.emailAddress);
      try {
        final response = await user.signUp();
        if (response.success == true) {
          log('User signed up successfully: $user');
          log(response.results.toString());
          await _signIn(loginModel);
          log(response.result.toString());
        } else if (response.error!.message.toString() ==
            "Account already exists for this username.") {
          await _signIn(loginModel);
        } else {
          log("aaaaaa");
          log(response.error!.message.toString());
        }
      } on ParseException catch (e) {
        log('Error signing up: ${e.toString()}');
      }
    } else {
      loginModel.userName = loginModel.emailAddress;
      final user = ParseUser(loginModel.userName, loginModel.password, null);
      user.set('UserName', loginModel.userName);
      user.set('Password', loginModel.password);
      user.set('EmailAddress', loginModel.emailAddress);
      try {
        final response = await user.signUp(allowWithoutEmail: true);
        if (response.success == true) {
          log('User signed up successfully: $user');
          await _signIn(loginModel);
          log(response.result.toString());
        } else if (response.error!.message.toString() ==
            "Account already exists for this username.") {
          await _signIn(loginModel);
          log(response.result.toString());
        } else {
          log(response.error!.message.toString());
        }
      } on ParseException catch (e) {
        log('Error signing up: ${e.toString()}');
      }
    }
  }

  Future<void> _signIn(LoginModel loginModel) async {
    try {
      if (loginModel.emailAddress.contains('@')) {
        final indexOfAt = loginModel.emailAddress.indexOf('@');
        final userName = emailController.text.substring(0, indexOfAt);

        final user = await ParseUser(
                userName, loginModel.password, loginModel.emailAddress)
            .login();
        if (user.error != null) {
          if (user.error!.message.toString() == "Invalid username/password.") {
            isLoading = false;
            emit(IsLoadingState());
            checkCredential();
            throw Exception("Invalid username/password.");
          }
        }

        log('User logged in successfully: ${user.result}');
      } else {
        loginModel.userName = loginModel.emailAddress;
        final user =
            await ParseUser(loginModel.userName, loginModel.password, null)
                .login();
        if (user.error != null) {
          if (user.error!.message.toString() == "Invalid username/password.") {
            isLoading = false;
            emit(IsLoadingState());
            checkCredential();

            throw Exception("Invalid username/password.");
          }
        }

        log('User logged in successfully: ${user.result}');
      }
    } on ParseException catch (e) {
      log('Error logging in: $e');
    }
  }

  void checkCredential() {
    isCredentialWrong = true;
    emit(IsCredentialState());
  }
}
