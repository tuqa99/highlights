import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Addpackegs extends StatefulWidget {
  const Addpackegs({super.key});

  @override
  State<Addpackegs> createState() => _AddpackegsState();
}

class _AddpackegsState extends State<Addpackegs> {
  File? myFile;
  var imagePick = ImagePicker();
  String? packages;
  String? decs;

  TextEditingController descriptionpackeg = TextEditingController();
  TextEditingController imagenet = TextEditingController();
  uploadImageProcess() async {
    var theImageThatIHavePicked =
        await imagePick.pickImage(source: ImageSource.gallery);

    if (imagePick != null) {
      var fileName = basename(theImageThatIHavePicked!.path);
      myFile = File(theImageThatIHavePicked.path);
      var refrenceforMyStorage =
          FirebaseStorage.instance.ref("mypackages/$fileName");
      await refrenceforMyStorage.putFile(myFile!);
      var Urlpakeges = await refrenceforMyStorage.getDownloadURL();
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      print(Urlpakeges);
      // addpackeges.add(Urlpakeges);
      var auth = FirebaseAuth.instance;
      CollectionReference addpackeges11 = await FirebaseFirestore.instance
          .collection('specialist')
          .doc(auth.currentUser!.uid)
          .collection('addpakeges');
      addpackeges11.add({"imagepakegurl": Urlpakeges});

      //   AddPackages(addpackeges);
      // } else {
      //   var Urlpakeges = 'add new work';
      //   addpackeges.add(Urlpakeges);
      //   AddPackages(addpackeges);
    }
  }

  // Future AddPackages(List<String> addpackeges) async {
  //   var auth = FirebaseAuth.instance;
  //   await FirebaseFirestore.instance
  //       .collection('specialist')
  //       .doc(auth.currentUser!.uid)
  //       .update({
  //     "packagesurl": FieldValue.arrayUnion([addpackeges])
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    TextEditingController courseController = TextEditingController();
    PlatformFile? selectedDirectory;

    return AlertDialog(
      title: const Text("create your packeg"),
      content: Column(
        children: [
          Container(
              child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal))),
            controller: descriptionpackeg,
          )),
        ],
      ),
      actions: <Widget>[
        TextButton(onPressed: uploadImageProcess, child: Text('Select photo')),
        TextButton(
          onPressed: () async {
            var auth = FirebaseAuth.instance;
            CollectionReference addpackeges11 = await FirebaseFirestore.instance
                .collection('specialist')
                .doc(auth.currentUser!.uid)
                .collection('addpakeges');
            addpackeges11.add({"descripution": descriptionpackeg.text});
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            child: const Text("ok"),
          ),
        ),
      ],
    );
  }
}
