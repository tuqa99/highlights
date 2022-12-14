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
            backgroundColor: Theme.of(context).primaryColor,
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
          backgroundColor: Theme.of(context).primaryColor,
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
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Text('Gallery'),
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                height: 200,
                                width: 300,
                                child: Viewimagesforuser(
                                  emial: email,
                                  CollectionName: CollectionName,
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 60,
                      ),
                      Text('Packges'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Readbackgesforuser(emial: email),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
