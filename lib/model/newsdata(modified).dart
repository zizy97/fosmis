// To parse this JSON data, do
//
//     final newsData = newsDataFromJson(jsonString);

import 'dart:convert';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String newsDataToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
  NewsData({
    this.newsdata,
  });

  List<Newsdatum> newsdata;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        newsdata: List<Newsdatum>.from(
            json["Newsdata"].map((x) => Newsdatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Newsdata": List<dynamic>.from(newsdata.map((x) => x.toJson())),
      };
}

class Newsdatum {
  Newsdatum({
    this.date,
    this.description,
    this.id,
    this.recent,
    this.source,
    this.title,
  });

  DateTime date;
  String description;
  int id;
  bool recent;
  List<String> source;
  String title;

  factory Newsdatum.fromJson(Map<String, dynamic> json) => Newsdatum(
        date: DateTime.parse(json["date"]),
        description: json["description"],
        id: json["id"],
        recent: json["recent"],
        source: List<String>.from(json["source"].map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "description": description,
        "id": id,
        "recent": recent,
        "source": List<dynamic>.from(source.map((x) => x)),
        "title": title,
      };
}
