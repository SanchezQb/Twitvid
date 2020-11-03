import 'package:Twitvid/constants/default_values.dart';
import 'package:Twitvid/ui/download/models/video_data.dart';
import 'package:Twitvid/utils/format_bytes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static BaseOptions options = new BaseOptions(
    baseUrl: kBaseUrl,
  );
  Dio dio = new Dio(options);

  Future<VideoData> getVideo({@required String url}) async {
    Response response = await dio.get("$kBaseUrl/video?url=$url");
    final payload = response.data;
    final data = VideoData.fromJson(payload);
    return data;
  }

  Future<String> getFileSize({@required String url}) async {
    Response response = await dio.head(url);
    final payload = response.headers['content-length'][0];
    final sizeInBytes = int.parse(payload);
    final sizeInString = formatBytes(sizeInBytes, 2);
    return sizeInString;
  }
}
