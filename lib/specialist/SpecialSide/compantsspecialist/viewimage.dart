import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewimages extends StatelessWidget {
  const Viewimages({super.key});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final docId = auth!.uid;
    var ref = FirebaseFirestore.instance.collection('specialist').doc(docId);
    return FutureBuilder(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            List<String>? images = List.from(data!['url']);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 22, left: 22),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text(
                                  "Do you want to delate this image"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () async {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('specialist');

                                      collection.doc(docId).update({
                                        'url': FieldValue.arrayRemove(
                                            [images[index]])
                                      });
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('yes')),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("NO"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                  image: NetworkImage(images[index]),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Viewimagesforuser extends StatelessWidget {
  Viewimagesforuser({required this.emial});
  String? emial;
  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final doc_id = auth!.uid;
    var ref = FirebaseFirestore.instance.collection('specialist').doc(emial);
    return FutureBuilder(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            List<String>? images = List.from(data!['url']);
            if (data['email' == emial]) {
              return ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 22, left: 22),
                    child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Image(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover)),
                  );
                },
              );
            }
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
