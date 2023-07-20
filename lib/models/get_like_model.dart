import 'dart:convert';

GetLikeModel getLikeModelFromJson(String str) =>
    GetLikeModel.fromJson(json.decode(str));

String getLikeModelToJson(GetLikeModel data) => json.encode(data.toJson());

class GetLikeModel {
  String? message;
  List<Likes>? likesData;

  GetLikeModel({
    this.message,
    this.likesData,
  });

  factory GetLikeModel.fromJson(Map<String, dynamic> json) => GetLikeModel(
        message: json["message"],
        likesData: json["likesData"] == null
            ? []
            : List<Likes>.from(
                json["likesData"]!.map((x) => Likes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "likesData": likesData == null
            ? []
            : List<dynamic>.from(likesData!.map((x) => x.toJson())),
      };
}

class Likes {
  String? id;
  String? wallpaperId;
  String? userId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  Likes({
    this.id,
    this.wallpaperId,
    this.userId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        id: json["id"],
        wallpaperId: json["wallpaperId"],
        userId: json["userId"],
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
        "wallpaperId": wallpaperId,
        "userId": userId,
        "name": name,
        "category": category,
        "wallpaper": wallpaper,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
