import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/widgets/extra_card_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel product;
  var companyName;
  ProductDetailScreen(this.product, this.companyName);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  FirestoreService service = FirestoreService();
  var productExtraKeys;
  var productExtraValues;
  var selectedName=[];
  var imageControl=0;

  @override
  void initState() {
    deleteExtras();
    setState(() {
      productExtraKeys=widget.product.extra.keys.toList();
      productExtraValues=widget.product.extra.values.toList();

      if(widget.product.image==null){
          imageControl=0;
      }else{
          imageControl=1;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.product.name,
                child: (imageControl==0)? Image.asset('assets/images/noImage.PNG'):
                Image.network(
                  widget.product.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.red[400],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.036,
                child: Text(
                  widget.companyName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.03,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  ""+widget.product.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Lütfen istediğiniz ürünleri seçiniz.",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.07,
                child:  ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: productExtraKeys.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: ExtraCardWidget(widget.product.id,productExtraKeys[index],productExtraValues[index],selectedName),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  widget.product.price.toString() + " TL",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[400],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: () {
                  if (widget.product.available) {
                    Navigator.pop(context);
                    service.addToCart2(1, widget.product.id);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: widget.product.available
                        ? Colors.red[400]
                        : Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      widget.product.available ? "Sepete Ekle" : "Stokta yok",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteExtras() async{
  }
}