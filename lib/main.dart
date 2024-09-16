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
    return MaterialApp(
      home: const HomeScreen(),
      theme: context.watch<HomeViewModel>().theme.value,
    );
  }
}
