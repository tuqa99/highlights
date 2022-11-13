import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:highlights/profiledrawer/AccountSettings.dart';
import 'package:highlights/screens/SignUpSpecialist.dart';
import 'package:highlights/screens/SplashScreen.dart';
import 'package:highlights/screens/login.dart';
import 'package:highlights/specialist/specialistprofile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  ));
  // print(getData("HairCut"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Specialistprofileforedit();
  }
}
