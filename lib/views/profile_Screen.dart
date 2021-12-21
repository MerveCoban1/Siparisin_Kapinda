import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/info_screen.dart';
import 'package:siparisin_kapinda/views/addresses_screen.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;
import '../globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirestoreService service = FirestoreService();
  late String downloadUrl =
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.iconexperience.com%2F_img%2Fv_collection_png%2F512x512%2Fshadow%2Fusers.png&f=1&nofb=1";
  final imagePicker = ImagePicker();
  late File imageFile;
  late String nameAndSurname = '';
  late String email = '';
  List info = [];

  @override
  void initState() {
    super.initState();
    downloadPicture();
    fetchUserInfo();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siparişin Kapında',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          const Divider(
            height: 15,
            thickness: 2,
            indent: 0,
            endIndent: 0,
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      uploadGallery(); //Profil resmini günceller.
                    },
                    child: ClipOval(
                        //Firebase'den profil resmi için veri gelmezse linkteki veri gösterilir.
                        child: downloadUrl == null
                            ? Image.network(
                                "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.iconexperience.com%2F_img%2Fv_collection_png%2F512x512%2Fshadow%2Fusers.png&f=1&nofb=1",
                                fit: BoxFit.cover,
                                height: 130,
                                width: 100,
                              )
                            : Image.network(
                                //Firebade'den alınan veri gösterilir.
                                downloadUrl,
                                fit: BoxFit.cover,
                                height: 130,
                                width: 100,
                              )),
                  ),
                ),
                //Kullanıcı bilgileri profil sayfasına yazılır.
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('userId', isEqualTo: loggedUserId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(doc['firstName'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black87)),
                                      Text(' ' + doc['lastName'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black87)),
                                    ],
                                  ),
                                  Text(doc['email'],
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black87)),
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Text(" ");
                    }
                  },
                ))
              ],
            ),
            height: 130,
            color: Colors.white,
          ),
          const Divider(
            height: 15,
            thickness: 2,
            indent: 0,
            endIndent: 0,
          ),
          //Sayfalar arası geçişler sağlanır.
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Icon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InfoPage()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Kullanıcı Bilgilerim',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      )),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Icon(
                    FontAwesomeIcons.locationArrow,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddressesPage()),
                            );
                          },
                          child: const Text(
                            'Adreslerim',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Icon(
                    FontAwesomeIcons.shoppingBasket,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Siparişlerim',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
          ])
        ]),
      ),
    );
  }

  //Firebase'de profil resmi verisi çekilir. Veri yoksa sabit bir profil resmi atanır.
  downloadPicture() async {
    try {
      String url = await FirebaseStorage.instance
          .ref()
          .child(loggedUserId.toString())
          .child("profilResmi")
          .getDownloadURL();
      setState(() {
        downloadUrl = url;
      });
    } catch (e) {
      setState(() {
        downloadUrl =
            "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.iconexperience.com%2F_img%2Fv_collection_png%2F512x512%2Fshadow%2Fusers.png&f=1&nofb=1";
      });
    }
  }

  //Kullanıcı bilgileri List'e yazılır.
  void fetchUserInfo() async {
    var res = await service.getUserInfo(globals.loggedUserId);
    if (res.isEmpty) {
      print("Veri yok");
    } else {
      setState(() {
        info = res;
      });
    }
  }

  //Kullanıcının yüklediği profil resmi Firebase'e aktarılır.
  uploadGallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });

    Reference referance = FirebaseStorage.instance
        .ref()
        .child(loggedUserId.toString())
        .child("profilResmi");
    UploadTask yuklemeGorevi = referance.putFile(imageFile);
    String url = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      downloadUrl = url;
    });
  }
}
