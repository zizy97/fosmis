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
    this.date,
    this.description,
    this.id,
    this.recent,
    this.source,
    this.title,
  });

  String date;
  String description;
  int id;
  bool recent;
  List<String> source;
  String title;

  factory NewsDatum.fromJson(Map<String, dynamic> json) => NewsDatum(
        date: json["DATE"],
        description: json["DESCRIPTION"],
        id: json["ID"],
        recent: json["RECENT"],
        source: json["SOURCE"] == null
            ? null
            : List<String>.from(json["SOURCE"].map((x) => x)),
        title: json["TITLE"],
      );

  Map<String, dynamic> toJson() => {
        "DATE": date,
        "DESCRIPTION": description,
        "ID": id,
        "RECENT": recent,
        "SOURCE":
            source == null ? null : List<dynamic>.from(source.map((x) => x)),
        "TITLE": title,
      };
}
