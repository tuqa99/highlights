import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SpecialistList extends StatelessWidget {
  SpecialistList({
    required this.CollectionName,
    // required imageUrl,
  });
  String? CollectionName;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    CollectionReference ref =
        FirebaseFirestore.instance.collection(CollectionName!);
    var documents = ref.get();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xfff8bbd0),
      body: FutureBuilder<QuerySnapshot>(
          future: documents,
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: (() {}),
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
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
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 5),
                              // height: 110,
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
                              document['full name']!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff880e4f),
                              ),
                            ),
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
                }),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
