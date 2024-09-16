import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/main.dart';
import 'package:t4f_challenge_app/repository/themes.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _vm = context.watch<HomeViewModel>(); //Store view model to variable to be easier to type
    return Scaffold(
      appBar: AppBar(
        title: const Text('T4F.ir Challenge App'),
        centerTitle: true,
        leading: InkResponse(
          onTap: () {
            _vm.toggleTheme();
          },
          child: _vm.theme.value == appLightTheme
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.dark_mode),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      body: const Center(
        child: Text('Hello world!'),
      ),
    );
  }
}
