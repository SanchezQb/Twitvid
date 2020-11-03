import 'package:Twitvid/constants/app_theme.dart';
import 'package:Twitvid/ui/download/models/hive_video_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoWidget extends StatelessWidget {
  final HiveVideoData hiveVideoData;
  VideoWidget(this.hiveVideoData);

  final Box videosBox = Hive.box('videos');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: InkWell(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Image.network(
                      hiveVideoData.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      size: 60,
                      color: kPrimaryBlue,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        "/history-player-page",
                        arguments: hiveVideoData,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              hiveVideoData.type == "MP4" ? Feather.video : Icons.gif,
              color: kPrimaryBlue,
            ),
            title: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16),
                children: <InlineSpan>[
                  TextSpan(
                    text: hiveVideoData.dimensions,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Feather.twitter,
                    color: kPrimaryBlue,
                  ),
                  onPressed: () async {
                    final String url = hiveVideoData.url;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Feather.trash,
                    color: kErrorRed,
                  ),
                  onPressed: () {
                    videosBox.delete(hiveVideoData.id);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
