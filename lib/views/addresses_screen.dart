import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;
import 'package:siparisin_kapinda/globals.dart';

import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/add_address.dart';
import 'package:siparisin_kapinda/views/profile_screen.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  FirestoreService service = FirestoreService();
  List addresses = [];

  @override
  void initState() {
    fetchAddresses();
  }

  //Adres verileri List'e yazılıyor.
  void fetchAddresses() async {
    var res = await service.getUserAddresses(globals.loggedUserId);
    if (res.isEmpty) {
      print("Veri yok");
    } else {
      setState(() {
        addresses = res;
      });
    }
  }

  //Adres başlığı ve adres bilgileri yazılıyor.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adreslerim',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(context),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('addresses')
                .where('user_id', isEqualTo: loggedUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(doc['title'],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black)),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection('addresses')
                                      .doc(doc['documentId'])
                                      .delete();
                                },
                                alignment: Alignment.centerRight,
                                icon: const Icon(
                                  FontAwesomeIcons.trash,
                                  size: 15,
                                  color: Color(0xFFE57373),
                                ))
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Adres: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  doc['fulladdress'],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 15,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ]);
                    });
              } else {
                return const Text(" ");
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              FontAwesomeIcons.plus,
              size: 30,
              color: Color(0xFFE57373),
            ),
            backgroundColor: Colors.white,
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAddress()),
              )
            },
          ),
        ));
  }
}

//AppBar oluşturuluyor.
AppBar createAppBar(context) {
  const primaryColor = Color(0xFFFFFFFF);
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        FontAwesomeIcons.arrowLeft,
        color: Colors.grey,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: const Text(
      'Adreslerim',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    ),
    centerTitle: true,
    backgroundColor: primaryColor,
  );
}
