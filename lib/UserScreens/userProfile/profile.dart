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
                  buildName(user),
                ]),
                // SizedBox(
                //   height: 10,
                // )
              ])),
          Expanded(
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
                  MyTile(leadIcon: Icons.person, text: user.name),
                  MyTile(leadIcon: Icons.phone, text: user.phone),
                  MyTile(
                    leadIcon: Icons.mail,
                    text: user.email,
                  ),
                  MyTile(
                      leadIcon: Icons.payment,
                      text: "Payment Method",
                      traiIcon: LineIcons.arrowRight),
                  MyTile(
                    leadIcon: Icons.location_pin,
                    text: "Location",
                    ontap1: () {},
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
          ),
        ]),
      ),
    );
  }

  Widget buildEditButton() => ButtonWidget(
      text: "Edit Profile",
      onClicked: () {
        Navigator.pushNamed(context, "edit page");
      });

  Widget buildName(User user) => Container(
        alignment: Alignment.bottomLeft,
        // color: Colors.red,
        height: 46,
        child: Column(
          children: [
            Text(
              user.name,
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
                user.email,
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
