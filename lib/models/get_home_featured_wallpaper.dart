import 'dart:convert';

GetFeaturedWallpaperModel getFeaturedWallpaperModelFromJson(String str) =>
    GetFeaturedWallpaperModel.fromJson(json.decode(str));

String getFeaturedWallpaperModelToJson(GetFeaturedWallpaperModel data) =>
    json.encode(data.toJson());

class GetFeaturedWallpaperModel {
  String? message;
  List<Category>? categories;

  GetFeaturedWallpaperModel({
    this.message,
    this.categories,
  });

  factory GetFeaturedWallpaperModel.fromJson(Map<String, dynamic> json) =>
      GetFeaturedWallpaperModel(
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
  String? background;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.background,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        background: json["background"],
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
        "background": background,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
