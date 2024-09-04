

import 'package:flutter/material.dart';

class AppTheme{

  static const Map<int, Color> palette = {
    50 : Color(0xffeffaff),
    100: Color(0xffdff3ff),
    200: Color(0xffb7eaff),
    300: Color(0xff77dbff),
    400: Color(0xff2ecaff),
    500: Color(0xff03b4f4),
    600: Color(0xff0090d1),
    700: Color(0xff0073a9),
    800: Color(0xff01618b),
    900: Color(0xff075073),
    950: Color(0xff032030),
  };

  static ThemeData light = ThemeData.light().copyWith(
    // colorScheme: ColorScheme(
    //   primary: palette[500]!,
    //   secondary: palette[500]!,
    //   surface: Colors.white,
    //   error: Colors.red,
    //   onPrimary: Colors.white,
    //   onSecondary: Colors.white,
    //   onSurface: Colors.black,
    //   onError: Colors.white,
    //   brightness: Brightness.light,
    // ),
    primaryColor: Colors.black87,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.black87,
      ),
      titleTextStyle: ThemeData.light().textTheme.titleLarge
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 10.0,
      backgroundColor: Colors.white,
      
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        fontSize: 96,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        fontSize: 60,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 48,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 34,
        letterSpacing: 0.25,
      ),
      headlineSmall: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 24,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        // color:Color(0xff263959),
        color: ThemeMode.dark == ThemeMode.dark ? Colors.white : Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        // color:Color(0xff263959),
        color: ThemeMode.dark == ThemeMode.dark ? Colors.white : Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      labelLarge: TextStyle(
        decorationColor: Colors.transparent,
        wordSpacing: 1.0,
        decorationThickness: 1.0,
        backgroundColor: Colors.transparent,
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 1.25,
      ),
      bodySmall: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        color:Color(0xff263959),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 10,
        letterSpacing: 0.4,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: palette[500],
      selectionColor: palette[500],
      selectionHandleColor: palette[300],
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: ThemeData().textTheme.bodyMedium?.copyWith(color: const Color(0xff263959), fontWeight: FontWeight.w200, fontSize: 14),
      hintStyle: ThemeData().textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w200, fontSize: 14),
      labelStyle: ThemeData().textTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder( 
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: palette[500]!,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      isDense: true
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateColor.transparent,
        backgroundColor: WidgetStateColor.resolveWith((states){
          if (states.contains(WidgetState.disabled)){
            return Colors.grey.shade300;
          }
          return palette[500]!;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        side: WidgetStatePropertyAll(BorderSide(color: AppTheme.palette[500]!)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateColor.transparent,
        foregroundColor: WidgetStateProperty.all<Color>(palette[500]!),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states){
        if (states.contains(WidgetState.selected)){
          return WidgetStateColor.resolveWith((states) => palette[500]!);
        }
        return WidgetStateColor.resolveWith((states) => Colors.white);
      }),
      checkColor: WidgetStateProperty.all<Color>(Colors.white),
      side: BorderSide(
        color: Colors.grey.shade400,
        width: 2.0
      )
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(
          minWidth: 20.0
        ),
      )
    ),
    listTileTheme: ListTileThemeData(
      style: ListTileStyle.list,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.grey,
          width: 1
        )
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: palette[500],
      labelStyle: const TextStyle(
        overflow: TextOverflow.ellipsis,
      ),
      tabAlignment: TabAlignment.start,
      splashFactory: NoSplash.splashFactory,
      dividerHeight: 1.0,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: palette[400]
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      titleTextStyle: ThemeData().textTheme.titleMedium,
      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.all(20.0),
      contentTextStyle: ThemeData().textTheme.bodyMedium,      
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states){
        if (states.contains(WidgetState.selected)){
          return palette[500]!;
        }
        return Colors.grey.shade400;
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: palette[500],
    ),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: palette[500]!,
      contentTextStyle: ThemeData().textTheme.bodyMedium,
      padding: const EdgeInsets.all(20.0),
      leadingPadding: const EdgeInsets.all(20.0),
    )
    
  );

  static ThemeData dark = ThemeData.dark().copyWith(

  );

}