import 'package:flutter/material.dart';

class Specailist {
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final bool isFavourite, isPopular;
  final double rating;

  Specailist(
      {required this.colors,
      this.rating = 0.0,
      this.isFavourite = false,
      this.isPopular = false,
      required this.description,
      required this.title,
      required this.images});
}

List<Specailist> demoo = [
  Specailist(
    colors: [Color(0xffffeeff), Color(0xfff8bbd0)],
    description:
        "hair specialist how is specialist in hair but is hairspecalist1",
    title: "Hairstylist1",
    images: ["images/stylist1.jpeg"],
    isPopular: true,
    rating: 4.1,
  ),
  Specailist(
    colors: [Color(0xffffeeff), Color(0xfff8bbd0)],
    description:
        "hair specialist how is specialist in hair but is hairspecalist2",
    title: "Hairstylist2",
    images: ["images/stylist2.jpg"],
    isPopular: true,
    rating: 4.1,
  )
];
