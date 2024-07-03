import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';

Container buildBackgroundContainer() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          blueColor,
          blackColor,
        ],
      ),
    ),
  );
}

Container buildBackgroundContainerBrighter() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          blueColor,
          blueColor,
          blackColor,
        ],
        stops: [0.0, 0.7, 1.0]
      ),
    ),
  );
}

Container blueBackground() {
  return Container(
    decoration: const BoxDecoration(
      color: blueColor,
    ),
  );
}