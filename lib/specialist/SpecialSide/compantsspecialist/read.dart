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
            List<String> packages = (data!['packages']);
            return ListView.builder(
              itemCount: packages.length,
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
                                    FieldValue.arrayRemove([packages[index]])
                              });
                            },
                            icon: Icon(Icons.delete)),
                        Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage(packages[index]),
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

class Read_component1 extends StatelessWidget {
  const Read_component1({super.key});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final docId = auth!.uid;
    CollectionReference addpackeges11 = FirebaseFirestore.instance
        .collection('specialist')
        .doc(docId)
        .collection('addpakeges');
    List<String> packgesimag = [];
    List<String> packgesdes = [];
    packgedes() async {
      await addpackeges11
          .where('descripution', isNull: false)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.data());
          packgesdes.add(element.data().toString());
          print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          print(packgesdes);
        });
      });
    }

    Packgesurlimage() async {
      await addpackeges11
          .where('imagepakegurl', isNull: false)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.data());
          packgesimag.add(element.data().toString());
          print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          print(packgesimag);
        });
      });
    }

    return StreamBuilder(
      stream: addpackeges11.snapshots(),
      builder: (context, orderSnapshot) {
        if (orderSnapshot.hasData)
          // return new Text('Error: ${orderSnapshot.error}');

          //       return CircularProgressIndicator();
          //     default:
          // if (streamSnapshot.connectionState == ConnectionState.done) {
          //   // if (streamSnapshot.hasError) {
          //   //   return Center(
          //   //     child: CircularProgressIndicator(),
          //   //   );
          //   // }
          // } else if (streamSnapshot.hasData) {
          // ignore: curly_braces_in_flow_control_structures
          return ListView.builder(
            itemCount: orderSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  orderSnapshot.data!.docs[index];

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
                                packgedes();
                                Packgesurlimage();
                                print(packgesimag);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                      // Text("${documentSnapshot['descripution']}"),
                      // Image(
                      //     height: 100,
                      //     width: 100,
                      //     image: NetworkImage(
                      //         "${documentSnapshot['imagepakegurl']}")),
                    ],
                  ),
                ),
              );
            },
          );

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
