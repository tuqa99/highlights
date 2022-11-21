import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../chat/messages.dart';
import '../../chat/new_message.dart';
import '../../screens/chat_screen.dart';

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
        future: collection.doc('$doc_id').get(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              var snap = snapshot.data!.get('service');
              var data = snapshot.data!.data();
              var _fname = data!['full name'];
              var _email = data['email'];
              var _service = data['service'];
              var _profileimage = data['imageprofileurl'];
              // var ab = json.decode(_service).cast().toList();
              return Container(
                height: 200,
                color: Color.fromARGB(255, 250, 91, 165),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              if (selectedDirectory != null)
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
                                            onPressed: Uplode,
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
                                    backgroundImage: _profileimage != null
                                        ? NetworkImage('$_profileimage')
                                        : NetworkImage(
                                            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
                                  ),
                                ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("chang your photo"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: slecteFile,
                                              child: Text('select photo')),
                                          TextButton(
                                            onPressed: Uplode,
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("Upadte"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit)),
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
                                      color: Colors.white),
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
                                              child: const Text("Upadte"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text('change your services')),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email, color: Colors.white),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    _email,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
                                  color: Colors.amber,
                                ),
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

// class ContainerProfileView extends StatefulWidget {
//   ContainerProfileView({
//     required this.firstname,
//     required this.email,
//     required this.profilephotpurl,
//     // required career,
//   });
//   String? firstname;
//   String? email;
//   String? profilephotpurl;
//   double? rating;
//   CollectionReference collection =
//       FirebaseFirestore.instance.collection('specialist');

//   Future<void> updatte([DocumentSnapshot? myDoc]) async {
//     if (myDoc != null) {
//       rating = myDoc['rating'];
//     }
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),child: Column(children: [

//                   ]),);
//         });
//   }

//   @override
//   State<ContainerProfileView> createState() => _ContainerProfileViewState();
// }

// class _ContainerProfileViewState extends State<ContainerProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// edit

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
    String? _profileimage;
    CollectionReference ref =
        FirebaseFirestore.instance.collection(widget.CollectionName!);

    var documents = ref.snapshots();
    ratingAva(DocumentSnapshot document) {
      List allRatings = document['rating'];
      int length = allRatings.length;
      if (length > 1) {
        length = length - 1;
      }
      int sum = 0;
      print(length);
      for (int i = 0; i < allRatings.length; i++) {
        int index = allRatings[i];
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
                        return const Icon(
                          Icons.star,
                          color: Colors.black,
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

                          // for (var i = 0; i < rating.length; i++) {
                          //   sumRating += rating[i];
                          // }

                          // var average = (sumRating / rating.length);
                          // print(average);
                          // print(rating);
                          if (myrating != null) {
                            await ref.doc(myDoc!.id).update(
                                {'rating': FieldValue.arrayUnion(sumlist)});

                            // rating. = myrating;
                          }

                          Navigator.pop(context);
                        },
                        child: Text("Submit"))
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
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 225, 223, 224),
          ),
          height: 130,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileimage != null
                        ? NetworkImage('$_profileimage')
                        : NetworkImage(
                            'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=612x612&w=0&k=20&c=gkvLDCgsHH-8HeQe7JsjhlOY6vRBJk_sKW9lyaLgmLo='),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage('$profilephotpurl'),
                        ),
                        Text(
                          "${widget.firstname!.toUpperCase()}",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                                wordSpacing: 2,
                                letterSpacing: 2,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemSize: 21,
                              rating: ratingAva(document),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () async {
                                await updatte(document);
                              },
                              child: Text(
                                "Rate Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     IconButton(
                            //         onPressed: () {
                            //           Navigator.push(context, MaterialPageRoute(
                            //             builder: (context) {
                            //               return ChatScreen();
                            //             },
                            //           ));
                            //         },
                            //         icon: Icon(Icons.chat_bubble))
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
