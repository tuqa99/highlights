import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlights/UserScreens/HomePageComp/HomePage.dart';

import '../UserScreens/userProfile/button_widget.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
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
          Colors.pink.shade500,
          Colors.pink.shade300,
          Colors.pink.shade100,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account it's free",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
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
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: makeInput(firstName, label: "First Name"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: makeInput(lastName, label: "Last Name"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: makeInput(email, label: "Email"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: makeInput(phoneNumber, label: "numberphone"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: makeInput(location, label: "Your location"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
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

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("its added")));
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
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
                          Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
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
      hintStyle: TextStyle(color: Colors.grey),
      border: InputBorder.none,
      hintText: label,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    ),
  );
}
