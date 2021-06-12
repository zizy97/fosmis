import 'dart:convert';
import 'package:fosmis/model/newsdata.dart';
import 'package:http/http.dart' as http;

class APIManager {
  APIManager();
  Future<NewsData> getNotify(String urll) async {
    var client = http.Client();
    // ignore: avoid_init_to_null
    var newsmodel = null;
    try {
      var url = Uri.parse(urll);
      var response = await client.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        //print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        newsmodel = NewsData.fromJson(jsonMap);
      }
      print(newsmodel);
      return newsmodel;
    } catch (e) {
      return newsmodel;
    }
  }
}
