import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/UserScreens/allscreens.dart';
import 'package:highlights/UserScreens/userProfile/button_widget.dart';
import 'package:highlights/screens/SignIn_Up/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../specialist/SpecialSide/specialistprofile.dart';

class SignUpSpecialist extends StatefulWidget {
  const SignUpSpecialist({super.key});

  @override
  State<SignUpSpecialist> createState() => _SignUpSpecialistState();
}

class _SignUpSpecialistState extends State<SignUpSpecialist> {
  TextEditingController email = TextEditingController();
  TextEditingController FirstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  List<String> servicesList = [
    "HairCut",
    "Coloring",
    "Styling",
    "Extensions",
    "Nails",
    "Facials",
    "MakeUp",
    "Photography",
  ];
  Color kActiveColor = Color.fromARGB(255, 162, 212, 244);
  List<String>? selectedService = [];

  bool confirmedPassword() {
    if (password.text.trim() == password2.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        )),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
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
                                child: Column(
                                  children: [
                                    fieldContainer(
                                      makeInput(FirstName, label: "First Name"),
                                    ),
                                    fieldContainer(
                                      makeInput(LastName, label: "Last Name"),
                                    ),
                                    fieldContainer(
                                      makeInput(email, label: "Email"),
                                    ),
                                    fieldContainer(
                                      makeInput(phoneNumber,
                                          label: "Phone Number"),
                                    ),
                                    fieldContainer(
                                      makeInput(location,
                                          label: "Your Location"),
                                    ),
                                    fieldContainer(
                                      makeInput(
                                        password,
                                        label: "Password",
                                        obsureText: true,
                                      ),
                                    ),
                                    fieldContainer(
                                      makeInput(
                                        password2,
                                        label: "Confirm Pasword",
                                        obsureText: true,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select The service - services you want to provide:",
                                          style: GoogleFonts.playfairDisplay(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Wrap(
                                      children: servicesList.map(
                                        (service) {
                                          bool isSelected = false;
                                          if (selectedService!
                                              .contains(service)) {
                                            isSelected = true;
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              if (!selectedService!
                                                  .contains(service)) {
                                                if (selectedService!.length <
                                                    servicesList.length) {
                                                  selectedService!.add(service);
                                                  setState(() {});
                                                }
                                              } else {
                                                selectedService!.removeWhere(
                                                    (element) =>
                                                        element == service);
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      border: Border.all(
                                                          color: isSelected
                                                              ? kActiveColor
                                                              : Colors.grey
                                                                  .shade500,
                                                          width: 2)),
                                                  child: Text(
                                                    service,
                                                    style: TextStyle(
                                                        color: isSelected
                                                            ? kActiveColor
                                                            : Colors
                                                                .grey.shade700,
                                                        fontSize: 14),
                                                  ),
                                                )),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ButtonWidget(
                                text: "Sign Up",
                                onClicked: () async {
                                  try {
                                    if (confirmedPassword() == true) {
                                      var authin = FirebaseAuth.instance;
                                      UserCredential user = await authin
                                          .createUserWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("its added")));
                                      addUserInfo(
                                        FirstName.text.trim(),
                                        LastName.text.trim(),
                                        email.text.trim(),
                                        phoneNumber.text.trim(),
                                        location.text.trim(),
                                        selectedService,
                                      );
                                      Addchat(FirstName.text.trim());
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Specialistprofileforedit();
                                        },
                                      ));
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "sorry try to change the pass and the email")));
                                    if (confirmedPassword() == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Password is not the same")));
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account? "),
                                  TextButton(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 162, 212, 244),
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
                              )
                            ],
                          ),
                        ))))
          ],
        ),
      ),
    );
  }
}

Future addUserInfo(
  String firstName,
  String lastName,
  String email,
  String phoneNumber,
  String location,
  List<String>? selectedService,
) async {
  var authin = FirebaseAuth.instance;
  await FirebaseFirestore.instance
      .collection("specialist")
      .doc(authin.currentUser!.uid)
      .set({
    'first name': firstName,
    'last name': lastName,
    'full name': "$firstName $lastName",
    'email': email,
    'location': location,
    'phone number': phoneNumber,
    'service': selectedService!,
  });

  if (selectedService.contains("HairCut")) {
    await FirebaseFirestore.instance
        .collection("HairCut")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Hair Cut',
    });
  }
  if (selectedService.contains("Coloring")) {
    await FirebaseFirestore.instance
        .collection("Coloring")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Coloring',
    });
  }
  if (selectedService.contains("Styling")) {
    await FirebaseFirestore.instance
        .collection("Styling")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Styling',
    });
  }
  if (selectedService.contains("Extensions")) {
    await FirebaseFirestore.instance
        .collection("Extensions")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Extensions',
    });
  }
  if (selectedService.contains("Nails")) {
    await FirebaseFirestore.instance
        .collection("Nails")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Nails',
    });
  }
  if (selectedService.contains("Facials")) {
    await FirebaseFirestore.instance
        .collection("Facials")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Facials',
    });
  }
  if (selectedService.contains("MakeUp")) {
    await FirebaseFirestore.instance
        .collection("MakeUp")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Make Up',
    });
  }
  if (selectedService.contains("Photography")) {
    await FirebaseFirestore.instance
        .collection("Photography")
        .doc(authin.currentUser!.uid)
        .set({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Photography',
    });
  }
}

Widget fieldContainer(Widget child) {
  return Container(
    child: child,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
  );
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
