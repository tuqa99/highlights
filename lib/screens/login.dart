import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlights/UserScreens/HomePageComp/homemodels.dart/hairspecialist.dart';
import 'package:highlights/UserScreens/userProfile/button_widget.dart';
import 'package:highlights/screens/resetPass.dart';
import 'package:highlights/signInGoogle/FirebaseServices.dart';
import 'package:highlights/UserScreens/HomePageComp/HomePage.dart';
import 'package:highlights/screens/viewscreen.dart';
import 'package:highlights/signInGoogle/database.dart';
import 'package:highlights/specialist/specialistprofile.dart';
import 'package:line_icons/line_icons.dart';
import '../UserScreens/allscreens.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        decoration:const  BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 186, 104, 200),
          Color.fromARGB(255, 218, 178, 226),
          Color.fromARGB(255, 240, 198, 213)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                  padding:const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 218, 178, 226),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(children: [
                          Container(
                            padding:const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextField(
                              controller: nameController,
                              decoration:const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 186, 104, 200),
                                  ),
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.lock_person,
                                    color: Color.fromARGB(255, 186, 104, 200),
                                  ),
                                  hintText: "Enter your Password",
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                  return Specialistprofileforedit(); //change this for specialist homepage
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
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 186, 104, 200),
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
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 186, 104, 200),
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
                        children:const [
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
                            child:const Image(
                                height: 30,
                                width: 30,
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/128/300/300221.png')),
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
                                    return const HomePage();
                                  },
                                ),
                              );
                            },
                          ),
                         const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            child:const Image(
                                height: 30,
                                width: 30,
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/128/5968/5968764.png')),
                            onTap: () {},
                          )
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
