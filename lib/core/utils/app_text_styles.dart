// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

import 'app_colors.dart'; // Import this for TextStyle

abstract class AppTextStyle {
  static final Kanit500style32White = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w500,
    fontSize: 32,
    color: AppColors.whiteColor,
  );

  static final Kanit400style16White = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.whiteColor,
  );

  static final Kanit500style18Black = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.blackColor,
  );

  static final Kanit600style14White = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.whiteColor,
  );

  static final Kanit400style14primary = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.primaryColor,
  );

  static final Kanit700style16Black = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static final Kanit500style16LighterGrey = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.lighterGrey,
  );

  static final Kanit400style12Grey = const TextStyle(
    fontFamily: 'Kanit',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greyColor,
  );
}
