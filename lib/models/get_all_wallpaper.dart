import 'dart:convert';

AllWallpaperModel allWallpaperModelFromJson(String str) =>
    AllWallpaperModel.fromJson(json.decode(str));

String allWallpaperModelToJson(AllWallpaperModel data) =>
    json.encode(data.toJson());

class AllWallpaperModel {
  String? message;
  List<Wallpaper>? wallpapers;
  int? currentPage;
  int? totalPages;

  AllWallpaperModel({
    this.message,
    this.wallpapers,
    this.currentPage,
    this.totalPages,
  });

  factory AllWallpaperModel.fromJson(Map<String, dynamic> json) =>
      AllWallpaperModel(
        message: json["message"],
        wallpapers: json["wallpapers"] == null
            ? []
            : List<Wallpaper>.from(
                json["wallpapers"]!.map((x) => Wallpaper.fromJson(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "wallpapers": wallpapers == null
            ? []
            : List<dynamic>.from(wallpapers!.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalPages": totalPages,
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
  int? likesCount;

  Wallpaper({
    this.id,
    this.categoryId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
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
        likesCount: json["likesCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "category": category,
        "wallpaper": wallpaper,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "likesCount": likesCount,
      };
}
