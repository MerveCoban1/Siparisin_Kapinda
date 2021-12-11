import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/components/OrderSection/Cart/item.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/utils/base_app_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirestoreService service = FirestoreService();
  var cartItems = [];
  double total = 0.0;

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
              width: (MediaQuery.of(context).size.height),
              height: (MediaQuery.of(context).size.height) * 0.75,
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartItemWidget(cartItems[index]);
                },
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("Total Price"), Text(total.toString())],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/order');
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  fetchProducts() async {
    //product doldurulacak firebase ile
    var res = await service.getCart(1);
    var tot = 0.0;
    if (res.isEmpty) {
      print("Veri yok");
    } else {
      for (var element in res) {
        var resEl = await service.getProductDetails(element.item_id);
        if (resEl.name == "") {
          tot += 0.0;
        } else {
          tot += resEl.price;
        }
      }
      setState(() {
        cartItems = res;
        total = tot;
      });
    }
  }
}
