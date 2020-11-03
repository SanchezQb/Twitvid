import 'package:Twitvid/constants/app_theme.dart';
import 'package:Twitvid/ui/download/models/hive_video_data.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'constants/default_values.dart';
import 'routes.dart';
import 'ui/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: false,
  );
  await Hive.initFlutter();
  Hive.registerAdapter<HiveVideoData>(HiveVideoDataAdapter());
  await Hive.openBox('videos');
  FirebaseAdMob.instance.initialize(
    appId: kAppId,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      title: 'Twitvid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: kButtonThemeLight,
        inputDecorationTheme: kInputThemeLight,
        accentColor: Color(0xFF397AC1),
        appBarTheme: kAppBarThemeLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.tajawalTextTheme(
          Theme.of(context).textTheme.copyWith(),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        buttonColor: Color(0xFF397AC1),
        accentColor: Color(0xFF397AC1),
        inputDecorationTheme: kInputThemeDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.tajawalTextTheme(
          Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey),
                subtitle1: TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: HomePage(),
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
