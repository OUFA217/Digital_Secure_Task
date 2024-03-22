import 'package:digital_secure_task/core/config/themes.dart';
import 'package:digital_secure_task/core/utils/icon_constants.dart';
import 'package:digital_secure_task/core/utils/image_constants.dart';
import 'package:digital_secure_task/core/utils/string_constants.dart';
import 'package:digital_secure_task/features/login/model/login_model.dart';
import 'package:digital_secure_task/features/login/view/widgets/custom_button.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model.dart';
import 'package:digital_secure_task/features/main/view/widgets/custom_master_information.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.isMaster, required this.loginModel});
  final LoginModel loginModel;
  final bool isMaster;
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = MainViewModel.get(context);
    String greeting = mainViewModel.getGreeting();
    return BlocBuilder<MainViewModel, InitialMainViewModelState>(
        builder: (context, state) {
      Logger().e(LoginViewModel.get(context).usersModel.userName);
      return Scaffold(
        backgroundColor: const Color.fromRGBO(242, 242, 242, 1.0),
        body: FutureBuilder(
          future: ParseUser.currentUser().asStream().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final user = snapshot.data as ParseUser;
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 370.0.h),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          ImageAssets.mainBackground,
                        ),
                      )),
                    ),
                  ),
                  Positioned(
                    top: 74.9.h,
                    left: 37.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 281.9.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(IconAssets.notification),
                              SizedBox(width: 28.3.w),
                              SvgPicture.asset(IconAssets.menu),
                            ],
                          ),
                        ),
                        SizedBox(height: 47.2.h),
                        Row(
                          children: [
                            Image.asset(
                              height: 88.h,
                              width: 88.w,
                              ImageAssets.profilePic,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$greeting,",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                Text(
                                  loginModel.userName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 54.h,
                        ),
                        Row(children: [
                          CustomUserInformation(
                              color: const Color.fromRGBO(78, 78, 78, 1),
                              title: StringConstants.yourWallet,
                              price: double.parse(LoginViewModel.get(context)
                                      .usersModel
                                      .walletAmount!
                                      .first)
                                  .toString(),
                              description: StringConstants.lastUpdate,
                              image: IconAssets.wallet,
                              widthOfImage: 34.63,
                              heightOfImage: 34.44,
                              dateOfUpdate: LoginViewModel.get(context)
                                  .usersModel
                                  .walletLastTransactionDate!
                                  .first),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomUserInformation(
                            color: const Color.fromRGBO(162, 162, 162, 1),
                            title: StringConstants.lastActivity,
                            price: double.parse(LoginViewModel.get(context)
                                    .usersModel
                                    .lastActivityAmount!
                                    .first)
                                .toString(),
                            description: StringConstants.transactionOn,
                            image: IconAssets.activity,
                            widthOfImage: 40.63,
                            heightOfImage: 34.44,
                            dateOfTransaction: LoginViewModel.get(context)
                                .usersModel
                                .lastActivityDate!
                                .first,
                          )
                        ]),
                        SizedBox(
                          height: 42.h,
                        ),
                        CustomButton(
                            isTest: true,
                            borderRaduis: 13,
                            text: StringConstants.test,
                            onTap: () {},
                            height: 101.h),
                        SizedBox(height: 39.h),
                        Text(
                          StringConstants.users,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 21.sp,
                                  letterSpacing: 0),
                        ),
                        SizedBox(height: 26.h),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32.0.w, top: 686.0.h),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: LoginViewModel.get(context)
                            .usersModel
                            .userName!
                            .length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 14.w,
                          );
                        },
                        itemBuilder: (context, index) {
                          int colorIndex = index %
                              MainViewModel.get(context)
                                  .usersContainerColors
                                  .length;

                          if (LoginViewModel.get(context)
                                  .usersModel
                                  .type!
                                  .elementAt(index) !=
                              "Slave") {
                            return const SizedBox();
                          }

                          return Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 32.0.h,
                                ),
                                child: Container(
                                  height: 172.h,
                                  width: 134.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                      color: Themes.white),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 91.h,
                                        width: 134.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(13.r),
                                                topLeft: Radius.circular(13.r)),
                                            color: MainViewModel.get(context)
                                                    .usersContainerColors[
                                                colorIndex]),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 35.0.h),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  LoginViewModel.get(context)
                                                      .usersModel
                                                      .userName!
                                                      .elementAt(index),
                                                  // usersModel!.userName!.first,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(
                                                          fontSize: 16.sp,
                                                          letterSpacing: 0),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Total Spending",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                          fontSize: 12.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 7.h),
                                      Padding(
                                        padding: EdgeInsets.only(left: 23.0.w),
                                        child: Row(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                StringConstants.egp,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .copyWith(
                                                        fontSize: 11.sp,
                                                        letterSpacing: 0,
                                                        color: Colors.black),
                                              ),
                                            ),
                                            Text(
                                              double.parse(LoginViewModel.get(
                                                          context)
                                                      .usersModel
                                                      .lastActivityAmount!
                                                      .elementAt(index))
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge!
                                                  .copyWith(
                                                      fontSize: 32.sp,
                                                      letterSpacing: 0,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            StringConstants.lastSpend,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                    fontSize: 10.sp,
                                                    color: Colors.black),
                                          ),
                                          Text(
                                            LoginViewModel.get(context)
                                                .usersModel
                                                .lastActivityDate!
                                                .elementAt(index)
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                    fontSize: 10.sp,
                                                    color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 37.w,
                                  child: Image.asset(
                                    height: 58.h,
                                    width: 58.h,
                                    ImageAssets.profilePic,
                                  ))
                            ],
                          );
                        }),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      );
    });
  }
}
