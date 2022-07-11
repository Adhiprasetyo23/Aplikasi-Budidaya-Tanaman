import 'package:flutter/material.dart';

import '../homeUser/homeUser.dart';
import '../homeUser/pencegahan/readPencegahan.dart';
import '../homeUser/penyakit/readPenyakit.dart';
import '../homeUser/tanaman/ReadPlant.dart';
import '../screen/login.dart';
import 'header_drawer.dart';

class tentang extends StatefulWidget {
  const tentang({Key? key}) : super(key: key);

  @override
  State<tentang> createState() => _tentangState();
}

class _tentangState extends State<tentang> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Info Aplikasi'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text("Beranda"),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeUser()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  "images/icon/plant.png",
                  width: 25,
                ),
                title: const Text("Budidaya"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ReadPlant()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  "images/icon/insect2.png",
                  width: 25,
                ),
                title: const Text("Macam Macam Penyakit"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => readPenyakit()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  "images/icon/disenc.png",
                  width: 25,
                ),
                title: const Text("Pencegahan Penyakit"),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => readPencegahan()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: const Text("Info Aplikasi"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => tentang()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                ),
                title: const Text("Login"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => loginScreen()));
                },
              ),
            ],
          ),
        ),
      ),

      body: Container(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/farmers.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                        width: size.width,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.home,
                                size: 45,
                                color: Colors.grey[600],
                              ),
                              title: Text('Nama Aplikasi'),
                              subtitle: Text('BestTree'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.question_mark,
                                size: 45,
                                color: Colors.grey[600],
                              ),
                              title: Text('Versi Aplikasi'),
                              subtitle: Text('Versi 1.0.0'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.email_outlined,
                                size: 45,
                                color: Colors.grey[600],
                              ),
                              title: Text('Email'),
                              subtitle: Text('besttree@gmail.com'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.info_outline_rounded,
                                size: 45,
                                color: Colors.grey[600],
                              ),
                              title: Text('Hak Cipta'),
                              subtitle: Text('Hak Cipta © 2022 Kelompok 2'),
                            ),
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
