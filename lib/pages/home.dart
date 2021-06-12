import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fosmis/Services/apimanger.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';
import 'package:fosmis/Widgets/getContent.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_field
  Future<NewsData> _newsModel, _mostrecent;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _newsModel =
        APIManager().getNotify("https://fosmisapi.herokuapp.com/newsdata");
    _mostrecent =
        APIManager().getNotify("https://fosmisapi.herokuapp.com/recent");
    super.initState();
  }

  final userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackPressed(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("FOSMIS Notify"),
              backgroundColor: Colors.purple.shade300,
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      userdata.write('isLogged', false);
                      userdata.remove('uname');
                      userdata.remove('upwd');
                      Get.offAllNamed('/login');
                    })
              ],
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.notifications_active)),
                  Tab(
                    icon: Icon(Icons.notifications),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [getContent(_mostrecent), getContent(_newsModel)],
            ),
            drawer: build_drawer("NEWS FEED", context: context)),
      ),
    );
  }

  Future<bool> _onbackPressed() {
    _scaffoldKey.currentState.isDrawerOpen
        ? Navigator.pop(context)
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Do you want to exit or logout?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      userdata.write('isLogged', false);
                      userdata.remove('uname');
                      userdata.remove('upwd');
                      Get.offAllNamed('/login');
                    },
                    child: Text('Logout')),
                ElevatedButton(
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                    child: Text('Exit'))
              ],
            ),
          );
    return null;
  }
}
