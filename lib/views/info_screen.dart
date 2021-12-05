import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kullanıcı Bilgilerim',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(context),
          body: createbody(),
        ));
  }
}

//Kullanıcı bilgileri yazılılıyor.
Widget createbody() {
  final _formKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Padding(
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'Ayşe',
              ),
            ),
          ),
          Padding(
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'Küçük',
              ),
            ),
          ),
          Padding(
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                hintText: 'aysekucuk@gmail.com',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: null, //() {},
              child: Text('Bilgilerimi Güncelle'),
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
