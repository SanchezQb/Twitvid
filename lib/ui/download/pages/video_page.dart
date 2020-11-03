import 'package:Twitvid/constants/default_values.dart';
import 'package:Twitvid/services/api_service.dart';
import 'package:Twitvid/ui/download/models/video_data.dart';
import 'package:Twitvid/ui/widgets/native_ad_widget.dart';
import 'package:Twitvid/ui/widgets/thumnail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:Twitvid/ui/download/controller/download_controller.dart';

class VideoPage extends StatelessWidget {
  final DownloadController _downloadController = Get.find();
  final ApiService _apiService = Get.put(ApiService());
  final _controller = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Obx(
            () => ThumbnailWidget(
              videoData: _downloadController.videoData.value,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _downloadController.videoData.value.videos.length,
              itemBuilder: (BuildContext context, int index) {
                final Video video =
                    _downloadController.videoData.value.videos[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      _downloadController.downloadFile(video);
                    },
                    leading: Icon(
                      video.type == "MP4" ? Feather.video : Icons.gif,
                    ),
                    title: Text(video.dimensions),
                    trailing: FutureBuilder(
                      future: _apiService.getFileSize(url: video.url),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var connectionState = snapshot.connectionState;
                        if (connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(
                              "0B",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            );
                          }
                          return Text(
                            snapshot.data,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          );
                        } else {
                          return Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 100,
              child: NativeAdWidget(
                adController: _controller,
                adMobType: NativeAdmobType.banner,
                adUnitID: kVideoNative,
              ),
            ),
          )
        ],
      ),
    );
  }
}
