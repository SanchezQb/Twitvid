import 'package:Twitvid/constants/app_theme.dart';
import 'package:Twitvid/ui/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final _settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: TextStyle(
                      color: kPrimaryBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () => _settingsController.showClearHistoryDialog(),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Feather.database),
                    title: Text(
                      "Clear History",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Videos will not be deleted from your internal storage",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TwitVid",
                    style: TextStyle(
                      color: kPrimaryBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Feather.code),
                    title: Text(
                      "Version",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "1.0.0",
                    ),
                  ),
                  ListTile(
                    onTap: () => _settingsController.sendFeedback(),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Feather.message_square),
                    title: Text(
                      "Send Feedback",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Got questions? Email us"),
                  ),
                  ListTile(
                    onTap: () => _settingsController.shareApp(),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Feather.share_2),
                    title: Text(
                      "Share",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Share the app with your friends"),
                  ),
                  ListTile(
                    onTap: () => _settingsController.rateApp(),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Feather.star),
                    title: Text(
                      "Rate the App",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Like the app? Tell us what you think"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
