import 'package:flutter/material.dart';

// global
class AppColor {
  static const Color globalBackground = Color(0xFFF7FAFF);
  static const Color blue = Color(0xFF2961FD);
}

// Summary Containers
class AppLinearGradientColor {
  static const LinearGradient linearGradientBlue = LinearGradient(
    colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
  );
  static const LinearGradient linearGradientPink = LinearGradient(
    colors: [Color(0xFFFBE8F4), Color(0xFFFFCEE6)],
  );
  static const LinearGradient linearGradientYellow = LinearGradient(
    colors: [Color(0xFFFFF7D6), Color(0xFFFDEE97)],
  );
  static const LinearGradient linearGradientOrange = LinearGradient(
    colors: [Color(0xFFFBE7D1), Color(0xFFFBB790)],
  );
  static const LinearGradient linearGradientTiffany = LinearGradient(
    colors: [Color(0xE1D1FBFB), Color(0xE147E5EA)],
  );
}

// invoice container
class AppPaymentStateColor{
  static const Color unpaidColor = Color(0xFFFFCEE6);
  static const Color paidColor = Color(0xE147E5EA);
  static const Color overdueColor = Color(0xFFFBB790);
  static const Color partiallyColor = Color(0xFFFDEE97);
}

// Filter Containers
class AppContainerColor {
  static const Color filterUnselected = Color(0xFFF6E8FB);
  static const Color filterSelected = Color(0xFF3D5AFE);
}
