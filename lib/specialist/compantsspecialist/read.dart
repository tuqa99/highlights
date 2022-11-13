import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Read_component extends StatelessWidget {
  const Read_component({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference packgesRef =
        FirebaseFirestore.instance.collection("packges");
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await packgesRef
                                    .doc(documentSnapshot['url'])
                                    .delete();
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                      // Text(documentSnapshot['desc']),
                      Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage("${documentSnapshot['url']}")),
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

class Readbackgesforuser extends StatelessWidget {
  const Readbackgesforuser({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference packgesRef =
        FirebaseFirestore.instance.collection("packges");
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
                          image: NetworkImage("${documentSnapshot['url']}")),
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
