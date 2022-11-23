import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:highlights/profiledrawer/AccountSettings.dart';
import 'package:highlights/screens/SignIn_Up/login.dart';
import 'package:highlights/screens/SplashScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(ValueChangeObserver<bool>(
    cacheKey: AccountSettings.KeyDarkMode,
    defaultValue: false,
    builder: (_, isDarkMode, __) => MaterialApp(
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.grey.shade900,
              primaryColor: Colors.teal,
              colorScheme: ColorScheme.dark(),
              cardColor: Colors.black,
              highlightColor: Colors.teal,
              backgroundColor: Colors.grey.shade900,

              // canvasColor: Colors.black,
              // cardColor: Colors.black,
            )
          : ThemeData.light().copyWith(
              backgroundColor:
                  Color.fromARGB(255, 225, 223, 224).withOpacity(.6),
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Color.fromARGB(255, 162, 212, 244),
              cardColor: Colors.white,
              highlightColor: Colors.black,
              colorScheme: ColorScheme.light()),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
