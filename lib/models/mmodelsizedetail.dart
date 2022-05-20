import 'dart:convert';

class MModelSizeDetails {
  final List<MModelSizeDetail> details;
  MModelSizeDetails({this.details});
  factory MModelSizeDetails.fromRawJson(dynamic str) =>
      MModelSizeDetails.fromJson(str);
  factory MModelSizeDetails.fromJson(dynamic json) => MModelSizeDetails(
      details: List<MModelSizeDetail>.from(json.map((x) => MModelSizeDetail.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class MModelSizeDetail {
  final String dimension_id;
  final String dimension_name;
  final String dimension_value;
  MModelSizeDetail(
      {this.dimension_id,
      this.dimension_name,
      this.dimension_value});
  factory MModelSizeDetail.fromJson(Map<String, dynamic> json) => MModelSizeDetail(
        dimension_id: json["dimension_id"],
        dimension_name: json["dimension_name"],
        dimension_value: json["dimension_value"],
      );
  Map<String, dynamic> toJson() => {
        "dimension_id": dimension_id,
        "dimension_name": dimension_name,
        "dimension_value": dimension_value,
      };
}
