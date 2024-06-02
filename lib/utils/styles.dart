import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

const primaryColor = Color(0xFF032F2F);
const primaryColorLight = Color(0xFFE3F2FD);
const secondaryColor = Color(0xFFEF6538);
const secondaryColorLight = Color(0xFFFFE0B2);

class CustomStyles {
  final BuildContext context;
  CustomStyles({
    required this.context,
  });
  TextStyle textStyle(
      {double mobile = 16,
      double tablet = 16,
      double desktop = 16,
      double largeDesktop = 15,
      Color? color,
      FontWeight? fontWeight,
      String fontFamily = 'OpenSans',
      double? height,
      double? wordSpacing,
      double? letterSpacing,
      TextDecoration? decoration}) {
    return TextStyle(
        fontSize: ResponsiveValue<double>(context,
            defaultValue: mobile,
            conditionalValues: [
              Condition.equals(name: MOBILE, value: mobile),
              Condition.equals(name: TABLET, value: tablet),
              Condition.equals(name: DESKTOP, value: desktop),
              Condition.equals(name: '4K', value: largeDesktop),
            ]).value,
        color: color,
        fontWeight: fontWeight,
        height: height,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        decoration: decoration);
  }
}
