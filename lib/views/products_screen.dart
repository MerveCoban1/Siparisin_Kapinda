import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/sub_category_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/utils/base_app_bar.dart';
import 'package:siparisin_kapinda/widgets/product_card_widget.dart';

class ProductsScreen extends StatefulWidget {
  final SubCategoryModel subCategory;
  ProductsScreen(this.subCategory);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FirestoreService service = FirestoreService();
  var productList = [];

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
          title: widget.subCategory.name,
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)]),
      body: ListView(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: (MediaQuery.of(context).size.height),
              height: (MediaQuery.of(context).size.height) * 0.80,
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCardWidget(productList[index]);
                },
              )),
        ],
      ),
    );
  }

  void fetchProducts() async {
    //product doldurulacak firebase ile
    var incomingProductList =
        await service.getProductsBySubcategoryId(widget.subCategory.id);
    if (incomingProductList.isEmpty) {
      print("Veri yok");
    } else {
      setState(() {
        productList = incomingProductList;
      });
    }
  }
}
