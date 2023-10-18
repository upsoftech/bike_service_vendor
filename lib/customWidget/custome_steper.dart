import 'package:flutter/material.dart';
import '../../utils/app_dimension.dart';
import '../../utils/app_style.dart';
import '../../utils/color.dart';

class CustomStepper extends StatelessWidget {
  final bool isActive;
  final bool haveTopBar;
  final String title;
  final Widget child;
  final double height;

    CustomStepper(
        {super.key, required this.title, required this.isActive,
          required this.child, this.haveTopBar = true, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      haveTopBar
          ? Row(children: [
        Container(
          height: height,
          width: 2,
          margin: const EdgeInsets.only(left: 14),
          color: isActive ? Theme.of(context).primaryColor : AppColor.grey,
        ),
        child == null ?  SizedBox() : child,
      ])
          : const SizedBox(),
      Row(children: [
        isActive
            ? const Icon(Icons.check_circle_outlined, color: Colors.grey, size: 25)
            : Container(
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.only(left: 6),
          decoration: BoxDecoration(border: Border.all(color: AppColor.grey, width: 2), shape: BoxShape.circle),
        ),
        SizedBox(width: isActive ? AppDimension.PADDING_SIZE_EXTRA_SMALL : AppDimension.PADDING_SIZE_SMALL),
        Text(title,
            style: isActive
                ? titleGrey.copyWith(fontSize: AppDimension.FONT_SIZE_LARGE)
                : titleGrey.copyWith(fontSize: AppDimension.FONT_SIZE_LARGE)),
      ]),
    ]);
  }
}
