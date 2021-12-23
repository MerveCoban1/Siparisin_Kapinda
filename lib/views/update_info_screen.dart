import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/auth/auth_service.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;
import 'package:siparisin_kapinda/service/firestore_service.dart';

class UpdateInfoPage extends StatefulWidget {
  const UpdateInfoPage({Key? key}) : super(key: key);

  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kullanıcı Bilgilerimi Güncelle',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(context),
          body: createbody(context),
        ));
  }
}

//Kullanıcı bilgilerini güncellemek için form oluşturuluyor.
Widget createbody(context) {
  FirestoreService service = FirestoreService();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

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
              'Adınız:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: fNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: "Ayşe",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Soyadınız:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: lNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'Küçük',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'E-mail:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: eMailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'aysekucuk@gmail.com',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Telefon Numarası',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: phoneNoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE57373), width: 5.0),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: '(555)-555-55-55',
              ),
            ),
          ),
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
                  onPressed: () {
                    //Kullanıcının girdiği değerler Firebase yazılıyor.
                    service.updateInformation(
                        globals.loggedUserId,
                        fNameController.text,
                        lNameController.text,
                        eMailController.text,
                        phoneNoController.text);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Onayla',
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
      'Kullanıcı Bilgilerimi Güncelle',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    ),
    centerTitle: true,
    backgroundColor: primaryColor,
  );
}
