import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/views/cart_screen.dart';
import 'package:siparisin_kapinda/views/products_screen.dart';
import 'package:siparisin_kapinda/views/profile_screen.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _contents = [];
  int _activeContentNo = 0;

  @override
  void initState() {
    super.initState();
    _contents = [ProductsScreen(), CartScreen(),ProfileScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: _contents[_activeContentNo],
      drawer: buildDrawer(context),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.grey[400],
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        "Siparişin Kapında",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _activeContentNo,
      selectedItemColor: Colors.red[400],
      unselectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(""),
        ),
      ],
      onTap: (int positionNo) {
        setState(() {
          _activeContentNo = positionNo;
        });
      },
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Merve Çoban"),
            accountEmail: Text("mervecoban@gmail.com"),
            currentAccountPicture:CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 50.0,
              backgroundColor: Colors.grey,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text("Siparişlerim"),
            onTap: (){

            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Ayarlar"),
            onTap: (){

            },
          ),
          Divider(
            height: 10,
            thickness: 0.5,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Çıkış Yap"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}