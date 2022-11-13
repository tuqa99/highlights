import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:highlights/screens/specialistList.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8bbd0),
        title: Text("Search"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySeachDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class MySeachDelegate extends SearchDelegate {
  List servicelist = [
    'Coloring',
    'Extensions',
    'Facials',
    'HairCut',
    'MakeUp',
    'Nails',
    'Photography',
    'Styling'
  ];
  CollectionReference _services =
      FirebaseFirestore.instance.collection('specialist');
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back),
      );
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget buildResults(BuildContext context) {
    if (servicelist.contains(query)) {
      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {}),
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Image(
                                height: 100,
                                image: AssetImage("images/avatar.webp"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data!.docs[index]['first name']}+${snapshot.data!.docs[index]['last name']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff880e4f),
                              ),
                            ),
                            Text(
                                "Services: ${snapshot.data!.docs[index]['service']} "),
                            const SizedBox(
                              height: 5,
                            ),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xffbc477b),
                                );
                              },
                              onRatingUpdate: (value) {},
                            ),
                          ],
                        )),
                  );
                },
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: FirebaseFirestore.instance
            .collection('specialist')
            .where('service', arrayContains: query)
            .get(),
      );
    } else {
      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {}),
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Image(
                                height: 100,
                                image: AssetImage("images/avatar.webp"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data!.docs[index]['first name']}+${snapshot.data!.docs[index]['last name']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff880e4f),
                              ),
                            ),
                            Text(
                                "Services: ${snapshot.data!.docs[index]['service']} "),
                            const SizedBox(
                              height: 5,
                            ),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) {
                                return const Icon(
                                  Icons.star,
                                  color: Color(0xffbc477b),
                                );
                              },
                              onRatingUpdate: (value) {},
                            ),
                          ],
                        )),
                  );
                },
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: FirebaseFirestore.instance
            .collection('specialist')
            .where('first name', isEqualTo: query.toLowerCase())
            .get(),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> sugesstions = ['Hair', 'Nails', 'Coloring', 'Styling'];

    return ListView.builder(
      itemCount: sugesstions.length,
      itemBuilder: (context, index) {
        final suggestion = sugesstions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
