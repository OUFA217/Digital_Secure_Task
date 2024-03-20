// ignore_for_file: must_be_immutable

import 'package:digital_secure_task/core/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.hintText,
    required this.controller,
    this.obSecure = false,
    super.key,
  });
  String? hintText;
  TextEditingController? controller;
  bool obSecure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 54.h,
      width: 354.h,
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        obscureText: obSecure,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9).r,
            borderSide: const BorderSide(color: Themes.white, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9).r,
            borderSide: const BorderSide(color: Themes.white, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9).r,
              borderSide: const BorderSide(
                color: Themes.white,
                width: 0,
              )),
          hoverColor: Themes.white,
          focusColor: Themes.white,
          filled: true,
          fillColor: Themes.white,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black, fontSize: 19.sp),
          contentPadding: EdgeInsets.only(
            right: 37.w,
            left: 37.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9).r,
            borderSide: const BorderSide(color: Themes.white, width: 0),
          ),
        ),
      ),
    );
  }
}
