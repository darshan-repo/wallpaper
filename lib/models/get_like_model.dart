import 'dart:convert';

SendLikeModel sendlikeModelFromJson(String str) =>
    SendLikeModel.fromJson(json.decode(str));

String sendlikeModelToJson(SendLikeModel data) => json.encode(data.toJson());

class SendLikeModel {
  String? userId;
  String? name;
  String? category;
  String? wallpaper;

  SendLikeModel({
    this.userId,
    this.name,
    this.category,
    this.wallpaper,
  });

  factory SendLikeModel.fromJson(Map<String, dynamic> json) => SendLikeModel(
        userId: json["userId"],
        name: json["name"],
        category: json["category"],
        wallpaper: json["wallpaper"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "category": category,
        "wallpaper": wallpaper,
      };
}

GetLikeModel getLikeModelFromJson(String str) =>
    GetLikeModel.fromJson(json.decode(str));

String getLikeModelToJson(GetLikeModel data) => json.encode(data.toJson());

class GetLikeModel {
  String? message;
  List<LikesDatum>? likesData;

  GetLikeModel({
    this.message,
    this.likesData,
  });

  factory GetLikeModel.fromJson(Map<String, dynamic> json) => GetLikeModel(
        message: json["message"],
        likesData: json["likesData"] == null
            ? []
            : List<LikesDatum>.from(
                json["likesData"]!.map((x) => LikesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "likesData": likesData == null
            ? []
            : List<dynamic>.from(likesData!.map((x) => x.toJson())),
      };
}

class LikesDatum {
  String? id;
  String? wallpaperId;
  String? userId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  LikesDatum({
    this.id,
    this.wallpaperId,
    this.userId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory LikesDatum.fromJson(Map<String, dynamic> json) => LikesDatum(
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
