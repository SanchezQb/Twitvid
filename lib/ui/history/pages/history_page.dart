import 'package:Twitvid/constants/default_values.dart';
import 'package:Twitvid/ui/download/models/hive_video_data.dart';
import 'package:Twitvid/ui/widgets/native_ad_widget.dart';
import 'package:Twitvid/ui/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatelessWidget {
  final Box videosBox = Hive.box('videos');
  final _adController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: videosBox.listenable(),
        builder: (context, box, _) {
          if (videosBox.isEmpty) {
            return Center(
              child: Text(
                "You haven't downloaded any videos yet",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final video = videosBox.getAt(index) as HiveVideoData;
              if (index > 0 && index % 3 == 0) {
                return Column(
                  children: <Widget>[
                    VideoWidget(video),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      height: 300,
                      child: NativeAdWidget(
                        adController: _adController,
                        adMobType: NativeAdmobType.full,
                        adUnitID: kHistoryNative,
                      ),
                    ),
                  ],
                );
              }
              return VideoWidget(video);
            },
            itemCount: videosBox.length,
          );
        },
      ),
    );
  }
}
