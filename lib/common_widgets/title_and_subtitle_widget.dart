import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/themes/app_theme.dart';
import 'package:microfinance/utils/fonts.dart';
import 'package:flutter/material.dart';

class TitleAndSubtitleText extends StatelessWidget {
  final String title1;
  final String title2;
  const TitleAndSubtitleText({
    super.key,
    required this.title1,
    required this.title2,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title1,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto-regular",
              color: AppColors.subtitleColor,
              fontWeight: FontWeight.w400),
        ),
        C5(),
        Text(
          title2,
          style: TextStyle(
              fontSize: 12,
              color: AppColors.black,
             fontFamily: "Roboto-regular",
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class SubtitleAndtitleText extends StatelessWidget {
  final String title1;
  final String title2;
  const SubtitleAndtitleText({
    super.key,
    required this.title1,
    required this.title2,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title2,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto-regular",
              color: AppColors.black,
              fontWeight: FontWeight.w700),
        ),
        C5(),
        Text(
          title1,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto-regular",
              color: AppColors.subtitleColor,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
