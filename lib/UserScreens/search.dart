import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/screens/specialistList.dart';

import '../specialist/SpicialistVeiwuser.dart';

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
  String? _profileimage;
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

  ratingAva(DocumentSnapshot document) {
    List allRatings = document['rating'];
    num length = allRatings.length;
    if (length > 1) {
      length = length - 1;
    }
    num sum = 0;
    print(length);
    for (int i = 0; i < allRatings.length; i++) {
      num index = allRatings[i];
      sum += index;
    }
    double ava = sum / length;
    return ava;
  }

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
                    onTap: (() {
                      // print(ratingAva());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Specialistprofileforuser(
                              firstname: snapshot.data!.docs[index]
                                  ['first name'],
                              email: snapshot.data!.docs[index]['email'],
                              profilephotpurl: snapshot.data!.docs[index]
                                  ['imageprofileurl'],
                              CollectionName: snapshot.data!.docs[index]
                                  ['service'][0],
                              index: index,

                              // career: document['service']),
                            ),
                          ));
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: .5,
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                        color: Color.fromARGB(255, 241, 237, 239),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    '${snapshot.data!.docs[index]['imageprofileurl']}')),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.docs[index]['first name']
                                  .toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade900),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RatingBarIndicator(
                              itemSize: 21,
                              rating: ratingAva(snapshot.data!.docs[index]),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                    onTap: (() {
                      // print(ratingAva());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Specialistprofileforuser(
                              firstname: snapshot.data!.docs[index]
                                  ['first name'],
                              email: snapshot.data!.docs[index]['email'],
                              profilephotpurl: snapshot.data!.docs[index]
                                  ['imageprofileurl'],
                              CollectionName: snapshot.data!.docs[index]
                                  ['service'][0],
                              index: index,

                              // career: document['service']),
                            ),
                          ));
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: .5,
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                        color: Color.fromARGB(255, 241, 237, 239),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    '${snapshot.data!.docs[index]['imageprofileurl']}')),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.docs[index]['first name']
                                  .toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                    wordSpacing: 1,
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade900),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RatingBarIndicator(
                              itemSize: 21,
                              rating: ratingAva(snapshot.data!.docs[index]),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
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
