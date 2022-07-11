
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DeskPlant.dart';

class ViewPlant extends StatelessWidget {
  final String id, nama, gambar, deskripsi, keterangan;

  const ViewPlant({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.deskripsi, 
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 5, right: 5, bottom: 5),
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
                    builder: (context) => DeskPlant(
                          id: id,
                          nama: nama,
                          gambar: gambar,
                          deskripsi: deskripsi,
                          keterangan: keterangan,
                        )));
          },
          child: Container(
            width: double.infinity,
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        gambar,
                        width: 150,
                        height: 130,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          nama,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            keterangan,
                            maxLines: 6,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
