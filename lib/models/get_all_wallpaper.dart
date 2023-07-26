import 'dart:convert';

GetAllWallpaperModel getAllWallpaperModelFromJson(String str) =>
    GetAllWallpaperModel.fromJson(json.decode(str));

String getAllWallpaperModelToJson(GetAllWallpaperModel data) =>
    json.encode(data.toJson());

class GetAllWallpaperModel {
  String? message;
  List<Wallpaper>? wallpapers;

  GetAllWallpaperModel({
    this.message,
    this.wallpapers,
  });

  factory GetAllWallpaperModel.fromJson(Map<String, dynamic> json) =>
      GetAllWallpaperModel(
        message: json["message"],
        wallpapers: json["wallpapers"] == null
            ? []
            : List<Wallpaper>.from(
                json["wallpapers"]!.map((x) => Wallpaper.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "wallpapers": wallpapers == null
            ? []
            : List<dynamic>.from(wallpapers!.map((x) => x.toJson())),
      };
}

class Wallpaper {
  String? id;
  String? categoryId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  Wallpaper({
    this.id,
    this.categoryId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
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
