import 'package:Twitvid/constants/app_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class SnackBar {
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      barBlur: 20,
      borderRadius: 7.0,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: title == "Success" ? kGreen : kErrorRed,
      isDismissible: true,
      duration: Duration(seconds: 3),
      colorText: Color(0xFFFFFFFF),
    );
  }
}
