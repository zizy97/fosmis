import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fosmis/Services/apimanger.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';
import 'package:fosmis/Widgets/createCard.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:fosmis/pages/dataview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_field
  Future<NewsData> _newsModel;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _newsModel = APIManager().getNotify();
    super.initState();
  }

  Future<bool> _onbackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit or logout?'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              child: Text('Logout')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Exit'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackPressed(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("FOSMIS NEWS UPDATE"),
            backgroundColor: Colors.purple.shade300,
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => Navigator.of(context).pushNamed('/login'))
            ],
          ),
          body: Container(
            child: FutureBuilder<NewsData>(
              future: _newsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notification = snapshot.data.newsData;
                  return ListView.builder(
                      itemCount: snapshot.data.newsData.length,
                      itemBuilder: (context, index) => OpenContainer(
                            transitionDuration: Duration(seconds: 1),
                            closedBuilder:
                                (context, VoidCallback opencontainer) =>
                                    createCard(notification[index], context,
                                        opencontainer),
                            openBuilder: (context, _) =>
                                DataView(notification[index]),
                          ));
                } else {
                  return Center(child: RefreshProgressIndicator());
                }
              },
            ),
          ),
          drawer: build_drawer("NEWS FEED")),
    );
  }
}
