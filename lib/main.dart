import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/repository/themes.dart';
import 'package:t4f_challenge_app/view/screen/home_screen.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: appLightTheme,
      builder: (context, theme) => MaterialApp(
        home: const HomeScreen(),
        scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        }),
        theme: theme,
      ),
    );
  }
}
