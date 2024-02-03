import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

inputDecorations(context) => InputDecorationTheme(
      focusColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3.w),
        borderSide: BorderSide.none,
      ),
      suffixIconColor: Colors.white,
      filled: true,
      fillColor: Colors.black.withAlpha(50),
    );

textStyle(BuildContext context) => const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        color: Colors.white,
      ),
    );

elevatedButtonTheme(BuildContext context) => ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.secondary,
        ),
        foregroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
        ),
      ),
    );
