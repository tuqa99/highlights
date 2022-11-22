import 'package:flutter/material.dart';
import 'package:highlights/UserScreens/AppBar/textsearch.dart';
import 'package:highlights/UserScreens/AppBar/textwidget.dart';
import 'package:highlights/UserScreens/AppBar/theme.dart';
import 'package:highlights/UserScreens/HomePageComp/homemodels.dart/hairspecialist.dart';

import '../../profiledrawer/AccountSettings.dart';
import 'categories.dart';
import 'homemodels.dart/title_section.dart';
import 'packages.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // shadowColor: Color.fromARGB(255, 225, 223, 224),
        elevation: .1,
      ),
      drawer: Drawer(
        child: AccountSettings(),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: height * 0.20,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40))),
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    const TextWidget(
                        text: 'Welcome back ',
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                const SearchTextField()
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          //title for packages
                          TitleSection(
                            text: "\t Prepared Packages",
                            press: () {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // packages
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Packages(
                                  image: "images/grad.jpg",
                                  category: "Bridal",
                                  numOfOffers: 5,
                                  press: () {},
                                ),
                                Packages(
                                  image: "images/wedding.jpg",
                                  category: "Bridal",
                                  numOfOffers: 8,
                                  press: () {},
                                ),
                              ],
                            ),
                          ), //For packages
                          SizedBox(
                            height: 20,
                          ),
                          TitleSection(
                            text: "\t Categories",
                            press: () {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Categories(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
