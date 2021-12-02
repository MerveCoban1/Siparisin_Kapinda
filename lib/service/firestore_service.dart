import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siparisin_kapinda/models/category_model.dart';
import 'package:siparisin_kapinda/models/company_model.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/models/sub_category_model.dart';

class FirestoreService {

  //henüz kullanılmıyor-extra
  Future<List> getAllCategories() async {
    late List<CategoryModel> categoryList=<CategoryModel>[];
    await FirebaseFirestore.instance.collection('category').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        categoryList.add(CategoryModel(
            doc["id"],
            doc["name"])
        );
      });
    });
    return categoryList;
  }

  Future<List> getSubcategoriesByCategoryId(var categoryId) async {
    late List<SubCategoryModel> subcategoryList=<SubCategoryModel>[];
    await FirebaseFirestore.instance.collection('subcategory').where('categoryId', isEqualTo: categoryId).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        subcategoryList.add(SubCategoryModel(
            doc["id"],
            doc["categoryId"],
            doc["image"],
            doc["name"]));
        });
    });
    return subcategoryList;
  }

  Future<List> getProductsBySubcategoryId(var subCategoryId) async {
    late List<ProductModel> productList=<ProductModel>[];
    await FirebaseFirestore.instance.collection('products').where('subCategoryId', isEqualTo: subCategoryId).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        productList.add(ProductModel(
            doc["available"],
            doc["company_id"],
            doc["id"],
            doc["image"],
            doc["name"],
            doc["price"],
            doc["subCategoryId"])
        );
      });
    });
    return productList;
  }

  Future getCompanyByCompanyId(var companyId) async {
    late CompanyModel company;
    await FirebaseFirestore.instance.collection('company').where('id', isEqualTo: companyId).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        company=CompanyModel(
            doc["id"],
            doc["name"]
        );
      });
    });
    return company;
  }

}