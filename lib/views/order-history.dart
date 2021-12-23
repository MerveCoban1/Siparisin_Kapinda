import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;
import 'package:siparisin_kapinda/models/order_history_model.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/login_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistoryScreen> {
  FirestoreService service = FirestoreService();
  List displayData = [];
  bool noData = true;

  OrderHistoryState() {
    if (globals.loggedUserId == 0 || globals.loggedUserId == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void getUserOrderHistory() async {
    var orders = await service.getUserOrderHistory(globals.loggedUserId);
    var products = await service.getAllProducts();
    var adresses = await service.getAddresses(globals.loggedUserId);

    List<OrderHistoryListModel> list = <OrderHistoryListModel>[];

    if (orders.length == 0) {
      noData = true;
    } else {
      for (var order in orders) {
        double total = 0;
        var fullAdress = "";
        var title = "";
        noData = false;
        order.items.forEach((element) {
          final Map<String, dynamic> data = element;
          OrderItem item = OrderItem.fromJson(element);

          var prod = products.firstWhere((el) => el.id == item.item_id);

          if (prod != null) {
            var adress = adresses.firstWhere((el) => el.id == order.address_id);

            if (adress != null) {
              total += item.quantity * prod.price;
              title = adress.title;
              fullAdress = adress.fulladdress;
            }
          }
        });
        list.add(OrderHistoryListModel("png", total, title, fullAdress));
      }
      // noData = false;
      setState(() {
        displayData = list;
      });
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    getUserOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Geçmiş Siparişlerim',
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: createAppBar(context),
            body: _myListView(context)));
  }

  Widget _myListView(BuildContext context) {
    if (noData)
      return Center(
        child: Text("Veri Yok"),
      );
    else
      return ListView.separated(
        itemCount: displayData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.amber,
            ),
            title: Text('${displayData[index].title}'),
            subtitle: Text('${displayData[index].adress}'),
            trailing: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('${displayData[index].total} TRY',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        backgroundColor: Colors.amber))),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
  }

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
        'Geçmiş Siparişlerim',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }
}
