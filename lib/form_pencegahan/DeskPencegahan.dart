import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import '../form_pencegahan/readPencegahan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../form_penyakit/readPenyakit.dart';
import '../form_tanaman/ReadPlant.dart';
import '../home/header_drawer.dart';
import '../home/homeAdmin.dart';
import '../home/tentang.dart';
import '../homeUser/homeUser.dart';

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
  //CRUD
  final TextEditingController Nama = TextEditingController();
  final TextEditingController Deskripsi = TextEditingController();
  final TextEditingController Keterangan = TextEditingController();

  setup() {
    Nama.text = widget.nama;
    Deskripsi.text = widget.deskripsi;
  }

  Future<void> update() async {
    // final showImage = await uploadFile();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pencegahan = firestore.collection("pencegahan");

    await pencegahan.doc(widget.id).update({
      "nama": Nama.text,
      "deskripsi": Deskripsi.text,
      // "gambar": showImage,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Pencegahan Selesai di Edit")));
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => readPencegahan()));
    });
  }
  //END CRUD

  //FOTO

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    String show;
    String fname = DateTime.now().toString();
    Reference reff =
        FirebaseStorage.instance.ref().child('penyakitPlant/$fname');

    await reff.putFile(_photo!);

    show = await reff.getDownloadURL();
    return show;
  }

  //END FOTO
  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin : Deskripsi Penyakit"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("pencegahan")
                    .doc(widget.id)
                    .delete();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Penyakit Berhasil Dihapus")));
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {
                Nama.text = widget.nama;
                Deskripsi.text = widget.deskripsi;

                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: double.infinity,
                              height: 500,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //NAMA Penyakit
                                        Card(
                                          elevation: 7,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color: Colors.grey.withOpacity(1),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: SizedBox(
                                              height: 60,
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 18),
                                                controller: Nama,
                                                expands: true,
                                                maxLines: null,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Nama Penyakit",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                        //Deskripsi
                                        Card(
                                          elevation: 7,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color: Colors.grey.withOpacity(1),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: SizedBox(
                                              height: 200,
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 18),
                                                controller: Deskripsi,
                                                expands: true,
                                                maxLines: null,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      "Pencegahan Penyakit",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blue[700],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: () async {
                                              update();
                                            },
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
              },
              icon: Icon(Icons.edit))
        ],
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
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
                          style:
                              TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
    );
  }
}
