import "package:flutter/material.dart";
import 'package:highlights/UserScreens/allscreens.dart';
import 'package:highlights/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:highlights/specialist/SpicialistVeiwuser.dart';
import 'package:highlights/specialist/specialistprofile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Specialistprofileforedit();
  }
}
