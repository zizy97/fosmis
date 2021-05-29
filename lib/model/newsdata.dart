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
    this.id,
    this.source,
  });

  String content;
  String date;
  int id;
  String source;

  factory NewsDatum.fromJson(Map<String, dynamic> json) => NewsDatum(
        content: json["CONTENT"],
        date: json["DATE"],
        id: json["ID"],
        source: json["Source"],
      );

  Map<String, dynamic> toJson() => {
        "CONTENT": content,
        "DATE": date,
        "ID": id,
        "Source": source,
      };
}
