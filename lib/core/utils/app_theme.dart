import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/fonts.gen.dart';
import '../../gen/locale_keys.g.dart';
import 'extensions.dart';

class AppThemes {
  static const mainColor = Color(0xffF7561E);
  static const blackColor = Color(0xff113342);
  static const greyColor = Color(0xffD2D2D2);
  static const secondaryColor = Color(0xffFB7135);

  static const whiteColor = Color(0xffFFFFFF);
  static const scaffoldBackgroundColor = Color(0xffEEEEEE);
  static const greenColor = Color(0xffFFBC0F);
  static const redColor = Color(0xffD00416);
  static const borderColor = Color(0xffE1E1E1);
  static const yellowColor = Color(0xffF5D441);

  static const primaryContainer = Color(0xffD2D2D2);
  static const secondaryContainer = Color(0xffF4FCFA);
  static const disabledColor = Color(0xffF1F1F1);
  static const focusColor = Color(0xffED7303);
  static const highlightColor = Color(0xff0B8AC1);

  static ThemeData get lightTheme => ThemeData(
        indicatorColor: greenColor,
        primaryColor: mainColor,
        focusColor: focusColor,
        highlightColor: highlightColor,
        splashColor: redColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: arabicTextTheme,
        hoverColor: borderColor,
        fontFamily: LocaleKeys.lang.tr() == 'en' ? FontFamily.poppins : FontFamily.iBMPlexSansArabic,
        hintColor: greyColor,
        primaryColorLight: Colors.white,
        primaryColorDark: blackColor,
        dialogTheme: DialogTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
        disabledColor: whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: secondaryColor,
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: whiteColor,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            fontFamily: LocaleKeys.lang.tr() == 'en' ? FontFamily.poppins : FontFamily.iBMPlexSansArabic,
            color: blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: whiteColor,
          selectedItemColor: mainColor,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: "#CBD1DB".color),
          unselectedItemColor: "#CBD1DB".color,
          enableFeedback: true,
        ),
        radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return mainColor;
          } else {
            return mainColor;
          }
        })),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: BorderSide.none,
          ),
          iconSize: 24.h,
          backgroundColor: mainColor,
          elevation: 1,
        ),
        colorScheme: const ColorScheme.light(
          primaryContainer: primaryContainer,
          secondary: secondaryColor,
          primary: mainColor,
          error: redColor,
        ),
        timePickerTheme: const TimePickerThemeData(
          elevation: 0,
          dialHandColor: mainColor,
          dialTextColor: Colors.black,
          backgroundColor: Colors.white,
          hourMinuteColor: whiteColor,
          dayPeriodTextColor: Colors.black,
          entryModeIconColor: Colors.transparent,
          dialBackgroundColor: whiteColor,
          hourMinuteTextColor: Colors.black,
          dayPeriodBorderSide: BorderSide(color: mainColor),
        ),
        dividerTheme: const DividerThemeData(color: borderColor),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: const TextStyle(color: blackColor, fontSize: 12, fontWeight: FontWeight.w500),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: primaryContainer,
            filled: true,
            hintStyle: const TextStyle(color: blackColor, fontSize: 12, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: LocaleKeys.lang.tr() == 'en' ? FontFamily.poppins : FontFamily.iBMPlexSansArabic,
              color: greyColor,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              fontSize: 12,
              fontFamily: LocaleKeys.lang.tr() == 'en' ? FontFamily.poppins : FontFamily.iBMPlexSansArabic,
              color: greyColor,
              fontWeight: FontWeight.w400),
          fillColor: whiteColor,
          filled: true,
          focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: secondaryColor), borderRadius: BorderRadius.circular(20.r)),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: redColor), borderRadius: BorderRadius.circular(20.r)),
          disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(20.r)),
          border: OutlineInputBorder(borderSide: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(20.r)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: secondaryColor), borderRadius: BorderRadius.circular(20.r)),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: borderColor), borderRadius: BorderRadius.circular(20.r)),
          contentPadding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          modalBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            borderSide: BorderSide.none,
          ),
        ),
      );

  static TextTheme get arabicTextTheme => const TextTheme(
        labelLarge: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w400),
        labelSmall: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w300),
      );
}
