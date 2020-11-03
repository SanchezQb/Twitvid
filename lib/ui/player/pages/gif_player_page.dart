import 'package:Twitvid/ui/download/models/video_data.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class GifPlayerPage extends StatefulWidget {
  final VideoData videoData;
  GifPlayerPage(this.videoData);
  @override
  _GifPlayerPageState createState() => _GifPlayerPageState();
}

class _GifPlayerPageState extends State<GifPlayerPage> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    final video = widget.videoData.videos[0];
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.NETWORK,
      video.url,
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 1,
        fit: BoxFit.fitWidth,
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
      body: Container(
        constraints: BoxConstraints.expand(),
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
    );
  }
}
