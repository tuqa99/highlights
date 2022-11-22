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

  String? Typepackge;
  String? myselectedITems;
  List myitemss = ['Bridal', 'Party', 'Birthday', 'Graduation', 'Regualr'];
  TextEditingController discount = TextEditingController();
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
    }
  }

  @override
  void initState() {
    super.initState();
    Typepackge = 'Bridal';
    myselectedITems = "images/wedding.jpg";
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    TextEditingController courseController = TextEditingController();
    PlatformFile? selectedDirectory;

    String myselectedITems = "images/wedding.jpg";

    List myitem = [
      'images/wedding.jpg',
      'images/party.jpg',
      'images/birthday.jpg',
      'images/grad.jpg',
      'images/regular.jpg'
    ];
    return AlertDialog(
      title: const Text("Create your package"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text("Type of package:"),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
                // isExpanded: true,
                dropdownColor: Color.fromARGB(255, 246, 172, 196),
                value: Typepackge,
                items: myitemss
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: ((val) {
                  setState(() {
                    Typepackge = val.toString();
                  });
                })),
            SizedBox(
              height: 30,
            ),
            Text("Description"),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
                controller: descriptionpackeg,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Set a discount"),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal))),
                controller: discount,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Pick or upload a photo"),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
                isExpanded: true,
                dropdownColor: Color.fromARGB(255, 246, 172, 196),
                value: myselectedITems,
                items: myitem
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              '$e',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: ((value) {
                  setState(() {
                    Typepackge = value.toString();
                  });
                })),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var auth = FirebaseAuth.instance;
                  CollectionReference addpackeges11 = await FirebaseFirestore
                      .instance
                      .collection('specialist')
                      .doc(auth.currentUser!.email)
                      .collection('addpakeges');
                  addpackeges11.add({
                    "descripution": descriptionpackeg.text,
                    "TypePackge": Typepackge,
                    "discount": discount.text,
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Add package"))
          ],
        ),
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
            addpackeges11.add({
              "descripution": descriptionpackeg.text,
              "TypePackge": Typepackge,
              "discount": discount.text,
            });
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
