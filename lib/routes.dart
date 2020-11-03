import 'package:Twitvid/ui/download/pages/video_page.dart';
import 'package:Twitvid/ui/player/pages/history_player_page.dart';
import 'package:flutter/material.dart';

import 'ui/download/models/hive_video_data.dart';
import 'ui/download/models/video_data.dart';
import 'ui/home/home_page.dart';
import 'ui/player/pages/gif_player_page.dart';
import 'ui/player/pages/video_player_page.dart';
import 'ui/settings/settings_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/home_page":
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => HomePage(),
        );
      case "/video_page":
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => VideoPage(),
        );
      case "/settings_page":
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => SettingsPage(),
        );
      case "/video_player_page":
        final VideoData videoData = settings.arguments;
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => VideoPlayerPage(videoData),
        );
      case "/gif-player-page":
        final VideoData videoData = settings.arguments;
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => GifPlayerPage(videoData),
        );
      case "/history-player-page":
        final HiveVideoData hiveVideoData = settings.arguments;
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => HistoryPlayerPage(hiveVideoData),
        );
      default:
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => Container(),
        );
    }
  }
}
