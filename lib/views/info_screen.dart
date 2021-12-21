import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/profile_screen.dart';
import 'package:siparisin_kapinda/views/update_info_screen.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  FirestoreService service = FirestoreService();
  List info = [];

  //Kullanıcı bilgileri List'e yazılıyor.
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

  @override
  // ignore: must_call_super
  void initState() {
    fetchUserInfo();
  }

  //Kullanıcı bilgileri yazılıyor.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kullanıcı Bilgilerim',
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: createAppBar(context),
            body: Column(
                children: info
                    .map((data) => ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text('Adınız: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87)),
                                    Text(" ${data.firstName}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87)),
                                  ],
                                ),
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
                                    const Text('Soyadınız: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87)),
                                    Text(" ${data.lastName}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87)),
                                  ],
                                ),
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
                                    const Text('E-mail: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87)),
                                    Text(" ${data.email}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87)),
                                  ],
                                ),
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
                                    const Text('Telefon No: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87)),
                                    Text(" ${data.phoneNumber}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87)),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 15,
                                thickness: 2,
                                indent: 0,
                                endIndent: 0,
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UpdateInfoPage()),
                                        );
                                      },
                                      child: const Text(
                                        'Bilgilerimi Güncelle',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]))
                    .toList())));
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
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
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
}
