import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel product;
  var companyName;
  ProductDetailScreen(this.product,this.companyName);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.product.name,
                child: Image.network(
                  widget.product.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.40,
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
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              Container(
                width: MediaQuery.of(context).size.width*0.90,
                height: MediaQuery.of(context).size.height*0.031,
                child: Text(
                  widget.companyName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              Container(
                width: MediaQuery.of(context).size.width*0.90,
                height: MediaQuery.of(context).size.height*0.03,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              Container(
                width: MediaQuery.of(context).size.width*0.90,
                height: MediaQuery.of(context).size.height*0.25,
                child: Text(
                  "Bu bölümde ürün açıklaması bulunacak. ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              Container(
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.05,
                child: Text(
                  widget.product.price.toString()+" TL",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[400],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              InkWell(
                onTap: (){
                  if(widget.product.available){
                    Navigator.pop(context);
                    /*
                    *
                    *
                    *
                    * Sepete ekleme işlemi yapılacak.
                    *
                    *
                    *
                    * */
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-50.0,
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                    color: widget.product.available ? Colors.red[400]:Colors.black,
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
}
