import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/sub_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siparisin_kapinda/widgets/category_card_widget.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category(this.categoryName);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late List<Widget> listToShow=[];
  late List<Widget> listToShow2=[];
  late List<SubCategoryModel> subCategories1=<SubCategoryModel>[];
  late List<SubCategoryModel> subCategories2=<SubCategoryModel>[];
  late List<SubCategoryModel> subCategories3=<SubCategoryModel>[];
  late List<SubCategoryModel> subCategories4=<SubCategoryModel>[];
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
    await FirebaseFirestore.instance.collection('subcategory').where('categoryId', isEqualTo: 1).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          subCategories1.add(SubCategoryModel(
              doc["id"],
              doc["categoryId"],
              doc["image"],
              doc["name"]));
        });
      });
    });
    await FirebaseFirestore.instance.collection('subcategory').where('categoryId', isEqualTo: 2).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          subCategories2.add(SubCategoryModel(
              doc["id"],
              doc["categoryId"],
              doc["image"],
              doc["name"]));
        });
      });
    });
    await FirebaseFirestore.instance.collection('subcategory').where('categoryId', isEqualTo: 3).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          subCategories3.add(SubCategoryModel(
              doc["id"],
              doc["categoryId"],
              doc["image"],
              doc["name"]));
        });
      });
    });
    await FirebaseFirestore.instance.collection('subcategory').where('categoryId', isEqualTo: 4).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          subCategories4.add(SubCategoryModel(
              doc["id"],
              doc["categoryId"],
              doc["image"],
              doc["name"]));
        });
      });
    });
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
