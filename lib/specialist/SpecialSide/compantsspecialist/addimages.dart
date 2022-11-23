import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:highlights/UserScreens/userProfile/button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class addimages extends StatefulWidget {
  const addimages({super.key});

  @override
  State<addimages> createState() => _addimagesState();
}

String downloadUrl = '';

class _addimagesState extends State<addimages> {
  PlatformFile? selectedDirectory;
  File? myFile;
  var imagePick = ImagePicker();
  List<String> images = [];
  String? profile;
  uploadImageProcess() async {
    var theImageThatIHavePicked =
        await imagePick.pickImage(source: ImageSource.gallery);

    if (imagePick != null) {
      var fileName = basename(theImageThatIHavePicked!.path);
      myFile = File(theImageThatIHavePicked.path);
      var refrenceforMyStorage =
          FirebaseStorage.instance.ref("myimages/$fileName");
      await refrenceforMyStorage.putFile(myFile!);
      var Url1 = await refrenceforMyStorage.getDownloadURL();
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      print(Url1);
      images.add(Url1);
      SaveData(images);
    } else {
      var Url1 = 'add new work';
      images.add(Url1);
      SaveData(images);
    }
  }

  Future SaveData(List<String> images) async {
    var auth = FirebaseAuth.instance;

    await FirebaseFirestore.instance
        .collection('specialist')
        .doc(auth.currentUser!.uid)
        .update({"url": FieldValue.arrayUnion(images)});
    await FirebaseFirestore.instance
        .collection('HairCut')
        .doc(auth.currentUser!.uid)
        .update({"url": FieldValue.arrayUnion(images)});
  }

  TextEditingController imagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("add images of your work"),
      actions: <Widget>[
        ButtonWidget(
          onClicked: uploadImageProcess,
          text: "add",
        ),
        ButtonWidget(
            onClicked: () {
              Navigator.pop(context);
            },
            text: 'ok')
      ],
    );
  }
}
