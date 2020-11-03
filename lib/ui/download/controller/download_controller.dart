import 'dart:io' show Directory;
import 'dart:isolate';
import 'dart:ui';

import 'package:Twitvid/constants/default_values.dart';
import 'package:Twitvid/services/api_service.dart';
import 'package:Twitvid/ui/download/models/hive_video_data.dart';
import 'package:Twitvid/ui/download/models/video_data.dart';
import 'package:Twitvid/utils/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  ApiService _apiService = Get.put(ApiService());
  ReceivePort _receivePort = ReceivePort();

  final Box videosBox = Hive.box('videos');

  final isLoading = false.obs;
  final downloading = false.obs;

  final videoData = VideoData().obs;
  final _currentVideo = Video().obs;

  final progress = 0.obs;
  final fileName = "".obs;
  String _url = "";

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['twitter', 'video'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: kDownloadInterstitial,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  @override
  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      "Downloading",
    );

    _receivePort.listen((message) {
      updateProgress(message);
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('Downloading');
    super.onClose();
  }

  static downloadCallback(String id, DownloadTaskStatus status, int progress) {
    //Looking up send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("Downloading");
    //sending data
    sendPort.send([id, status, progress]);
  }

  void checkVideo(String url) {
    if (_url != url) {
      getVideo(url);
    } else {
      Get.toNamed("/video_page", arguments: videoData);
    }
  }

  getVideo(String url) async {
    isLoading.value = true;
    try {
      final VideoData videoData = await _apiService.getVideo(url: url);
      this.videoData.value = videoData;
      _url = url;
      isLoading.value = false;
      Get.toNamed("/video_page", arguments: videoData);
    } on DioError catch (e) {
      isLoading.value = false;
      if (e.response != null) {
        final msg = e.response.data["message"];
        SnackBar.showSnackbar("Error", msg);
      } else {
        SnackBar.showSnackbar("Error", e.message);
      }
    }
  }

  void saveToBox() {
    final HiveVideoData hiveVideo = HiveVideoData(
      dimensions: _currentVideo.value.dimensions,
      downloadUrl: _currentVideo.value.url,
      id: _currentVideo.value.id,
      url: _url,
      thumbnail: videoData.value.thumbnail,
      type: _currentVideo.value.type,
    );
    videosBox.put(_currentVideo.value.id, hiveVideo);
  }

  void setDownloading(bool value) {
    downloading.value = value;
  }

  void updateProgress(List<dynamic> message) {
    progress.value = message[2];
    if (message[1] == DownloadTaskStatus.complete) {
      SnackBar.showSnackbar(
        "Success",
        "Download Completed",
      );
      saveToBox();
      myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
      downloading.value = false;
    } else if (message[1] == DownloadTaskStatus.failed) {
      downloading.value = false;
      SnackBar.showSnackbar(
        "Error",
        "Download was unable to complete, check your internet connection",
      );
      myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
    } else if (message[1] == DownloadTaskStatus.paused) {
    } else if (message[1] == DownloadTaskStatus.canceled) {
      SnackBar.showSnackbar(
        "Error",
        "Download Canceled",
      );
      myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
      downloading.value = false;
    }
  }

  void cancelDownloadTask() {
    FlutterDownloader.cancelAll();
  }

  downloadFile(Video video) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var testdir = await new Directory('/storage/emulated/0/TwitVid')
          .create(recursive: true);

      // .showDialog(video);
      downloading.value = true;
      _currentVideo.value = video;
      fileName.value = "${video.id}.${video.type.toLowerCase()}";
      Get.back();
      FlutterDownloader.enqueue(
        url: video.url,
        savedDir: testdir.path,
        fileName: "${video.id}.${video.type.toLowerCase()}",
        showNotification: false,
        openFileFromNotification: true,
      );
    } else {
      //permission denied
    }
  }
}
