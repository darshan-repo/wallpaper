import 'dart:convert';

GetWallpaperModel getWallpaperModelFromJson(String str) =>
    GetWallpaperModel.fromJson(json.decode(str));

String getWallpaperModelToJson(GetWallpaperModel data) =>
    json.encode(data.toJson());

class GetWallpaperModel {
  String? message;
  List<Category>? categories;

  GetWallpaperModel({
    this.message,
    this.categories,
  });

  factory GetWallpaperModel.fromJson(Map<String, dynamic> json) =>
      GetWallpaperModel(
        message: json["message"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
