
class MVideos {
  final List<MVideo> videos;
  MVideos({this.videos});
  factory MVideos.fromRawJson(dynamic str) =>
      MVideos.fromJson(str);
  factory MVideos.fromJson(dynamic json) => MVideos(
      videos: List<MVideo>.from(json.map((x) => MVideo.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class MVideo {
  final String id;
  final String name;
  final String path;
  final String thumbnail;
  MVideo(
      {this.id,
      this.name,
      this.path,
      this.thumbnail});
  factory MVideo.fromJson(Map<String, dynamic> json) => MVideo(
        id: json["video_id"],
        name: json["video_name"],
        path: json["video_path"],
        thumbnail: json["video_thumbnail"]
      );
  Map<String, dynamic> toJson() => {
        "video_id": id,
        "video_name": name,
        "video_path": path,
        "video_thumbnail": thumbnail
      };
}
