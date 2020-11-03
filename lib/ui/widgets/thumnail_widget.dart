import 'package:Twitvid/constants/app_theme.dart';
import 'package:Twitvid/ui/download/models/video_data.dart';
import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({
    Key key,
    @required this.videoData,
  }) : super(key: key);

  final VideoData videoData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      height: 300,
      child: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              videoData.thumbnail,
              fit: BoxFit.cover,
            ),
            IconButton(
              icon: Icon(
                Icons.play_circle_outline,
                size: 60,
                color: kPrimaryBlue,
              ),
              onPressed: () {
                if (videoData.videos[0].type.toLowerCase() == "gif") {
                  print("Hello");
                  Navigator.of(context).pushNamed(
                    '/gif-player-page',
                    arguments: videoData,
                  );
                } else {
                  Navigator.of(context).pushNamed(
                    "/video_player_page",
                    arguments: videoData,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
