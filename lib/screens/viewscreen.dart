import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:highlights/screens/SingupUser.dart';
import 'package:highlights/screens/login.dart';
import 'package:highlights/screens/signupspecialist.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/1.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'High Lights',
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: constraints.maxWidth *
                                  _controller.value.aspectRatio,
                              height: constraints.maxHeight,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
            SizedBox(
              width: 400,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 450,
                ),
                Container(
                    padding: const EdgeInsets.all(5),
                    width: 450,
                    height: 230,
                    margin: EdgeInsets.all(40),
                    child: Card(
                      color: Color.fromARGB(100, 22, 44, 33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "SignUp to ?",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SignupPageuser();
                                    },
                                  ));
                                }),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/128/1057/1057470.png',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Find a service',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 233, 60, 117)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SignUpSpecialist();
                                    },
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/128/4514/4514262.png',
                                      ),
                                    ),
                                    Text(
                                      'Providing service',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 233, 60, 117)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return LoginPage();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 201, 6, 136),
                                        fontSize: 22),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
