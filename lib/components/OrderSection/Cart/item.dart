import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/OrderSection/cart_model.dart';
import 'package:siparisin_kapinda/models/company_model.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/product_detail_screen.dart';

class CartItemWidget extends StatefulWidget {
  late CartModel cart;
  CartItemWidget(this.cart);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  FirestoreService service = FirestoreService();
  late ProductModel productModel;

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Hero(
          tag: productModel.name,
          child: Container(
            width: 80.0,
            height: 60.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productModel.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        title: Text(productModel.name),
        trailing: InkWell(
          child: Text(productModel.price.toString() + " TRY"),
        ),
        subtitle: Text(" " + productModel.name),
      ),
    );
  }

  void getProductDetail() async {
    productModel = await service.getProductDetails(widget.cart.item_id);
    if (productModel.name == "") {
      print("product yok");
    } else {
      setState(() {
        productModel = productModel;
      });
    }
  }
}
