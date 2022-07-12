
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../home/homeAdmin.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Colors.green,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/logo2.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              'BESTREE',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text('Welcome Back Admin!',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text('Login Here To Manage Content',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: username,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Username",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              SizedBox(height: 13),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: hidePass,
                                controller: password,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_open_outlined),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('Hide Password=$hidePass');
                                      setState(() {
                                        hidePass = !hidePass;
                                      });
                                    },
                                    icon: Icon(hidePass
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: username.text.trim(),
                                            password: password.text.trim());
                                  

                                    if (username.text == username.text &&
                                        password.text == password.text) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => HomeAdmin(),
                                        ),
                                      );
                                      var box = Hive.box('user');
                                      box.put('Login', true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Text('Berhasil Login')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Username / Password Salah")));
                                    }
                                  },
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 37,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
