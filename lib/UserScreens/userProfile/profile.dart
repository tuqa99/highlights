import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlights/UserScreens/userProfile/profilewidget.dart';
import 'package:highlights/UserScreens/userProfile/text_field_widget.dart';
import 'package:highlights/UserScreens/userProfile/userPreferences.dart';
import 'package:line_icons/line_icons.dart';

import 'button_widget.dart';
import 'container_widget.dart';
import 'user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPrefernces.myUser;
    return Scaffold(
      backgroundColor: Color(0xFFffeeff),
      // appBar: buildAppBar(context),
      body: Container(
        child: Column(children: [
          Container(
              height: 250,
              decoration: BoxDecoration(
                color: Color(0xFFf8bbd0),
                // borderRadius:
                //     BorderRadius.only(bottomRight: Radius.circular(200)),
              ),
              child: Column(children: [
                SizedBox(
                  height: 100,
                ),
                Row(children: [
                  SizedBox(
                    width: 20,
                  ),
                  ProfileWidget(
                      imagePath: user.imagePath,
                      onClicked: () {
                        Navigator.pushNamed(context, "edit page");
                      }),
                  const SizedBox(
                    width: 24,
                  ),
                  //useer
                  PrfileHeader(),
                ]),
                // SizedBox(
                //   height: 10,
                // )
              ])),
          ProfileInfo(),
        ]),
      ),
    );
  }

  Widget buildEditButton() => ButtonWidget(
      text: "Edit Profile",
      onClicked: () {
        Navigator.pushNamed(context, "edit page");
      });
}

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final doc_id = auth!.uid;
    var collection = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: collection.doc('$doc_id').get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var _fname = data!['first name'];
          var _lname = data['last name'];
          var _email = data['email'];
          var _phone = data['phone number'];
          var _location = data['location'];
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Account Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  MyTile(leadIcon: Icons.person, text: _fname + _lname),
                  MyTile(leadIcon: Icons.phone, text: _phone),
                  MyTile(
                    leadIcon: Icons.mail,
                    text: _email,
                  ),
                  MyTile(
                    leadIcon: Icons.location_pin,
                    text: "Location",
                    ontap1: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("your Location is $_location"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                              ]);
                        },
                      );
                    },
                  ),
                  Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "My Services",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyContainer(),
                        MyContainer(),
                        MyContainer(),
                        MyContainer(),
                        MyContainer(),
                        MyContainer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PrfileHeader extends StatefulWidget {
  const PrfileHeader({super.key});

  @override
  State<PrfileHeader> createState() => _PrfileHeaderState();
}

class _PrfileHeaderState extends State<PrfileHeader> {
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final doc_id = auth!.uid;
    var collection = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: collection.doc('$doc_id').get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var _fname = data!['first name'];
          var _lname = data['last name'];
          var _email = data['email'];

          return Container(
            alignment: Alignment.bottomLeft,
            // color: Colors.red,
            height: 46,
            child: Column(
              children: [
                Text(
                  _fname + _lname,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _email,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
