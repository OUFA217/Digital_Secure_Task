import 'dart:developer';

import 'package:digital_secure_task/features/login/model/login_model.dart';
import 'package:digital_secure_task/features/login/model/users_model.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:sqflite/sqflite.dart';

class LoginViewModel extends Cubit<InitialLoginViewModelState> {
  LoginViewModel() : super(SuperLoginViewModelState());
  static LoginViewModel get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isCredentialWrong = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Database? database;

  // Function for signing up a user with the provided login model.
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

  // A function that inserts users into the database using a transaction. It takes a UsersModel object as a parameter. This function asynchronously inserts multiple user records into the 'Users' table of the database. It then logs a message, retrieves users from the database, and emits an InsertUsersState.
  Future<void> insertUserstoDatabase(UsersModel usersModel) async {
    await database!.transaction((txn) async {
      try {
        Future.wait([
          txn.rawInsert(
              'INSERT INTO Users(UserName, Type, WalletAmount,WalletLastTransactionDate,LastActivityAmount,LastActivityDate) VALUES("khaled", "Master", "920" , "11/3" ,"245","20/3")'),
          txn.rawInsert(
              'INSERT INTO Users(UserName, Type, WalletAmount,WalletLastTransactionDate,LastActivityAmount,LastActivityDate) VALUES("Abdelrahman", "Slave", "185" , "19/3" ,"240","21/3")'),
          txn.rawInsert(
              'INSERT INTO Users(UserName, Type, WalletAmount,WalletLastTransactionDate,LastActivityAmount,LastActivityDate) VALUES("Saif", "Slave", "620" , "19/5" ,"320","21/1")'),
          txn.rawInsert(
              'INSERT INTO Users(UserName, Type, WalletAmount,WalletLastTransactionDate,LastActivityAmount,LastActivityDate) VALUES("Karim", "Slave", "120" , "19/3" ,"950","21/8")')
        ]).then((value) async {
          log("Inserted");
          await _getUsersFromDatabase(usersModel);
          emit(InsertUsersState());
        });
      } catch (e) {
        log(e.toString());
      }
    });
  }

  // A function that retrieves users from the database and populates the provided UsersModel with the retrieved data.
  Future<void> _getUsersFromDatabase(UsersModel usersModel) async {
    await database!.rawQuery('SELECT * FROM Users').then((value) {
      for (var element in value) {
        usersModel.userName!.add(element['UserName'].toString());
        usersModel.type!.add(element['Type'].toString());
        usersModel.walletAmount!.add(element['WalletAmount'].toString());
        usersModel.walletLastTransactionDate!
            .add(element['WalletLastTransactionDate'].toString());
        usersModel.lastActivityAmount!
            .add(element['LastActivityAmount'].toString());
        usersModel.lastActivityDate!
            .add(element['LastActivityDate'].toString());
      }
    }).then((value) {
      emit(GetUsersState());
    });
  }

  UsersModel usersModel = UsersModel(
      userName: [],
      type: [],
      walletAmount: [],
      walletLastTransactionDate: [],
      lastActivityAmount: [],
      lastActivityDate: []);

  /// Sign in a user with the provided login information.
  ///
  /// The [loginModel] parameter contains the user's login information, including
  /// the email address, password, and user name.
  ///
  /// Returns a `Future` that completes when the user has been successfully signed
  /// in. If there is an error during the sign in process, an exception is thrown.
  Future<void> _signIn(LoginModel loginModel) async {
    try {
      await openDatabase(
        'Users.db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE Users(id INTEGER PRIMARY KEY, UserName TEXT, Type TEXT, WalletAmount TEXT, WalletLastTransactionDate TEXT, LastActivityAmount TEXT, LastActivityDate TEXT)');
          emit(DatabaseInitializedState());
        },
        onOpen: (db) {
          Logger().e("Gat");
          emit(DatabaseOpenedState());
        },
      ).then((value) {
        database = value;
        emit(DatabaseOpenedState());
        insertUserstoDatabase(usersModel);
        log("Initialized");
      });
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

  // A function to check credentials and emit the appropriate state.
  void checkCredential() {
    isCredentialWrong = true;
    emit(IsCredentialState());
  }
}
