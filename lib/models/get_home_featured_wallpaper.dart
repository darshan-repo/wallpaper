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

  // List<CategoryData>? categoryDatas;

  Category({
    this.id,
    this.name,
    this.background,
    this.createdAt,
    this.updatedAt,
    // this.categoryDatas,
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
        // categoryDatas: json["categoryDatas"] == null
        //     ? []
        //     : List<CategoryData>.from(
        //         json["categoryDatas"]!.map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "background": background,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        // "categoryDatas": categoryDatas == null
        //     ? []
        //     : List<dynamic>.from(categoryDatas!.map((x) => x.toJson())),
      };
}
//
// class CategoryData {
//   String? id;
//   String? categoryId;
//   String? name;
//   String? category;
//   String? wallpaper;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   CategoryData({
//     this.id,
//     this.categoryId,
//     this.name,
//     this.category,
//     this.wallpaper,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
//         id: json["id"],
//         categoryId: json["categoryId"],
//         name: json["name"],
//         category: json["category"],
//         wallpaper: json["wallpaper"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "categoryId": categoryId,
//         "name": name,
//         "category": category,
//         "wallpaper": wallpaper,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }
