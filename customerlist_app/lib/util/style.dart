import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimensions {
  static double fontSizeExtraSmallSamll = 8;
  static double fontSizeExtraSmall = 17;
  static double fontSizeSmall = 12;
  static double fontSizeDefault = 14;
  static double fontSizeReasonHeading = 14;
  static double fontSizeReasonText = 12;
  static double fontSizeLarge = 16;
  static double fontSizeExtraLarge = 18;
  static double fontSizeExtraLarge22 = 22;
  static double fontSizeOverLarge = 26;
}

final fontSizeSmall = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeExtraSmall.sp,
);
final fontSizeSmallGray = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: Dimensions.fontSizeExtraSmall.sp,
);

final fontBoldWithColorBlack = TextStyle(
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.fontSizeExtraLarge.sp,
    color: Colors.grey.shade600);
final fontSizeExtraLarge22 = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeExtraLarge22.sp,
);
final fontBoldWithColorGrey = TextStyle(
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.fontSizeReasonHeading.sp,
    color: Colors.grey.shade900);
