import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kullanıcı Bilgilerim',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(context),
          body: createbody(context),
        ));
  }
}

//Kullanıcı bilgileri güncelleniyor.
Widget createbody(context) {
  TextEditingController tittleController = TextEditingController();
  TextEditingController fulladdressController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Adres ID:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: idController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: "1",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Adres Başlığı:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: tittleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'Ev',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Adres:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: fulladdressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          //Adres verileri firebase'e kayıt ediliyor.
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFE57373),
                    shadowColor: const Color(0x00e0e0e0),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    var ref = DateTime.now().toString();
                    Map<String, dynamic> addressData = {
                      'title': tittleController.text,
                      'id': int.parse(idController.text),
                      'fulladdress': fulladdressController.text,
                      'user_id': globals.loggedUserId,
                      'documentId': ref,
                    };
                    FirebaseFirestore.instance
                        .collection('addresses')
                        .doc(ref)
                        .set(addressData);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ekle',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//AppBar oluşturuluyor
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
      'Kullanıcı Bilgilerim',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    ),
    centerTitle: true,
    backgroundColor: primaryColor,
  );
}
