import 'package:flutter/material.dart';
import 'package:note_bucket/views/home.dart';
import 'package:note_bucket/src/res/strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

