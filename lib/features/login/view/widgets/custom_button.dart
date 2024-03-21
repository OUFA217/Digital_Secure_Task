import 'package:digital_secure_task/core/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.height,
      this.borderRaduis = 9,
      this.isTest = false});
  final String? text;
  final VoidCallback? onTap;
  final double? height;
  final double borderRaduis;
  final bool isTest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: 354.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRaduis).r,
            color: Themes.blue),
        child: isTest
            ? Padding(
                padding: EdgeInsets.only(right: 45.6.w, left: 150.w),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        text!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Themes.white,
                    )
                  ],
                ),
              )
            : Center(
                child: Text(
                text!,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
      ),
    );
  }
}
