import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  // Future Uplode() async {
  //   final path = 'imageadd/${selectedDirectory!.name}';
  //   final file = File(selectedDirectory!.path!);
  //   final ref = FirebaseStorage.instance.ref().child('addimages').child(path);
  //   ref.putFile(file);
  //   downloadUrl = await ref.getDownloadURL();
  //   // UploadTask uploadTask = ref.putFile(file);
  //   // final storageSnapshot = uploadTask.snapshot;
  //   // downloadUrl = await storageSnapshot.ref.getDownloadURL();
  //   print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2');
  //   print('this a link $downloadUrl');
  //   print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2');
  //   FirebaseFirestore imageadd = FirebaseFirestore.instance;
  //   Map<String, dynamic> imageinfo = {'url': downloadUrl};

  //   imageadd.collection('addimages').add(imageinfo);
  //   return downloadUrl;
  // }

  // Future slecteFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;
  //   setState(() {
  //     selectedDirectory = result.files.first;
  //   });
  // }

  File? myFile;

  var imagePick = ImagePicker();

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
      CollectionReference addimages =
          FirebaseFirestore.instance.collection("addimages");
      addimages.add({'url': Url1});
    }
  }

  TextEditingController imagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("chang your photo"),
      actions: <Widget>[
        TextButton(
          onPressed: uploadImageProcess,
          child: Container(
            padding: const EdgeInsets.all(14),
            child: const Text("Upadte"),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('ok'))
      ],
    );
  }
}
