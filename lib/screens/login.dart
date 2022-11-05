import 'package:flutter/material.dart';

import '../UserScreens/allscreens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 241, 17, 92),
          Color.fromARGB(255, 247, 90, 142),
          Color.fromARGB(255, 240, 198, 213)
        ])),
        child: Card(
          color: Colors.white,
          elevation: 4,
          margin: EdgeInsets.fromLTRB(50, 110, 60, 80),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        'Wellcome',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Please Login to Your Account',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(148, 54, 46, 46)),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.pinkAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email address',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 22, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.password,
                          color: Colors.pinkAccent,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 15, color: Colors.pinkAccent),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(60, 22, 60, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          print(nameController.text);
                          print(passwordController.text);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MainPage();
                            },
                          ));
                        },
                      )),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 22,
                      ),
                      const Text(
                        'Does not have account?',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 240, 110, 153)),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '0r Login using ',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Image(
                            height: 30,
                            width: 30,
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/128/300/300221.png')),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        child: Image(
                            height: 30,
                            width: 30,
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/128/5968/5968764.png')),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
