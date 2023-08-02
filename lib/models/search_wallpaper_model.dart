import 'dart:convert';

SearchWallpaperModel searchWallpaperModelFromJson(String str) =>
    SearchWallpaperModel.fromJson(json.decode(str));

String searchWallpaperModelToJson(SearchWallpaperModel data) =>
    json.encode(data.toJson());

class SearchWallpaperModel {
  String? message;
  List<WallpaperList>? wallpaperList;

  SearchWallpaperModel({
    this.message,
    this.wallpaperList,
  });

  factory SearchWallpaperModel.fromJson(Map<String, dynamic> json) =>
      SearchWallpaperModel(
        message: json["message"],
        wallpaperList: json["wallpaperList"] == null
            ? []
            : List<WallpaperList>.from(
                json["wallpaperList"]!.map((x) => WallpaperList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "wallpaperList": wallpaperList == null
            ? []
            : List<dynamic>.from(wallpaperList!.map((x) => x.toJson())),
      };
}

class WallpaperList {
  String? id;
  String? categoryId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  WallpaperList({
    this.id,
    this.categoryId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory WallpaperList.fromJson(Map<String, dynamic> json) => WallpaperList(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        category: json["category"],
        wallpaper: json["wallpaper"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "category": category,
        "wallpaper": wallpaper,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
