import 'package:flutter/material.dart';
import '../../utils/app_style.dart';
import '../../utils/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hintText,
      this.icon,
      this.label,
      this.preFix,
      this.suffix,
      this.controller,
      this.textInputType,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final Widget? icon;
  final String? label;
  final Widget? preFix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // ignore: prefer_typing_uninitialized_variables
  final maxLines;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.btnColor,
      keyboardType: textInputType,
      controller: controller,
      //maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: preFix,
        suffix: preFix,
        hintText: hintText,
        helperStyle: textStyle,
        isDense: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColor.btnColor),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColor.btnColor),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColor.btnColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
