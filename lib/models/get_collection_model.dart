import 'dart:convert';

GetCollectionModel getCollectionModelFromJson(String str) =>
    GetCollectionModel.fromJson(json.decode(str));

String getCollectionModelToJson(GetCollectionModel data) =>
    json.encode(data.toJson());

class GetCollectionModel {
  String? message;
  List<Collection>? data;

  GetCollectionModel({
    this.message,
    this.data,
  });

  factory GetCollectionModel.fromJson(Map<String, dynamic> json) =>
      GetCollectionModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Collection>.from(
                json["data"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Collection {
  String? id;
  String? categoryId;
  String? name;
  String? category;
  String? wallpaper;
  DateTime? createdAt;
  DateTime? updatedAt;

  Collection({
    this.id,
    this.categoryId,
    this.name,
    this.category,
    this.wallpaper,
    this.createdAt,
    this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
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
