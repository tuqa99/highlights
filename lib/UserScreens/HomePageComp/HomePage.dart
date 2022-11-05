import 'package:flutter/material.dart';

import 'HairSpecialist.dart';
import 'categories.dart';
import 'homemodels.dart/hairspecialist.dart';
import 'packages.dart';
import 'homemodels.dart/title_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
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
                      image: "images/1.jpg",
                      category: "Bridal",
                      numOfOffers: 5,
                      press: () {},
                    ),
                    Packages(
                      image: "images/1.jpg",
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
              TitleSection(
                text: "\t Hair Specialist",
                press: () {},
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    ...List.generate(
                        demoo.length,
                        (index) => Specialists(
                              specialist: demoo[index],
                            ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
