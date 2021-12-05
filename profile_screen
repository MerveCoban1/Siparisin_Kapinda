import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/views/info_screen.dart';
import 'package:siparisin_kapinda/views/addresses_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                  margin: const EdgeInsets.all(15),
                  child: ClipOval(
                      child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7VcSItjWtyt3U8B5iYt6K_B3hRSmji_Yf7w&usqp=CAU',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ))),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Ayşe Küçük',
                    style: TextStyle(
                        fontFamily: 'Barlow', fontWeight: FontWeight.bold),
                  ),
                  Text('aysekucuk@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Open Sans Condensed',
                        color: Colors.grey,
                      )),
                ],
              )
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
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                FontAwesomeIcons.solidUser,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoPage()),
                      );
                    },
                    child: const Text(
                      'Kullanıcı Bilgilerim',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      textAlign: TextAlign.start,
                    )),
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
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                FontAwesomeIcons.locationArrow,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressesPage()),
                    );
                  },
                  child: const Text(
                    'Adreslerim',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.start,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                FontAwesomeIcons.shoppingBasket,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Siparişlerim',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.start,
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
      ]),
    );
  }
}
