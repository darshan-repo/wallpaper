import 'dart:convert';

SendDownloadModel sendDownloadModelFromJson(String str) =>
    SendDownloadModel.fromJson(json.decode(str));

String sendDownloadModelToJson(SendDownloadModel data) =>
    json.encode(data.toJson());

class SendDownloadModel {
  String? userId;
  String? name;
  String? category;
  String? wallpaper;

  SendDownloadModel({
    this.userId,
    this.name,
    this.category,
    this.wallpaper,
  });

  factory SendDownloadModel.fromJson(Map<String, dynamic> json) =>
      SendDownloadModel(
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

GetDownloadModel getDownloadModelFromJson(String str) =>
    GetDownloadModel.fromJson(json.decode(str));

String getDownloadModelToJson(GetDownloadModel data) =>
    json.encode(data.toJson());

class GetDownloadModel {
  String? message;
  List<DownloadDatum>? downloadData;

  GetDownloadModel({
    this.message,
    this.downloadData,
  });

  factory GetDownloadModel.fromJson(Map<String, dynamic> json) =>
      GetDownloadModel(
        message: json["message"],
        downloadData: json["downloadData"] == null
            ? []
            : List<DownloadDatum>.from(
                json["downloadData"]!.map((x) => DownloadDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "downloadData": downloadData == null
            ? []
            : List<dynamic>.from(downloadData!.map((x) => x.toJson())),
      };
}

class DownloadDatum {
  String? id;
  String? wallpaperId;
  String? userId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  DownloadDatum({
    this.id,
    this.wallpaperId,
    this.userId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory DownloadDatum.fromJson(Map<String, dynamic> json) => DownloadDatum(
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
