import 'dart:convert';

class MModelSizes {
  final List<MModelSize> sizes;
  MModelSizes({this.sizes});
  factory MModelSizes.fromRawJson(dynamic str) =>
      MModelSizes.fromJson(str);
  factory MModelSizes.fromJson(dynamic json) => MModelSizes(
      sizes: List<MModelSize>.from(json.map((x) => MModelSize.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };
}

class MModelSize {
  final String size_id;
  final String size_name;
  MModelSize(
      {this.size_id,
      this.size_name});
  factory MModelSize.fromJson(Map<String, dynamic> json) => MModelSize(
        size_id: json["size_id"],
        size_name: json["size_name"],
      );
  Map<String, dynamic> toJson() => {
        "size_id": size_id,
        "size_name": size_name,
      };
}
