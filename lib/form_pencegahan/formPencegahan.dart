import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../form_penyakit/readPenyakit.dart';
import '../form_tanaman/ReadPlant.dart';
import '../home/header_drawer.dart';
import '../home/homeAdmin.dart';
import '../home/tentang.dart';
import '../homeUser/homeUser.dart';
import 'readPencegahan.dart';

class formPencegahan extends StatefulWidget {
  @override
  _formPencegahanState createState() => _formPencegahanState();
}

class _formPencegahanState extends State<formPencegahan> {
  //CRUD
  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController keterangan = TextEditingController();

  Future<void> simpan() async {
    final showImage = await uploadFile();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pencegahan = firestore.collection("pencegahan");

    await pencegahan.add({
      "nama": nama_penyakit,
      "deskripsi": deskripsi.text,
      "gambar": showImage,
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

  Future<List<QueryDocumentSnapshot>> Penyakit() async {
    var firebaseUser =
        await FirebaseFirestore.instance.collection("penyakit").get();
    return firebaseUser.docs;
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
        FirebaseStorage.instance.ref().child('PencegahanPlant/$fname');

    await reff.putFile(_photo!);

    show = await reff.getDownloadURL();
    return show;
  }
  //END FOTO

  final formKey = GlobalKey<FormState>();

  String? nama_penyakit = null;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Admin : Form Pencegahan"),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      
                      //NAMA PENYAKIT
                      Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(1),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: FutureBuilder(
                            future: Penyakit(),
                            builder: (conctext,
                                AsyncSnapshot<List<QueryDocumentSnapshot>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: DropdownButtonHideUnderline (
                                    child: DropdownButton(
                                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                                      disabledHint: Text("Disabled"),
                                      hint: Text('Pilih Nama Penyakit'),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                      items: [
                                        for (var data in snapshot.data!)
                                          DropdownMenuItem(
                                            child: Text(data.get("nama penyakit")),
                                            value: data.get("nama penyakit"),
                                          ),
                                      ],
                                      value: nama_penyakit,
                                      onChanged: (selected) {
                                        setState(() {
                                          nama_penyakit = selected?.toString() ??
                                              "Penyakit Tidak diketahui";
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),

                      
                      //Deskripsi 
                      Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(1),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            height: 200,
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              controller: deskripsi,
                              expands: true,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Pencegahan Penyakit",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      //IMAGE
                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                        
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 10),
                              child: Text(
                                'Foto Penyakit',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: _photo != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            child: Image.file(
                                              _photo!,
                                              height: 200,
                                              width: 240,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 150,
                                          height: 150,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                          ],
                        ),
                      ),
                      

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    simpan();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: Duration(seconds: 2),
                                            content:
                                                Text("Tanaman Tersimpan")));

                                    Navigator.of(context).pop(MaterialPageRoute(
                                        builder: (_) => readPencegahan()));
                                  }
                                },
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.black),
                                ))),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
