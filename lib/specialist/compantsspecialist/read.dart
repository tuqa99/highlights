import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Read_component extends StatelessWidget {
  const Read_component({super.key});

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
            List<String> images = List.from(data!['packages']);
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
                                'packages':
                                    FieldValue.arrayRemove([images[index]])
                              });
                            },
                            icon: Icon(Icons.delete)),
                        Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage("${images[index]}"),
                        ),
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

class Readbackgesforuser extends StatelessWidget {
  const Readbackgesforuser({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference packgesRef =
        FirebaseFirestore.instance.collection("addpackeges");
    return StreamBuilder(
      stream: packgesRef.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
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
                      // Text(documentSnapshot['desc']),
                      Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage("${documentSnapshot['URL']}")),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
