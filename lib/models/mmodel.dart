class MModels {
  final List<MModel> models;
  MModels({this.models});
  factory MModels.fromRawJson(dynamic str) =>
    MModels.fromJson(str);
  factory MModels.fromJson(dynamic json) => MModels(
      models: List<MModel>.from(json.map((x) => MModel.fromJson(x))));
  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(models.map((x) => x.toJson())),  
  };
}
class MModel {
  final String id;
  final String name;
  final String thumbnail;
  MModel({
    this.id,
    this.name,
    this.thumbnail});
  factory MModel.fromJson(Map<String, dynamic> json) => MModel(
    id: json["model_id"],
    name: json["model_name"],
    thumbnail: json["thumbnail_path"],
  );
  Map<String, dynamic> toJson() => {
    "model_id": id,
    "model_name": name,
    "thumbnail_path": thumbnail,
  };
}
