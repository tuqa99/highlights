import 'package:flutter/material.dart';

class Packages extends StatelessWidget {
  const Packages(
      {super.key,
      required this.category,
      required this.image,
      required this.numOfOffers,
      required this.press});
  final String category, image;
  final int numOfOffers;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: SizedBox(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.asset(
              image,
              fit: BoxFit.fill,
              height: 120,
              width: 250,
            ),
            Container(
              height: 120,
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 162, 212, 244).withOpacity(.5),
                      Color.fromARGB(255, 194, 225, 244).withOpacity(.5),
                      Colors.white.withOpacity(.5)
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "$category Package\n \n",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  TextSpan(
                      text: "\t \tThis packge includes:$numOfOffers items",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ]),
              ),
            )
          ],
        ),
      )),
    );
  }
}
