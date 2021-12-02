import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/widgets/category_card_widget.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category(this.categoryName);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  FirestoreService service=FirestoreService();
  late List<Widget> listToShow=[];
  late List<Widget> listToShow2=[];

  var subCategories1=[];
  var subCategories2=[];
  var subCategories3=[];
  var subCategories4=[];
  @override
  void initState(){
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      padding: EdgeInsets.all(10.0),
      childAspectRatio: 1.3,
      children: listToShow2,
    );
  }

  void fetchData() async{
    subCategories1=await service.getSubcategoriesByCategoryId(1);
    subCategories2=await service.getSubcategoriesByCategoryId(2);
    subCategories3=await service.getSubcategoriesByCategoryId(3);
    subCategories4=await service.getSubcategoriesByCategoryId(4);

    //selection
    if (widget.categoryName == 'yemek') {
      subCategories1.forEach((element) {
        setState(() {
          listToShow.add(CategoryCardWidget(element));
          listToShow2=listToShow;
        });
      });
    } else if (widget.categoryName == 'icecek') {
      subCategories2.forEach((element) {
        setState(() {
          listToShow.add(CategoryCardWidget(element));
          listToShow2=listToShow;
        });
      });
    } else if (widget.categoryName == 'tatli') {
      subCategories3.forEach((element) {
        setState(() {
          listToShow.add(CategoryCardWidget(element));
          listToShow2=listToShow;
        });
      });
    } else if (widget.categoryName == 'aparatif') {
      subCategories4.forEach((element) {
        setState(() {
          listToShow.add(CategoryCardWidget(element));
          listToShow2=listToShow;
        });
      });
    }
  }

}
