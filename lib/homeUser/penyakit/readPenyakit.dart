
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../../home/header_drawer.dart';
import '../../home/tentang.dart';
import '../../screen/login.dart';
import '../homeUser.dart';
import '../pencegahan/readPencegahan.dart';
import '../tanaman/ReadPlant.dart';
import 'viewPenyakit.dart';

class readPenyakit extends StatefulWidget {
  @override
  _readPenyakitState createState() => _readPenyakitState();
}

class _readPenyakitState extends State<readPenyakit> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("List Penyakit"),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeUser()));
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
                title: const Text("Login"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>  loginScreen()));
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
        child: SingleChildScrollView (
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("penyakit")
                    .snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : 
                      Column(
                        children: snapshot.data!.docs
                            .map((data) => viewPenyakit(
                              id: data.id,
                              nama: data['nama penyakit'],
                              keterangan: data['keterangan penyakit'],
                              deskripsi: data['deskripsi penyakit'],
                              gambar: data['gambar'],
                            ))
                            .toList(),
                      );
                },
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
