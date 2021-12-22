import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/sub_category_model.dart';
import 'package:siparisin_kapinda/views/products_screen.dart';

class CategoryCardWidget extends StatefulWidget {
  late SubCategoryModel subCategories;
  CategoryCardWidget(this.subCategories);

  @override
  _CategoryCardWidgetState createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget>{
  var imageControl=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(widget.subCategories.image==null){
        imageControl=0;
      }else{
        imageControl=1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(widget.subCategories)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            Hero(
              tag: widget.subCategories.name,
              child: (imageControl==0)? Image.asset('assets/images/noImage.PNG'):
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.subCategories.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              widget.subCategories.name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
