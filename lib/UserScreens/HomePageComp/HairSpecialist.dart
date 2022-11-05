import 'package:flutter/material.dart';

import 'homemodels.dart/hairspecialist.dart';

class Specialists extends StatelessWidget {
  const Specialists(
      {super.key,
      this.width = 140,
      this.aspectRatio = 1.02,
      required this.specialist});

  final double width, aspectRatio;
  final Specailist specialist;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            SizedBox(
              width: 140,
              height: 150,
              child: AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffc38a9e).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(specialist.images[0]),
                ),
              ),
            ),
            Text(specialist.title),
            Container(
              child: Text(specialist.description),
            )
          ],
        ),
      ),
    );
  }
}
