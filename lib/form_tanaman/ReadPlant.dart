
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../form_pencegahan/readPencegahan.dart';
import '../form_penyakit/readPenyakit.dart';
import '../home/header_drawer.dart';
import '../home/homeAdmin.dart';
import '../home/tentang.dart';
import '../homeUser/homeUser.dart';
import 'ViewPlant.dart';
import 'form_add.dart';

class ReadPlant extends StatefulWidget {
  @override
  _ReadPlantState createState() => _ReadPlantState();
}

class _ReadPlantState extends State<ReadPlant> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Admin : List Tanaman"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black,),
                title: const Text("Beranda"),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeAdmin()));
                },
              ),
              
              ListTile(
                leading: Image.asset("images/icon/plant.png", width: 25,),
                title: const Text("Budidaya"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ReadPlant()));
                },
              ),
              ListTile(
                leading: Image.asset("images/icon/insect2.png", width: 25,),
                title: const Text("Macam Macam Penyakit"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => readPenyakit()));
                },
              ),
              ListTile(
                leading: Image.asset("images/icon/disenc.png", width: 25,),
                title: const Text("Pencegahan Penyakit"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => readPencegahan()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.black,),
                title: const Text("Info Aplikasi"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const tentang()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.login_outlined, color: Colors.black,),
                title: const Text("Log Out"),
                onTap: () {
                 var box = Hive.box('user').clear();
               
                                                      

              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomeUser()));
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Text('Berhasil Log Out'),
                duration: Duration(seconds: 1),
                )
              );
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
          child: Column(
            children: [
              

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("tanaman")
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : 
                      Column(
                        children: snapshot.data!.docs
                            .map((data) => ViewPlant(
                              id: data.id,
                              nama: data['nama'],
                              keterangan: data['keterangan'],
                              deskripsi: data['deskripsi'],
                              gambar: data['gambar'],
                            ))
                            .toList(),
                      );
                },
              ),

              Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (_) => addTanaman())
                  );
                }, child: Text('Tambah Tanaman')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
