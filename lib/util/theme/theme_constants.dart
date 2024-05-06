import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
        primary: Color(0xFF0345ca),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF535f70),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFba1b1b),
        onError: Color(0xFFFFFFFF),
        background: Color(0xFFfdfcff),
        onBackground: Color(0xFF1b1b1b),
        surface: Color(0xFFfdfcff),
        onSurface: Color(0xFF1b1b1b),
        surfaceVariant: Color(0xFFdfe2eb),
        onSurfaceVariant: Color(0xFF42474e),
        brightness: Brightness.light
    )
);

ThemeData darkTheme =
    ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
            primary: Color(0xFF3c4858),
            onPrimary: Color(0xFFFFFFFF),
            secondary: Color(0xFFbbc8db),
            onSecondary: Color(0xFF1b1b1b),
            error: Color(0xFFffb4a9),
            onError: Color(0xFF680003),
            background: Color(0xFF1b1b1b),
            onBackground: Color(0xFFe2e2e6),
            surface: Color(0xFF1b1b1b),
            onSurface: Color(0xFFe2e2e6),
            surfaceVariant: Color(0xff2d3034),
            onSurfaceVariant: Color(0xff56595e),
            brightness: Brightness.dark
        )
    );

const colorError = Color(0xffb94e4e);
const colorSuccess = Color(0xff499865);
const colorInfo = Color(0xff5c89b6);
const colorWarning = Color(0xffb2a065);