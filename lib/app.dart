import 'package:flutter/material.dart';
import 'package:note_bucket/views/home.dart';
import 'package:note_bucket/src/res/strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: AppStrings.appName,
      home: HomeView(),
    );
  }
}
