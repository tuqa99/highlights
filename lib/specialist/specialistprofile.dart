import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../profiledrawer/AccountSpecial.dart';
import 'compantsspecialist/addimages.dart';
import 'compantsspecialist/addpackeges.dart';
import 'compantsspecialist/continarprofile.dart';
import 'compantsspecialist/read.dart';
import 'compantsspecialist/viewimage.dart';

class Specialistprofileforedit extends StatefulWidget {
  const Specialistprofileforedit({super.key});

  @override
  State<Specialistprofileforedit> createState() =>
      _SpecialistprofileforeditState();
}

class _SpecialistprofileforeditState extends State<Specialistprofileforedit> {
  PlatformFile? selectedDirectory;

  Future Uplode() async {
    final path = 'addimage/${selectedDirectory!.name}';
    final file = File(selectedDirectory!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    UploadTask uploadTask = ref.putFile(file);
    final storageSnapshot = uploadTask.snapshot;
    final downloadUrl = await storageSnapshot.ref.getDownloadURL();
    print('this a link $downloadUrl');
    return downloadUrl;
  }

  Future slecteFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedDirectory = result.files.first;
    });
  }

  final admineName = TextEditingController();
  String firstname = 'Tuqa Omar Abu Dahab';
  final email = TextEditingController();
  String emaild = '123@123.com';
  String career = 'makeup artiste';
  final careercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: AccountSpecial(),
        ),
        appBar: AppBar(
          title: const Text(
            "Specialist",
            style: TextStyle(color: Colors.black),
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: Color.fromARGB(255, 225, 223, 224).withOpacity(.6),
        ),
        body: Stack(
          children: [
            Continarprfile(),
            Padding(
              padding: const EdgeInsets.only(top: 175),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context, builder: (ctx) => addimages());
                        },
                        child: Text('add images')),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Column(
                            //   children: [
                            //     Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 55,
                            //         ),
                            //         Text(
                            //           'My packeges',
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         IconButton(
                            //             onPressed: () {
                            //               showDialog(
                            //                   context: context,
                            //                   builder: (ctx) => Addpackegs());
                            //             },
                            //             icon: const Icon(Icons.add))
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       height: 18,
                            //     ),
                            //     Container(
                            //       height: 300,
                            //       width: 300,
                            //       child: Read_component(),
                            //     ),
                            //     Divider(
                            //       thickness: 3,
                            //       height: 6,
                            //       color: Colors.grey,
                            //     ),
                            //   ],
                            // ),

                            Container(
                              height: 300,
                              width: 300,
                              child: Viewimages(),
                            ),
                            Divider(
                              thickness: 3,
                              height: 6,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       showDialog(
                    //           context: context, builder: (ctx) => Addpackegs());
                    //     },
                    //     child: Text('add Packeges')),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         height: 300,
                    //         width: 300,
                    //         child: Read_component1(),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
