import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) =>
    GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) =>
    json.encode(data.toJson());

class GetNotificationModel {
  String? message;
  List<NotificationDatum>? notificationData;

  GetNotificationModel({
    this.message,
    this.notificationData,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) =>
      GetNotificationModel(
        message: json["message"],
        notificationData: json["notification_data"] == null
            ? []
            : List<NotificationDatum>.from(json["notification_data"]!
                .map((x) => NotificationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "notification_data": notificationData == null
            ? []
            : List<dynamic>.from(notificationData!.map((x) => x.toJson())),
      };
}

class NotificationDatum {
  String? id;
  String? title;
  String? wallpaper;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationDatum({
    this.id,
    this.title,
    this.wallpaper,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["id"],
        title: json["title"],
        wallpaper: json["wallpaper"],
        message: json["message"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "wallpaper": wallpaper,
        "message": message,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
