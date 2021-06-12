import 'package:flutter/material.dart';
import 'package:fosmis/pages/home.dart';
import 'package:fosmis/pages/login.dart';
import 'package:fosmis/pages/settings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fosmis',
      theme: ThemeData(
        fontFamily: "RobotoMono",
        brightness: Brightness.dark,
        primarySwatch: Colors.purple, //backgroundColor: Colors.purple.shade300,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userdate = GetStorage();
  @override
  void initState() {
    super.initState();
    userdate.writeIfNull('isLogged', false);
    Future.delayed(Duration.zero, () async {
      checklogging();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void checklogging() {
    userdate.read('isLogged')
        ? Get.offAll(() => Home())
        : Get.offAll(() => Login());
  }
}
