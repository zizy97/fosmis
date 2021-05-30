// To parse this JSON data, do
//
//     final newsData = newsDataFromJson(jsonString);

import 'dart:convert';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String newsDataToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
  NewsData({
    this.newsData,
  });

  List<NewsDatum> newsData;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        newsData: List<NewsDatum>.from(
            json["NewsData"].map((x) => NewsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "NewsData": List<dynamic>.from(newsData.map((x) => x.toJson())),
      };
}

class NewsDatum {
  NewsDatum({
    this.content,
    this.date,
    this.description,
    this.id,
    this.path,
  });

  String content;
  String date;
  String description;
  String id;
  Path path;

  factory NewsDatum.fromJson(Map<String, dynamic> json) => NewsDatum(
        content: json["CONTENT"],
        date: json["DATE"],
        description: json["DESCRIPTION"],
        id: json["ID"],
        path: pathValues.map[json["PATH"]],
      );

  Map<String, dynamic> toJson() => {
        "CONTENT": content,
        "DATE": date,
        "DESCRIPTION": description,
        "ID": id,
        "PATH": pathValues.reverse[path],
      };
}

enum Path { EMPTY, FILE_PATH_URL }

final pathValues =
    EnumValues({"": Path.EMPTY, "file-path-url": Path.FILE_PATH_URL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
