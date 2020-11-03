class VideoData {
  String thumbnail;
  List<Video> videos;

  VideoData({this.thumbnail, this.videos});

  VideoData.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    if (json['videos'] != null) {
      videos = new List<Video>();
      json['videos'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  String id;
  String url;
  String dimensions;
  String type;

  Video({this.id, this.url, this.dimensions, this.type});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    dimensions = json['dimensions'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['dimensions'] = this.dimensions;
    data['type'] = this.type;
    return data;
  }
}
