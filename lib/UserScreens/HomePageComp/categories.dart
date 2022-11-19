import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/specialistList.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.icon, required this.text, required this.press});
  final GestureTapCallback press;
  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 55,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 225, 223, 224).withOpacity(.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(icon),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories1 = [
      {"icon": "icons/cutting.png", "text": "HairCut"},
      {"icon": "icons/dying.png", "text": "Coloring"},
      {"icon": "icons/style.png", "text": "Styling"},
      {"icon": "icons/strightner.png", "text": "Extensions"},
    ];
    List<Map<String, dynamic>> categories2 = [
      {"icon": "icons/nails1.png", "text": "Nails"},
      {"icon": "icons/facial1.png", "text": "Facials"},
      {"icon": "icons/makeupb.png", "text": "MakeUp"},
      {"icon": "icons/camera1.png", "text": "Photography"},
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            ...List.generate(
              categories1.length,
              (index) => CategoryCard(
                icon: categories1[index]["icon"],
                text: categories1[index]["text"],
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (categories1[index]["text"] == "HairCut") {
                      return SpecialistList(
                         "HairCut",
                      );
                    }
                    if (categories1[index]["text"] == "Coloring") {
                      return SpecialistList(
                        "Coloring",
                      );
                    }
                    if (categories1[index]["text"] == "Styling") {
                      return SpecialistList(
                       "Styling",
                      );
                    }

                    return SpecialistList(
                     "Extensions",
                    );
                  }));
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            ...List.generate(
              categories2.length,
              (index) => CategoryCard(
                icon: categories2[index]["icon"],
                text: categories2[index]["text"],
                press: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      if (categories2[index]["text"] == "Nails") {
                        return SpecialistList(
                           "Nails",
                        );
                      }
                      if (categories2[index]["text"] == "Facials") {
                        return SpecialistList(
                           "Facials",
                        );
                      }
                      if (categories2[index]["text"] == "MakeUp") {
                        return SpecialistList(
                           "MakeUp",
                        );
                      }
                      return SpecialistList(
                         "Photography",
                      );
                    },
                  ));
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }
}

// getData(String collection_name) async{
//   List<String> myData;
// CollectionReference ref= await FirebaseFirestore.instance.collection(collection_name);

// }


