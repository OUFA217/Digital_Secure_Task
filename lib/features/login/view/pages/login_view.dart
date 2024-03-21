// ignore_for_file: must_be_immutable

import 'package:digital_secure_task/core/config/themes.dart';
import 'package:digital_secure_task/core/utils/image_constants.dart';
import 'package:digital_secure_task/core/utils/string_constants.dart';
import 'package:digital_secure_task/features/login/model/login_model.dart';
import 'package:digital_secure_task/features/login/view/widgets/custom_button.dart';
import 'package:digital_secure_task/features/login/view/widgets/custom_text_form_field.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model_state.dart';
import 'package:digital_secure_task/features/main/view/pages/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, InitialLoginViewModelState>(
        builder: (context, state) {
      final loginViewModel = LoginViewModel.get(context);

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromRGBO(242, 242, 242, 1)),
          ),
        ),
        backgroundColor: const Color.fromRGBO(242, 242, 242, 1.0),
        body: ModalProgressHUD(
          inAsyncCall: loginViewModel.isLoading,
          child: Form(
            key: loginViewModel.formKey,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 179.0.h),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.loginBackground),
                          fit: BoxFit.cover,
                          opacity: 0.3),
                    ),
                  ),
                ),
                Positioned(
                    top: 317.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 37.w, right: 37.w),
                      child: Column(
                        children: [
                          loginViewModel.isCredentialWrong == true
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 63.w, right: 62.w),
                                  child: Container(
                                    width: 231.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9).r,
                                        color: Themes.colorfulRed),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            ImageAssets.wrongCredentialPic),
                                        SizedBox(width: 10.2.w),
                                        Text(StringConstants.wrongCredential,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall)
                                      ],
                                    )),
                                  ),
                                )
                              : SizedBox(
                                  width: 231.w,
                                  height: 40.h,
                                ),
                          SizedBox(
                            height: 13.h,
                          ),
                          CustomTextFormField(
                            hintText: StringConstants.hintEmailUserName,
                            controller: loginViewModel.emailController,
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          CustomTextFormField(
                            hintText: StringConstants.hintPassword,
                            controller: loginViewModel.passwordController,
                            obSecure: true,
                          ),
                          SizedBox(height: 254.h),
                          CustomButton(
                            text: StringConstants.registerLogin,
                            onTap: () async {
                              final emailController =
                                  loginViewModel.emailController.text;
                              final password =
                                  loginViewModel.passwordController.text;
                              if (loginViewModel
                                      .emailController.text.isNotEmpty &&
                                  loginViewModel
                                      .passwordController.text.isNotEmpty) {
                                await loginViewModel
                                    .signUp(
                                  LoginModel(
                                    emailAddress: emailController,
                                    userName: emailController,
                                    password: password,
                                  ),
                                )
                                    .then((value) {
                                  if (emailController
                                      .contains("oufa2217@gmail.com")) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainView(
                                                  isMaster: true,
                                                  loginModel: LoginModel(
                                                    emailAddress:
                                                        emailController,
                                                    userName: emailController,
                                                    password: password,
                                                  ),
                                                )));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainView(
                                                  isMaster: false,
                                                  loginModel: LoginModel(
                                                    emailAddress:
                                                        emailController,
                                                    userName: emailController,
                                                    password: password,
                                                  ),
                                                )));
                                  }
                                });
                              } else {
                                loginViewModel.checkCredential();
                              }
                            },
                            height: 54.h,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
