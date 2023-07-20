// ignore_for_file: constant_identifier_names

import 'package:walper/libs.dart';

enum PaddingType { left, right, top, bottom, horizontal, vertical, all, LTRB }

enum MarginType { left, right, top, bottom, horizontal, vertical, all, LTRB }

EdgeInsetsGeometry padding({
  required PaddingType paddingType,
  double paddingValue = 0,
  double left = 0,
  double top = 0,
  double right = 0,
  double bottom = 0,
}) {
  switch (paddingType) {
    case PaddingType.left:
      return EdgeInsets.only(left: paddingValue);
    case PaddingType.right:
      return EdgeInsets.only(right: paddingValue);
    case PaddingType.top:
      return EdgeInsets.only(top: paddingValue);
    case PaddingType.bottom:
      return EdgeInsets.only(bottom: paddingValue);
    case PaddingType.vertical:
      return EdgeInsets.symmetric(vertical: paddingValue);
    case PaddingType.horizontal:
      return EdgeInsets.symmetric(horizontal: paddingValue);
    case PaddingType.all:
      return EdgeInsets.all(paddingValue);
    case PaddingType.LTRB:
      return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}

EdgeInsetsGeometry margin({
  required MarginType marginType,
  double marginValue = 0,
  double left = 0,
  double top = 0,
  double right = 0,
  double bottom = 0,
}) {
  switch (marginType) {
    case MarginType.left:
      return EdgeInsets.only(left: marginValue);
    case MarginType.right:
      return EdgeInsets.only(right: marginValue);
    case MarginType.top:
      return EdgeInsets.only(top: marginValue);
    case MarginType.bottom:
      return EdgeInsets.only(bottom: marginValue);
    case MarginType.vertical:
      return EdgeInsets.symmetric(vertical: marginValue);
    case MarginType.horizontal:
      return EdgeInsets.symmetric(horizontal: marginValue);
    case MarginType.all:
      return EdgeInsets.all(marginValue);
    case MarginType.LTRB:
      return EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}

SizedBox horizontalSpace(double value) => SizedBox(
      width: value,
    );

SizedBox verticalSpace(double value) => SizedBox(
      height: value,
    );
