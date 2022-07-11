import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../home/header_drawer.dart';
import '../../home/tentang.dart';
import '../homeUser.dart';
import '../penyakit/readPenyakit.dart';
import '../tanaman/ReadPlant.dart';
import 'readPencegahan.dart';

class DeskPencegahan extends StatefulWidget {
  final String id, nama, gambar, deskripsi;

  const DeskPencegahan({
    Key? key,
    required this.id,
    required this.nama,
    required this.gambar,
    required this.deskripsi,
  }) : super(key: key);

  @override
  _DeskPencegahanState createState() => _DeskPencegahanState();
}

class _DeskPencegahanState extends State<DeskPencegahan> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Deskripsi Penyakit"),
        backgroundColor: Colors.green,
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
                      MaterialPageRoute(builder: (context) => const tentang()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                ),
                title: const Text("Login"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const tentang()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/farmers.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: new BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${widget.gambar}",
                            fit: BoxFit.cover,
                            width: 150,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.nama}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Langkah Pencegahan',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "${widget.deskripsi}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
