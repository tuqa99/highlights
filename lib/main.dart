import "package:flutter/material.dart";

import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
=======
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:highlights/screens/SignUpSpecialist.dart';
import 'package:highlights/screens/SplashScreen.dart';
>>>>>>> 26c05b465f59bc4850e0c5129ed009686ec908ad
import 'package:highlights/screens/login.dart';
import 'firebase_options.dart';
import 'profiledrawer/AccountSettings.dart';

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
<<<<<<< HEAD
  runApp(const MaterialApp(
    home: MyApp(),
=======
  runApp(ValueChangeObserver<bool>(
    cacheKey: AccountSettings.KeyDarkMode,
    defaultValue: false,
    builder: (_, isDarkMode, __) => MaterialApp(
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.teal,
              accentColor: Colors.white,
              scaffoldBackgroundColor: Colors.black,
              canvasColor: Colors.black,
            )
          : ThemeData.light().copyWith(accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
>>>>>>> 26c05b465f59bc4850e0c5129ed009686ec908ad
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
