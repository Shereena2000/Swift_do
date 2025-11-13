import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottie extends StatelessWidget {
  const AppLottie();

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieBuilder.asset("assets/lottie.json"));
  }
}