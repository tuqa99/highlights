import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/login.dart';
import 'Widget/icon_widget.dart';

class AccountSettings extends StatelessWidget {
  static const KeyDarkMode = 'key-dark-mode';
  Color mycolor = Colors.black;
  static const KeyLanguage = 'key-language';

  User? auth = FirebaseAuth.instance.currentUser;
  FirebaseAuth _auth2 = FirebaseAuth.instance;
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    //signout function
    signOut() async {
      await _auth2.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    Future<void> deleteUser() async {
      FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.all(24),
              children: [
                AccountInformation(),
                Divider(
                  thickness: 2,
                ),
                SettingsGroup(
                  title: 'Dark Mode',
                  children: <Widget>[
                    //===========================Dark Mode=====================================

                    SwitchSettingsTile(
                      title: 'Dark Mode',
                      settingKey: KeyDarkMode,
                      leading: IconWidget(
                        icon: Icons.dark_mode,
                        color: mycolor,
                      ),
                      onChange: (_) {
                        
                      },
                    ),
                  ],
                ),
                SettingsGroup(
                  title: 'General',
                  children: <Widget>[
                    //===========================logout=====================================
                    SimpleSettingsTile(
                      title: 'Logout',
                      leading: IconWidget(
                        icon: Icons.logout,
                        color: mycolor,
                      ),
                      subtitle: '',
                      onTap: () {
                        signOut();
                      },
                    ),
                    //===========================DeleteAccount=====================================
                    SimpleSettingsTile(
                      title: 'Delete Account',
                      leading: IconWidget(
                        icon: Icons.delete,
                        color: mycolor,
                      ),
                      subtitle: '',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text(
                                    "Are you sure you want to Delete your Account??"),
                                content: const Text(":("),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var delete = FirebaseAuth
                                          .instance.currentUser
                                          ?.delete();
                                      db.doc(auth!.uid).delete();
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text(
                                      "Delete my account",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mycolor),
                                    ),
                                  )
                                ]);
                          },
                        );
                      },
                    ),
                    //===========================inforamtion about the app=====================================
                    SimpleSettingsTile(
                      title: 'Info',
                      leading: IconWidget(
                        icon: Icons.info_outline_rounded,
                        color: mycolor,
                      ),
                      subtitle: '',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text("This App was created by: "),
                                content: const Text(
                                    "\n Bayan Swalhah \n Sara Al-Massimi \n Tuqa Abu Dahab \n Amer Melhem"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {},
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mycolor),
                                    ),
                                  )
                                ]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final doc_id = auth!.uid;
    var collection = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: collection.doc('$doc_id').get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var _flname = data!['full name'];
          var _lname = data['last name'];
          var _email = data['email'];
          var _phone = data['phone number'];
          return Container(
            width: 250,
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/profile.jpg"),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "$_flname",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      " $_email ",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                    )),
                SizedBox(
                  height: 7,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "$_phone ",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                    )),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
