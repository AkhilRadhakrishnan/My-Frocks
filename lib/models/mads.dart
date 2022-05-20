class MADs {
  final List<MAD> ads;
  MADs({this.ads});
  factory MADs.fromRawJson(dynamic str) =>
      MADs.fromJson(str);
  factory MADs.fromJson(dynamic json) => MADs(
      ads: List<MAD>.from(json.map((x) => MAD.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(ads.map((x) => x.toJson())),
      };
}
class MAD {
  final String id;
  final String thumbnail;
  MAD({this.id,
      this.thumbnail,});
  factory MAD.fromJson(Map<String, dynamic> json) => MAD(
        id: json["image_id"],
        thumbnail: json["thumbnail_path"],
      );
  Map<String, dynamic> toJson() => {
        "image_id": id,
        "thumbnail_path": thumbnail,
      };
}
