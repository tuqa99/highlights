import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../chat/messages.dart';
import '../../../chat/new_message.dart';
import '../../../screens/chat_screen.dart';

class Continarprfile extends StatefulWidget {
  const Continarprfile({super.key});

  @override
  State<Continarprfile> createState() => _ContinarprfileState();
}

class _ContinarprfileState extends State<Continarprfile> {
  final admineName = TextEditingController();
  final email = TextEditingController();
  final careercontroller = TextEditingController();

  String imageprofileurl = '';
  PlatformFile? selectedDirectory;
  String? downloadUrl;
  Future Uplode() async {
    final path = 'test/${selectedDirectory!.name}';
    final file = File(selectedDirectory!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    UploadTask uploadTask = ref.putFile(file);
    final storageSnapshot = uploadTask.snapshot;
    downloadUrl = await storageSnapshot.ref.getDownloadURL();
    print('this a link $downloadUrl');
    SaveData(downloadUrl!);

    Navigator.of(context).pop();
    return downloadUrl;
  }

  Future SaveData(String images) async {
    var auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection('specialist')
        .doc(auth.currentUser!.uid)
        .update({"imageprofileurl": (images)});
  }
  //   Future SaveData(String images) async {
  //   var auth = FirebaseAuth.instance;
  //   await FirebaseFirestore.instance
  //       .collection('specialist')
  //       .doc(auth.currentUser!.uid)
  //       .update({"imageprofileurl": (images)});
  // }

  Future slecteFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedDirectory = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final doc_id = auth!.uid;
    var collection = FirebaseFirestore.instance.collection('specialist');
    return FutureBuilder(
        future: collection.doc(doc_id).get(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');
            var data = snapshot.data!.data();
            List _service = data!['service'];
            Future SaveData2(String images) async {
              List _service = data['service'];
              for (var i = 0; i < _service.length; i++) {
                String collectionname = _service[i].toString();
                print(collectionname);
                FirebaseFirestore.instance
                    .collection(collectionname)
                    .doc(auth.uid)
                    .update({"imageprofileurl": (images)});
              }
            }

            Future Uplode2() async {
              final path = 'test/${selectedDirectory!.name}';
              final file = File(selectedDirectory!.path!);
              final ref = FirebaseStorage.instance.ref().child(path);
              ref.putFile(file);
              UploadTask uploadTask = ref.putFile(file);
              final storageSnapshot = uploadTask.snapshot;
              downloadUrl = await storageSnapshot.ref.getDownloadURL();
              print('this a link $downloadUrl');
              SaveData2(downloadUrl!);

              Navigator.of(context).pop();
              return downloadUrl;
            }

            if (snapshot.hasData) {
              var _fname = data['full name'];
              var _email = data['email'];
              var _profileimage = data['imageprofileurl'];
              return Container(
                height: 200,
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("chang your photo"),
                                      content: Container(
                                          child: Image(
                                        image: NetworkImage('$_profileimage'),
                                      )),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            onPressed: slecteFile,
                                            child: Text('select photo')),
                                        TextButton(
                                          onPressed: () {
                                            Uplode();
                                            Uplode2();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("Update"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage('$_profileimage')),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("chang your photo"),
                                        content: Container(
                                            child: Image(
                                          image: NetworkImage('$_profileimage'),
                                        )),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: slecteFile,
                                              child: Text('select photo')),
                                          TextButton(
                                            onPressed: () {
                                              Uplode;
                                              Uplode2();
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("Update"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                          SizedBox(
                            width: 23,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("chang your name"),
                                      content: Container(
                                          child: TextField(
                                        controller: admineName,
                                      )),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              collection.doc('$doc_id').update({
                                                'full name': admineName.text
                                              });
                                            });

                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("Upadte"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  _fname,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("chang your career"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                collection
                                                    .doc('$doc_id')
                                                    .update({
                                                  'service':
                                                      careercontroller.text
                                                });
                                              });

                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: Text("Upadte",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '$_service',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    _email,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBarIndicator(
                                rating: 4.75,
                                itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Theme.of(context).primaryColor),
                                itemCount: 5,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class Continarprfileview extends StatefulWidget {
  Continarprfileview({
    required this.firstname,
    required this.email,
    required this.profilephotpurl,
    required this.CollectionName,
    required this.index,

    // required career,
  });
  String? CollectionName;
  String? firstname;
  String? email;
  String? profilephotpurl;
  int? index;
  TextEditingController rating = TextEditingController();
  CollectionReference collection =
      FirebaseFirestore.instance.collection('specialist');

  @override
  State<Continarprfileview> createState() => _ContainerProfileViewState();

  // String? career;
}

class _ContainerProfileViewState extends State<Continarprfileview> {
  @override
  Widget build(BuildContext context) {
    int? rating;

    CollectionReference ref =
        FirebaseFirestore.instance.collection(widget.CollectionName!);
    CollectionReference ref2 =
        FirebaseFirestore.instance.collection('specialist');

    var documents = ref.snapshots();
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

    Future<void> updatte([DocumentSnapshot? myDoc]) async {
      if (myDoc != null) {}
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) {
                        return Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value.toInt();
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () async {
                          double sumRating = 0;
                          final int myrating = rating!;
                          List sumlist = [];
                          sumlist.add(myrating);

                          if (myrating != null) {
                            await ref.doc(myDoc!.id).update(
                                {'rating': FieldValue.arrayUnion(sumlist)});

                            // rating. = myrating;
                          }

                          Navigator.pop(context);
                        },
                        child: Text(
                          "Submit",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))
                  ]),
            );
          });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: documents,
      builder: (context, snapshot) {
        DocumentSnapshot document = snapshot.data!.docs[widget.index!];
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            height: 160,
            child: Column(children: [
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage("${widget.profilephotpurl}")),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.firstname!.toUpperCase()}",
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    wordSpacing: 2,
                                    letterSpacing: 2,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(children: [
                                RatingBarIndicator(
                                  itemSize: 21,
                                  rating: ratingAva(document),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () async {
                                    await updatte(document);
                                  },
                                  child: Text(
                                    "Rate Me",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            ]));
      },
    );
  }
}
