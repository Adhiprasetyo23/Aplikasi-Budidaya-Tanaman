
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DeskPencegahan.dart';

class viewPencegahan extends StatelessWidget {
  final String id, nama, gambar, deskripsi;

  const viewPencegahan({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.deskripsi, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 2),
      child: Card(
        color: Colors.blue[50],
        elevation: 8,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeskPencegahan(
                          id: id,
                          nama: nama,
                          gambar: gambar,
                          deskripsi: deskripsi,
                        )));
          },
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            gambar,
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nama,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        
                      ],
                    ),
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
