import 'dart:convert';

class MTips {
  final List<MTip> tips;
  MTips({this.tips});
  factory MTips.fromRawJson(dynamic str) =>
      MTips.fromJson(str);
  factory MTips.fromJson(dynamic json) => MTips(
      tips: List<MTip>.from(json.map((x) => MTip.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(tips.map((x) => x.toJson())),
      };
}

class MTip {
  final String tip_id;
  final String tip_description;
  MTip({this.tip_id,
      this.tip_description,});
  factory MTip.fromJson(Map<String, dynamic> json) => MTip(
        tip_id: json["tip_id"],
        tip_description: json["tip_description"],
      );
  Map<String, dynamic> toJson() => {
        "tip_id": tip_id,
        "tip_description": tip_description,
      };
}
