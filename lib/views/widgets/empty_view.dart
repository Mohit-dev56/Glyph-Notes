import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../src/res/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset(AnimationAssets.empty, fit: BoxFit.cover)),
        Text(
          "Tap + to start",
          style: TextStyle(fontSize: 17, fontFamily: "Nothing"),
        )
      ],
    );
  }
}
