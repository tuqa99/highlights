import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/UserScreens/HomePageComp/homemodels.dart/hairspecialist.dart';
import 'package:highlights/UserScreens/userProfile/button_widget.dart';
import 'package:highlights/screens/resetPass.dart';
import 'package:highlights/signInGoogle/FirebaseServices.dart';
import 'package:highlights/screens/viewscreen.dart';
import 'package:highlights/signInGoogle/database.dart';
import 'package:line_icons/line_icons.dart';
import '../../UserScreens/HomePageComp/FirstPage.dart';
import '../../UserScreens/allscreens.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../specialist/SpecialSide/AllscreenSpecialist.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor
            //     gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            //   Color.fromARGB(255, 162, 212, 244),
            //   Color.fromARGB(255, 194, 225, 244),
            //   Colors.white
            // ])
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Login",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back ",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ))),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: "Enter your email",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ))),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.lock_person,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: "Enter your Password",
                                  // hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonWidget(
                        text: "Login",
                        onClicked: () async {
                          try {
                            var authin = FirebaseAuth.instance;
                            UserCredential user =
                                await authin.signInWithEmailAndPassword(
                                    email: nameController.text,
                                    password: passwordController.text);
                            if (await emailCheck(nameController.text)) {
                              print(emailCheck(nameController.text));
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MainPage();
                                },
                              ));
                            } else {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SpecialistMain(); //change this for specialist homepage
                                },
                              ));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("sorry invalid email or pass")));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ResetPassword();
                            },
                          ));
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Don\'t have account?',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return VideoApp();
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '0r Login using ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: const Image(
                                height: 30,
                                width: 30,
                                image: AssetImage('images/google.png')),
                            onTap: () async {
                              await FirebaseServices().signInWithGoogle();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Welcome"),
                                ),
                              );

                              Database.userUid =
                                  FirebaseAuth.instance.currentUser?.uid;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MainPage();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ]),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}

Future<bool> emailCheck(String email) async {
  bool result = false;
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();
  snapshot.docs.forEach((f) {
    if (f['email'] == email) {
      result = true;
    }
  });
  return result;
}
