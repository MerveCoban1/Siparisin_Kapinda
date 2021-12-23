import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/auth/auth_service.dart';
import 'package:siparisin_kapinda/components/OrderSection/Cart/screen.dart';
import 'package:siparisin_kapinda/components/OrderSection/Checkout/index.dart';
import 'package:siparisin_kapinda/components/OrderSection/stepper.dart';
import 'package:siparisin_kapinda/views/search_screen.dart';
import 'login_screen.dart';
import 'package:siparisin_kapinda/utils/base_app_bar.dart';
import 'package:siparisin_kapinda/views/categories_screen.dart';
import 'package:siparisin_kapinda/views/profile_screen.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _contents = [];
  int _activeContentNo = 0;

  AuthService _authService = AuthService();
  late String fullName = '';
  late String email = '';

  @override
  void initState() {
    super.initState();
    _authService.getUserById(globals.loggedUserId).then((result) {
      fullName = result.firstName + ' ' + result.lastName;
      email = result.email;
    });
    _contents = [
      CategoriesScreen(),
      SearchScreen(),
      CartScreen(),
      ProfilePage(),
      LoginScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kapinda',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Scaffold(
              backgroundColor: Colors.white,
              appBar: BaseAppBar(
                  title: 'Siparişin Kapında',
                  appBar: AppBar(),
                  widgets: <Widget>[Icon(Icons.more_vert)]),
              body: _contents[_activeContentNo],
              drawer: buildDrawer(context),
              bottomNavigationBar: buildBottomNavigationBar(),
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/order': (context) => StepperDemo(),
        '/order/checkout': (context) => Checkout(),
      },
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
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "",
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
            accountName: Text(fullName),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
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
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Ayarlar"),
            onTap: () {},
          ),
          Divider(
            height: 10,
            thickness: 0.5,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Çıkış Yap"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                globals.loggedUserId = 0;
                return LoginScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
