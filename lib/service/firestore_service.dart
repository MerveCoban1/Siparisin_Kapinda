import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siparisin_kapinda/models/OrderSection/cart_model.dart';
import 'package:siparisin_kapinda/models/UserSection/addresses_model.dart';
import 'package:siparisin_kapinda/models/category_model.dart';
import 'package:siparisin_kapinda/models/company_model.dart';
import 'package:siparisin_kapinda/models/extra_model.dart';
import 'package:siparisin_kapinda/models/order_history_model.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/models/sub_category_model.dart';
import 'package:siparisin_kapinda/models/user_addresses_model.dart';
import 'package:siparisin_kapinda/models/user_info_model.dart';

class FirestoreService {
  //Adres bilgileri Firebaseden alınıyor.
  Future<List> getUserAddresses(var userID) async {
    late List<Addresses> list = <Addresses>[];
    await FirebaseFirestore.instance
        .collection('addresses')
        .where('user_id', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(Addresses(
            doc["id"], doc["title"], doc["fulladdress"], doc["documentId"]));
        print(doc["id"]);
        print(doc["title"]);
        print(doc["fulladdress"]);
      }
    });
    print(list);
    return list;
  }

  Future<List<Order>> getUserOrderHistory(var userId) async {
    late List<Order> list = <Order>[];

    await FirebaseFirestore.instance
        .collection('orders')
        .where('user_id', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(Order(
            doc["address_id"], doc["items"], doc["order_id"], doc["user_id"]));
      }
    });

    return list;
  }

  //Kullanıcı bilgileri Firebase'den alınıyor.
  Future<List> getUserInfo(var userID) async {
    late List<User> list = <User>[];
    await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(User(doc["firstName"], doc["lastName"], doc["email"],
            doc["phoneNumber"]));

        print(doc["firstName"]);
        print(doc["lastName"]);
        print(doc["email"]);
      }
    });
    print(list);
    return list;
  }

  //Kullanıcı bilgileri günleniyor.
  updateInformation(int userId, fNameController, lNameController,
      eMailController, phoneNoController) {
    var ref =
        FirebaseFirestore.instance.collection('users').doc(userId.toString());

    ref
        .update({'firstName': fNameController})
        .then((value) => print("firstName Updated"))
        .catchError((error) => print("Failed to update firstName: $error"));
    ref
        .update({'lastName': lNameController})
        .then((value) => print("lastName Updated"))
        .catchError((error) => print("Failed to update lastName: $error"));
    ref
        .update({'email': eMailController})
        .then((value) => print("email Updated"))
        .catchError((error) => print("Failed to update email: $error"));
    ref
        .update({'phoneNumber': phoneNoController})
        .then((value) => print("phoneNumber Updated"))
        .catchError((error) => print("Failed to update phoneNumber: $error"));
  }

  //henüz kullanılmıyor-extra
  Future<List> getAllCategories() async {
    late List<CategoryModel> categoryList = <CategoryModel>[];
    await FirebaseFirestore.instance
        .collection('category')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        categoryList.add(CategoryModel(doc["id"], doc["name"]));
      });
    });
    return categoryList;
  }
  Future<List> getSubcategoriesByCategoryId(var categoryId) async {
    late List<SubCategoryModel> subcategoryList = <SubCategoryModel>[];
    await FirebaseFirestore.instance
        .collection('subcategory')
        .where('categoryId', isEqualTo: categoryId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        subcategoryList.add(SubCategoryModel(
            doc["id"], doc["categoryId"], doc["image"], doc["name"]));
      });
    });
    return subcategoryList;
  }

  Future<List> getAllProducts() async {
    late List<ProductModel> productList = <ProductModel>[];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        productList.add(ProductModel(
            doc["available"],
            doc["company_id"],
            doc["id"],
            doc["image"],
            doc["name"],
            doc["price"],
            doc["subCategoryId"],
            doc["description"],
            doc["extra"]));
      });
    });
    return productList;
  }

  Future<List<String>> getAllProductNames() async {
    late List<String> productList = <String>[];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        productList.add(doc["name"]);
      });
    });
    return productList;
  }

  Future<List> getProductsBySubcategoryId(var subCategoryId) async {
    late List<ProductModel> productList = <ProductModel>[];
    await FirebaseFirestore.instance
        .collection('products')
        .where('subCategoryId', isEqualTo: subCategoryId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        productList.add(ProductModel(
            doc["available"],
            doc["company_id"],
            doc["id"],
            doc["image"],
            doc["name"],
            doc["price"],
            doc["subCategoryId"],
            doc["description"],
            doc["extra"]));
      });
    });
    return productList;
  }

  Future getCompanyByCompanyId(var companyId) async {
    late CompanyModel company;
    await FirebaseFirestore.instance
        .collection('company')
        .where('id', isEqualTo: companyId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        company = CompanyModel(doc["id"], doc["name"]);
      });
    });
    return company;
  }

  Future<List> getCart(var userID) async {
    late List<CartModel> cartList = <CartModel>[];
    await FirebaseFirestore.instance
        .collection('cart')
        .where('user_id', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        List.from(doc['items']).forEach((element) {
          cartList.add(CartModel(element["item_id"], element["quantity"]));
        });
      });
    });
    return cartList;
  }

  Future getProductDetails(var productID) async {
    late ProductModel product;
    await FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: productID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        product = ProductModel(
            doc["available"],
            doc["company_id"],
            doc["id"],
            doc["image"],
            doc["name"],
            doc["price"],
            doc["subCategoryId"],
            doc["description"],
            doc["extra"]);
      });
    });
    return product;
  }

  Future<List> getAddresses(var userID) async {
    late List<AddressesModel> list = <AddressesModel>[];
    await FirebaseFirestore.instance
        .collection('addresses')
        .where('user_id', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        list.add(AddressesModel(doc["id"], doc["title"], doc["fulladdress"]));
      });
    });
    return list;
  }

  Future makePayment(var userID, var addressID) async {
    try {
      var itemList = await getCart(userID);

      var res = await FirebaseFirestore.instance.collection('orders').add({
        'user_id': userID,
        'items': itemList.map((item) => item.toJson()).toList(),
        'address_id': addressID
      });

      await cleanCart(userID);

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future cleanCart(var userID) async {
    try {
      var documentID = "0";
      var collection = FirebaseFirestore.instance
          .collection('cart')
          .where('user_id', isEqualTo: userID);

      var querySnapshots = await collection.get();

      for (var snapshot in querySnapshots.docs) {
        documentID = snapshot.id;
      }

      var res = await FirebaseFirestore.instance
          .collection('cart')
          .doc(documentID)
          .update({'user_id': userID, 'items': []});

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future addToCart(var userID, var item_id) async {
    try {
      var itemList = await getCart(userID);

      if (itemList.isEmpty) {
        var res = await FirebaseFirestore.instance.collection('cart').add({
          'user_id': userID,
          'items': [
            {'item_id': item_id, 'quantity': 1}
          ],
        });
      } else {
        late List<CartModel> tempArr = <CartModel>[];
        var exist = false;
        itemList.forEach((element) {
          if (element.item_id == item_id) {
            exist = true;
            tempArr.add(CartModel(item_id, element.quantity + 1));
          } else {
            tempArr.add(CartModel(element.item_id, element.quantity));
          }
        });

        if (exist == false) {
          tempArr.add(CartModel(item_id, 1));
        }

        var documentID = "0";
        var collection = FirebaseFirestore.instance
            .collection('cart')
            .where('user_id', isEqualTo: userID);

        var querySnapshots = await collection.get();

        for (var snapshot in querySnapshots.docs) {
          documentID = snapshot.id;
        }

        var res = await FirebaseFirestore.instance
            .collection('cart')
            .doc(documentID)
            .update({
          'user_id': userID,
          'items': tempArr.map((item) => item.toJson()).toList()
        });
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<List> getExtras(item_id) async {
    late List<ExtraModel> extraList = <ExtraModel>[];
    await FirebaseFirestore.instance
        .collection('extras')
        .where('productId', isEqualTo: item_id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        extraList.add(ExtraModel(doc["productId"], doc["name"]));
      });
    });
    return extraList;
  }

  Future addExtras(productId, name) async {
    await FirebaseFirestore.instance
        .collection('extras')
        .add({'productId': productId, 'name': name});
  }

  Future deleteExtrasByName(productId, name) async {
    var collection = FirebaseFirestore.instance.collection('extras');
    var snapshot = await collection
        .where('name', isEqualTo: name)
        .where('productId', isEqualTo: productId)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future deleteExtrasByProductId(productId) async {
    var collection = FirebaseFirestore.instance.collection('extras');
    var snapshot =
        await collection.where('productId', isEqualTo: productId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
