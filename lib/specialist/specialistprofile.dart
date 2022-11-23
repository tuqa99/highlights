import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:highlights/specialist/SpecialSide/compantsspecialist/viewimage.dart';
import '../UserScreens/userProfile/button_widget.dart';
import '../profiledrawer/AccountSpecial.dart';
import 'SpecialSide/compantsspecialist/addimages.dart';
import 'SpecialSide/compantsspecialist/addpackeges.dart';
import 'SpecialSide/compantsspecialist/continarprofile.dart';
import 'SpecialSide/compantsspecialist/read.dart';

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

  Future collections() async {
    User? authen = FirebaseAuth.instance.currentUser;
    List? services;

    CollectionReference ref =
        FirebaseFirestore.instance.collection('specialist');
    await ref
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.forEach((element) {
              print("@@@@@@@@@@@@@@");
              services?.add(element['service']);
              print(services);
            }));
  }

  Future slecteFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedDirectory = result.files.first;
    });
  }

  final admineName = TextEditingController();
  final email = TextEditingController();
  final careercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ButtonWidget(
                        text: 'add images',
                        onClicked: () {
                          showDialog(
                              context: context, builder: (ctx) => addimages());
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                height: 200,
                                width: 300,
                                child: Viewimages(),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 66,
                      ),
                      ButtonWidget(
                        text: 'add packges',
                        onClicked: () {
                          showDialog(
                              context: context, builder: (ctx) => Addpackegs());
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Read_component1(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
