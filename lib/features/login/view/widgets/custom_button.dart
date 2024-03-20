import 'package:digital_secure_task/core/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.height,
  });
  final String? text;
  final VoidCallback? onTap;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: 354.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9).r, color: Themes.blue),
        child: Center(
            child: Text(
          text!,
          style: Theme.of(context).textTheme.headlineSmall,
        )),
      ),
    );
  }
}
