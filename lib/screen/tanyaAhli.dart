// ignore_for_file: deprecated_member_use

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/header_drawer.dart';
import '../home/tentang.dart';
import '../homeUser/homeUser.dart';
import '../homeUser/pencegahan/readPencegahan.dart';
import '../homeUser/penyakit/readPenyakit.dart';
import '../homeUser/tanaman/ReadPlant.dart';
import 'login.dart';

class tanya extends StatefulWidget {
  @override
  _tanyaState createState() => _tanyaState();
}

class _tanyaState extends State<tanya> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController questController = TextEditingController();
  final String whatsappUrl =
      'https://api.whatsapp.com/send?phone=+6282329833472';

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    alamatController = TextEditingController();
    questController = TextEditingController();
  }

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    questController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Menu Utama"),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => readPenyakit()));
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const tentang()));
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
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView (
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'images/logo2.png',
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Any Question?',
                      style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),),
                        
                        hintText: 'Nama',
                        labelText: 'Nama',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: alamatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),),
                        hintText: 'Alamat',
                        labelText: 'Alamat',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: questController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),),
                        hintText: 'Pertanyaan',
                        labelText: 'Pertanyaan',
                      ),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15),
                    ),
                    color: Colors.greenAccent[400],
                    onPressed: () async {
                      String nama = namaController.text.replaceAll(" ", " ");
                      String alamat = alamatController.text.replaceAll(" ", " ");
                      String quest = questController.text.replaceAll(" ", " ");
                      String encodedNama = Uri.encodeQueryComponent(nama);
                      String encodedAlamat = Uri.encodeQueryComponent(alamat);
                      String encodedQuest = Uri.encodeQueryComponent(quest);
                      AndroidIntent intent = AndroidIntent(
                        action: 'action_view',
                        data:
                            '$whatsappUrl&text=Nama : $encodedNama\nAlamat : $encodedAlamat\nPertanyaan : $encodedQuest',
                      );
                      await intent.launch();
                    },
                    child: SizedBox(
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Send",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.send_sharp,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
