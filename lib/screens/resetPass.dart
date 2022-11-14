import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlights/screens/login.dart';

import '../UserScreens/userProfile/button_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController? Email = TextEditingController();
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: Email!.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Send To Your Email ")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Your Email isn't defined")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 241, 17, 92),
          Color.fromARGB(255, 247, 90, 142),
          Color.fromARGB(255, 240, 198, 213)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We are here to help you!",
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
                              child: TextField(
                                controller: Email,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.pinkAccent,
                                    ),
                                    hintText:
                                        "Enter your email to reset your password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ButtonWidget(
                                text: "Reset",
                                onClicked: () {
                                  passwordReset();
                                }),
                            SizedBox(
                              height: 40,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return LoginPage();
                                  },
                                ));
                              },
                              child: const Text(
                                'Go back to Log In',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.pinkAccent),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Center(
//           child: Container(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   "Enter your Email to Reset Password",
//                   style: Theme.of(context).textTheme.headline5!,
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(color: Colors.grey.shade200))),
//                   child: TextField(
                    
//                     controller: Email,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.email,
//                         color: Colors.pinkAccent,
//                       ),
//                       hintText: "Email",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       prefixIcon: const Icon(Icons.email),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                     ),
//                   ),
//                 ),

//                 //------------------------------------------------------------------------------

//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink[300]),
//                   onPressed: () {
//                     passwordReset();
//                   },
//                   child: Text("Set"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }