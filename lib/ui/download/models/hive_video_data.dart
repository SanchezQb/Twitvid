import 'package:hive/hive.dart';

part 'hive_video_data.g.dart';

@HiveType(typeId: 0)
class HiveVideoData extends HiveObject {
  @HiveField(0)
  String url;

  @HiveField(1)
  String thumbnail;

  @HiveField(2)
  String dimensions;

  @HiveField(3)
  String id;

  @HiveField(4)
  String type;

  @HiveField(5)
  String downloadUrl;

  HiveVideoData({
    this.id,
    this.url,
    this.dimensions,
    this.type,
    this.thumbnail,
    this.downloadUrl,
  });
}
