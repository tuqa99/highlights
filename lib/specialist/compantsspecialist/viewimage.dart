import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewimages extends StatelessWidget {
  const Viewimages({super.key});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final doc_id = auth!.uid;
    var ref = FirebaseFirestore.instance.collection('specialist').doc(doc_id);
    return FutureBuilder(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            List<String> images = List.from(data!['url']);
            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 22, left: 22),
                  child: Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              var collection = FirebaseFirestore.instance
                                  .collection('specialist');

                              collection.doc(doc_id).update({
                                'url': FieldValue.arrayRemove([images[index]])
                              });
                            },
                            icon: Icon(Icons.delete)),
                        Image(
                            height: 100,
                            width: 100,
                            image: NetworkImage("${images[index]}")),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Viewimagesforuser extends StatelessWidget {
  const Viewimagesforuser({super.key});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final doc_id = auth!.uid;
    var ref = FirebaseFirestore.instance.collection('specialist').doc(doc_id);
    return FutureBuilder(
      future: ref.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            List<String> images = List.from(data!['url']);
            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 22, left: 22),
                  child: Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            height: 100,
                            width: 100,
                            image: NetworkImage("${images[index]}")),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
