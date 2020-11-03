import 'package:Twitvid/ui/download/models/hive_video_data.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class HistoryPlayerPage extends StatefulWidget {
  final HiveVideoData hiveVideoData;
  HistoryPlayerPage(this.hiveVideoData);
  @override
  _HistoryPlayerPageState createState() => _HistoryPlayerPageState();
}

class _HistoryPlayerPageState extends State<HistoryPlayerPage> {
  BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    final video = widget.hiveVideoData;
    final width = int.parse(video.dimensions.split("x")[0]);
    final height = int.parse(video.dimensions.split("x")[1]);
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.NETWORK,
      video.downloadUrl,
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: width / height,
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
    );
  }
}
