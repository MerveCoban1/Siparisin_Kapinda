import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/utils/category.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: controller,
          indicatorColor: Colors.red[400],
          labelColor: Colors.red[400],
          unselectedLabelColor: Colors.grey,
          isScrollable: true,
          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          tabs: [
            Tab(
              child: Text(
                "Yemek",
              ),
            ),
            Tab(
              child: Text(
                "İçecek",
              ),
            ),
            Tab(
              child: Text(
                "Tatlı",
              ),
            ),
            Tab(
              child: Text(
                "Aparatif",
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              Category("yemek"),
              Category("icecek"),
              Category("tatli"),
              Category("aparatif"),
            ],
          ),
        ),
      ],
    );
  }
}
