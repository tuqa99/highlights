import 'package:flutter/material.dart';
import 'package:highlights/screens/viewscreen.dart';
import 'package:lottie/lottie.dart';

class SplashScree extends StatefulWidget {
  const SplashScree({super.key});

  @override
  State<SplashScree> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScree> {
  @override
  void initState() {
    //set time to loade the new page
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoApp(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  "images/111.gif",
                  height: double.infinity,
                  width: double.infinity,
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
