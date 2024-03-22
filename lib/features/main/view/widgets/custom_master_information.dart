// ignore_for_file: must_be_immutable

import 'package:digital_secure_task/core/config/themes.dart';
import 'package:digital_secure_task/core/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomUserInformation extends StatelessWidget {
  CustomUserInformation(
      {super.key,
      required this.title,
      required this.price,
      required this.color,
      required this.description,
      required this.image,
      required this.widthOfImage,
      required this.heightOfImage,
      this.dateOfTransaction,
      this.dateOfUpdate});
  final String title;
  final String price;
  final Color color;
  final String description;
  final String image;
  final double widthOfImage;
  final double heightOfImage;
  String? dateOfTransaction;
  String? dateOfUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172.h,
      width: 172.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r), color: Themes.white),
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: 172.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13.r),
                    topLeft: Radius.circular(13.r)),
                color: color),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          SizedBox(height: 10.9.h),
          Center(
              child: SvgPicture.asset(
            image,
            width: widthOfImage.w,
            height: heightOfImage.h,
          )),
          Padding(
            padding: EdgeInsets.only(left: 23.0.w),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    StringConstants.egp,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: const Color.fromRGBO(154, 154, 154, 1),
                        fontSize: 14.sp),
                  ),
                ),
                Text(
                  price,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black, fontSize: 42.sp),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 10.sp,
                    color: const Color.fromRGBO(116, 116, 116, 1)),
              ),
              Text(
                description == StringConstants.lastUpdate
                    ? dateOfUpdate!
                    : dateOfTransaction!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 10.sp,
                    color: const Color.fromRGBO(116, 116, 116, 1)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
