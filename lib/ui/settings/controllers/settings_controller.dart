import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class SettingsController extends GetxController {
  void sendFeedback() async {
    const url = "mailto:spectrumsixdigital@gmail.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareApp() {
    Share.share(
      'https://play.google.com/store/apps/details?id=com.spectrumsixdigital.Twitvid',
      subject: 'Download videos from twitter with this app',
    );
  }

  void rateApp() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.spectrumsixdigital.Twitvid";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void clearHistory() {
    final Box videosBox = Hive.box('videos');
    videosBox.clear();
    Get.back();
  }

  void showClearHistoryDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Clear History",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text("Are you sure you want to clear history?"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "No",
            ),
            onPressed: () {
              Get.back();
            },
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              clearHistory();
            },
          ),
        ],
      ),
    );
  }
}
