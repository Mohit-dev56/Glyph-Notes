import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:note_bucket/views/home.dart';
import 'package:note_bucket/src/res/strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: lightDynamic,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          title: AppStrings.appName,
          home: HomeView(),
        );
      },
    );
  }
}
