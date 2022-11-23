import 'dart:io';
import "package:flutter/material.dart";
import 'package:highlights/screens/chat_screen.dart';
import 'SpecialSide/compantsspecialist/continarprofile.dart';
import 'SpecialSide/compantsspecialist/read.dart';
import 'SpecialSide/compantsspecialist/viewimage.dart';

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
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade800,
            child: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            email: email,
                            name: firstname,
                          )));
            }),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 237, 239),
        ),
        body: Stack(
          children: [
            Continarprfileview(
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
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Gallery',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          height: 300,
                          width: 300,
                          child: Viewimagesforuser(
                            emial: email,
                          ),
                        ),
                        Divider(
                          thickness: 3,
                          height: 6,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            // Container(
            //   child: Row(
            //     children: [
            //       Readbackgesforuser(emial: email),
            //       SizedBox(
            //         width: 55,
            //       )
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
