import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xffbc477b),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(3, 7),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xfff8bbd0),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          Container(
            width: 150,
            margin: const EdgeInsets.only(top: 5),
            // height: 110,
            child: const Image(
              height: 100,
              image: NetworkImage(
                  "https://yt3.ggpht.com/ytc/AMLnZu-htKBt4jUDwmnm0r-ojGjHZMy9-H92Q1pRoAfkgw=s900-c-k-c0x00ffffff-no-rj"),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Sara alassimi",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff880e4f),
            ),
          )
        ]));
  }
}
