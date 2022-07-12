
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../form_pencegahan/readPencegahan.dart';
import '../form_penyakit/readPenyakit.dart';
import '../form_tanaman/ReadPlant.dart';
import 'header_drawer.dart';
import 'tentang.dart';
import '../homeUser/homeUser.dart';
import '../screen/login.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Menu Utama Admin"),
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
              // ListTile(
              //   leading: const Icon(Icons.info, color: Colors.black,),
              //   title: const Text("Info Aplikasi"),
              //   onTap: () {
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => const tentang()));
              //   },
              // ),
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
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/farmers.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
        )),
        child: GridView.count(
          padding: const EdgeInsets.all(25),
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ReadPlant())
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Image(image: AssetImage('images/budidaya.png'), 
                      width: 120,
                      height: 120,),

                      Text("Budidaya", style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              // color: Colors.blue,
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => readPenyakit())
                  );
                
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Image(image: AssetImage('images/layu.png'), 
                      width: 120,
                      height: 120,),

                      Text("Penyakit", style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                ),
              ),
            ),

           Card(
              // color: Colors.blue,
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => readPencegahan())
                  );
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Image(image: AssetImage('images/spray.png'), 
                      width: 120,
                      height: 120,),

                      Text("Pencegahan", style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              // color: Colors.blue,
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => tentang())
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Image(image: AssetImage('images/info.png'), 
                      width: 60,
                      height: 60,),
                      SizedBox(height: 30,),
                      Text("Info Aplikasi", style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                ),
              ),
            ),

              
          ],
        ),
      ),
    );
  }
}
