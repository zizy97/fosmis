import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fosmis/Widgets/createCard.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:fosmis/pages/dataview.dart';

Container getContent(Future<NewsData> _newsModel) {
  return Container(
    padding: EdgeInsets.all(8.0),
    child: FutureBuilder<NewsData>(
      future: _newsModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var notification = snapshot.data.newsData;
          return ListView.separated(
              separatorBuilder: (context,index) => SizedBox(height: 8.0),
              itemCount: snapshot.data.newsData.length,
              itemBuilder: (context, index) => OpenContainer(
                    transitionDuration: Duration(seconds: 1),
                    closedBuilder: (context, VoidCallback opencontainer) =>
                        createCard(notification[index], context, opencontainer),
                    openBuilder: (context, _) => DataView(notification[index]),
                  ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}
