import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/UserScreens/HomePageComp/FirstPage.dart';

import '../UserScreens/userProfile/button_widget.dart';
import 'login.dart';

class SignupPageuser extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController location = TextEditingController();

  var authin = FirebaseAuth.instance;
  var selectedService = "Hair";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color.fromARGB(255, 162, 212, 244),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 162, 212, 244),
          Color.fromARGB(255, 194, 225, 244),
          Colors.white
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account it's free",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade700,
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(firstName, label: "First Name"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(lastName, label: "Last Name"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(email, label: "Email"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(phoneNumber, label: "numberphone"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(location, label: "Your location"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade400))),
                            child: makeInput(password,
                                label: "Password", obsureText: true),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: makeInput(password2,
                                  label: "Confirm Pasword", obsureText: true)),
                        ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonWidget(
                        text: "Sign Up",
                        onClicked: () async {
                          try {
                            var authin = FirebaseAuth.instance;
                            UserCredential user =
                                await authin.createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            addUserInfo(
                              firstName.text.trim(),
                              lastName.text.trim(),
                              email.text.trim(),
                              phoneNumber.text.trim(),
                              location.text.trim(),
                            );
                            Addchat(firstName.text.trim());
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("its added")));
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return NewHome();
                              },
                            ));
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "sorry try to change the pass and the email")));
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 162, 212, 244),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ));
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

Future addUserInfo(String firstName, String lastName, String email,
    String phoneNumber, String location) async {
  var authin = FirebaseAuth.instance;

  await FirebaseFirestore.instance
      .collection("users")
      .doc(authin.currentUser!.uid)
      .set({
    'first name': firstName,
    'last name': lastName,
    'full name': "$firstName $lastName",
    'email': email,
    'location': location,
    'phone number': phoneNumber,
  });
}

Widget makeInput(TextEditingController controller,
    {label, obsureText = false}) {
  return TextField(
    controller: controller,
    obscureText: obsureText,
    decoration: InputDecoration(
      hintStyle: TextStyle(color: Colors.black),
      border: InputBorder.none,
      hintText: label,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    ),
  );
}

Addchat(
  String firstName,
) async {
  List usersemail = [];
  List usersname = [];
  var authin = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection('chat')
      .doc(authin.currentUser!.email)
      .set({
    "usersemail": usersemail,
    "usersname": usersname,
    "serviceemail": authin.currentUser!.email,
    "servicename": firstName,
  });
}
