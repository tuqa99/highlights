import 'dart:io';
import "package:flutter/material.dart";
import 'package:highlights/screens/chat_screen.dart';
import 'compantsspecialist/continarprofile.dart';
import 'compantsspecialist/read.dart';
import 'compantsspecialist/viewimage.dart';

class Specialistprofileforuser extends StatelessWidget {
  Specialistprofileforuser({
    required this.firstname,
    required this.email,
    required this.profilephotpurl,
    required this.CollectionName,
    required this.index,

    // required this.career,
  });
  String? firstname;
  String? email;
  String? career;
  String? profilephotpurl;
  String? CollectionName;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        email: email,
                        name: firstname,
                      )));
        }),
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 202, 68, 255)),
        body: Stack(
          children: [
            Continarprfileview(
              // career: career,
              email: email,
              firstname: firstname,
              profilephotpurl: profilephotpurl,
              CollectionName: CollectionName,
              index: index,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 175),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  'The packeges',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: Readbackgesforuser(),
                            ),
                            Divider(
                              thickness: 3,
                              height: 6,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  'My work',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: Viewimagesforuser(),
                            ),
                            Divider(
                              thickness: 3,
                              height: 6,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 55,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
