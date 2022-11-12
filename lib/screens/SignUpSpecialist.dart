import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlights/UserScreens/HomePageComp/HomePage.dart';
import 'package:highlights/UserScreens/allscreens.dart';
import 'package:highlights/UserScreens/userProfile/button_widget.dart';
import 'package:highlights/screens/login.dart';
import 'package:highlights/specialist/SpicialistVeiwuser.dart';
import 'package:highlights/specialist/specialistprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Color kActiveColor = Colors.pink;
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
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
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
                                    Text(
                                      "Select The service - services you want to provide:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pinkAccent),
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
                                                              : Colors.white,
                                                          width: 2)),
                                                  child: Text(
                                                    service,
                                                    style: TextStyle(
                                                        color: isSelected
                                                            ? kActiveColor
                                                            : Colors.pinkAccent,
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
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
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
// body: Center(
//   child: SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "Sign up",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Create an Account,Its free",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   makeInput(FirstName, label: "First Name"),
//                   makeInput(LastName, label: "Last Name"),
//                   makeInput(email, label: "Email"),
//                   makeInput(phoneNumber, label: "numberphone"),
//                   makeInput(location, label: "Your location"),
//                   Text(
//                     "Select The service - services you want to provide:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black87),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Wrap(
//                     children: servicesList.map(
//                       (service) {
//                         bool isSelected = false;
//                         if (selectedService!.contains(service)) {
//                           isSelected = true;
//                         }
//                         return GestureDetector(
//                           onTap: () {
//                             if (!selectedService!.contains(service)) {
//                               if (selectedService!.length <
//                                   servicesList.length) {
//                                 selectedService!.add(service);
//                                 setState(() {});
//                               }
//                             } else {
//                               selectedService!.removeWhere(
//                                   (element) => element == service);
//                               setState(() {});
//                             }
//                           },
//                           child: Container(
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: 5, vertical: 4),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 12),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.circular(18),
//                                     border: Border.all(
//                                         color: isSelected
//                                             ? kActiveColor
//                                             : Colors.grey,
//                                         width: 2)),
//                                 child: Text(
//                                   service,
//                                   style: TextStyle(
//                                       color: isSelected
//                                           ? kActiveColor
//                                           : Colors.grey,
//                                       fontSize: 14),
//                                 ),
//                               )),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   makeInput(
//                     password,
//                     label: "Password",
//                     obsureText: true,
//                   ),
//                   makeInput(
//                     password2,
//                     label: "Confirm Pasword",
//                     obsureText: true,
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Container(
//                 padding: EdgeInsets.only(top: 3, left: 3),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(40),
//                     border: Border(
//                         bottom: BorderSide(color: Colors.black),
//                         top: BorderSide(color: Colors.black),
//                         right: BorderSide(color: Colors.black),
//                         left: BorderSide(color: Colors.black))),
//                 child: MaterialButton(
//                   minWidth: double.infinity,
//                   height: 60,
//                   onPressed: () async {
//                     try {
//                       if (confirmedPassword() == true) {
//                         var authin = FirebaseAuth.instance;
//                         UserCredential user =
//                             await authin.createUserWithEmailAndPassword(
//                                 email: email.text,
//                                 password: password.text);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("its added")));
//                         addUserInfo(
//                           FirstName.text.trim(),
//                           LastName.text.trim(),
//                           email.text.trim(),
//                           phoneNumber.text.trim(),
//                           location.text.trim(),
//                           selectedService,
//                         );
//                         Navigator.push(context, MaterialPageRoute(
//                           builder: (context) {
//                             return Specialistprofileforedit();
//                           },
//                         ));
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                               "sorry try to change the pass and the email")));
//                       if (confirmedPassword() == false) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content:
//                                     Text("Password is not the same")));
//                       }
//                     }
//                   },
//                   color: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40)),
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Already have an account? "),
//                 Text(
//                   "Login",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 18),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
// );

Future addUserInfo(
  String firstName,
  String lastName,
  String email,
  String phoneNumber,
  String location,
  List<String>? selectedService,
) async {
  await FirebaseFirestore.instance.collection("specialist").add({
    'first name': firstName,
    'last name': lastName,
    'full name': "$firstName $lastName",
    'email': email,
    'location': location,
    'phone number': phoneNumber,
    'service': selectedService!,
  });
  if (selectedService!.contains("HairCut")) {
    await FirebaseFirestore.instance.collection("HairCut").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Hair Cut',
    });
  }
  if (selectedService!.contains("Coloring")) {
    await FirebaseFirestore.instance.collection("Coloring").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Coloring',
    });
  }
  if (selectedService!.contains("Styling")) {
    await FirebaseFirestore.instance.collection("Styling").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Styling',
    });
  }
  if (selectedService!.contains("Extensions")) {
    await FirebaseFirestore.instance.collection("Extensions").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Extensions',
    });
  }
  if (selectedService!.contains("Nails")) {
    await FirebaseFirestore.instance.collection("Nails").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Nails',
    });
  }
  if (selectedService!.contains("Facials")) {
    await FirebaseFirestore.instance.collection("Facials").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Facials',
    });
  }
  if (selectedService!.contains("MakeUp")) {
    await FirebaseFirestore.instance.collection("MakeUp").add({
      'first name': firstName,
      'last name': lastName,
      'full name': "$firstName $lastName",
      'email': email,
      'location': location,
      'phone number': phoneNumber,
      'service': 'Make Up',
    });
  }
  if (selectedService!.contains("Photography")) {
    await FirebaseFirestore.instance.collection("Photography").add({
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
        border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
  );
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
// Widget makeInput(TextEditingController controller,
//     {label, obsureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextField(
//         controller: controller,
//         obscureText: obsureText,
//         decoration: InputDecoration(
//           hintText: label,
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey,
//             ),
//           ),
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//         ),
//       ),
//       SizedBox(
//         height: 30,
//       )
//     ],
//   );
// }
