import 'package:flutter/material.dart';
import '../../../utils/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, this.textButton, this.onTapPress, this.style, this.margin})
      : super(key: key);
  final String? textButton;
  final VoidCallback? onTapPress;
  final TextStyle? style;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapPress,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: decoration,
        child: Text(
          textButton ?? "",
          style: style,
        ),
      ),
    );
  }
}
