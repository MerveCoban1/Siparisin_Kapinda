import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Adreslerim',
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(context),
          body: createbody(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              FontAwesomeIcons.plus,
              size: 30,
              color: Color(0xFFE57373),
            ),
            backgroundColor: Colors.white,
            onPressed: () => {},
          ),
        ));
  }
}

//Adresler yazılıyor.
Widget createbody() {
  return Container(
    color: const Color(0xFFFFFFFF),
    child: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        const Text(
          'Ev', //firebase'den çekilecek
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(
          height: 15,
          thickness: 2,
          indent: 0,
          endIndent: 0,
        ),
        SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Text(
                'Adres:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Üniversite, İstanbul Ünv. Cerrahpaşa Avcılar Kampüsü No:2, 34320 Avcılar/İstanbul',
                  ), //firebase'den çekilecek
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
      ],
    ),
  );
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
