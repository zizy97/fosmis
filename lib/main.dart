import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fosmis/pages/home.dart';
import 'package:fosmis/pages/login.dart';
import 'package:fosmis/pages/settings.dart';
import 'package:fosmis/Services/themeChange.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //Background Firebase message handle
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("notification");
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("notification");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, _brightness) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'fosmis',
          theme: ThemeData(
            fontFamily: "RobotoMono",
            brightness: _brightness,
            primarySwatch:
                Colors.purple, //backgroundColor: Colors.purple.shade300,
          ),
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/home': (context) => Home(),
            '/login': (context) => Login(),
            '/settings': (context) => SettingScreen(),
          },
        );
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
    Timer(Duration(seconds: 2), checklogging);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                height: 125.0,
                child: Image(
                  image: AssetImage("images/logo.png"),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Container(
                child: Text(
                  "Powered By FOSMIS API",
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void checklogging() {
    userdate.read('isLogged')
        ? Get.offAll(() => Home())
        : Get.offAll(() => Login());
  }
}
