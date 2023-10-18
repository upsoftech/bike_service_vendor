import 'package:flutter/material.dart';

import '../../utils/app_style.dart';
import '../../utils/color.dart';


class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key, required this.error}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.btnColor,
        elevation: 0,
        title: const Text(
          "Oops! error found",
          style: appbarStyle,
        ),
      ),
      body: Center(
        child: Text(
          error,
          style: h1Style,
        ),
      ),
    );
  }
}
