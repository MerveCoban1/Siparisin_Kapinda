import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/models/company_model.dart';
import 'package:siparisin_kapinda/models/product_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/views/product_detail_screen.dart';

class SearchProductCardWidget extends StatefulWidget {
  late ProductModel product;
  String text;
  SearchProductCardWidget(this.product, this.text);

  @override
  _SearchProductCardWidgetState createState() =>
      _SearchProductCardWidgetState();
}

class _SearchProductCardWidgetState extends State<SearchProductCardWidget> {
  FirestoreService service = FirestoreService();
  late CompanyModel companyModel = new CompanyModel(0, "-");

  @override
  void initState() {
    super.initState();
    getCompany();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.name.toLowerCase().contains(widget.text)) {
      return Card(
        child: ListTile(
          leading: Hero(
            tag: widget.product.name,
            child: Container(
              width: 80.0,
              height: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          title: Text(widget.product.name),
          trailing: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                          widget.product, companyModel.name)));
            },
            child: Icon(Icons.open_in_full),
          ),
          subtitle: Text(" " + companyModel.name),
        ),
      );
    } else {
      return Container();
    }
  }

  void getCompany() async {
    companyModel =
        await service.getCompanyByCompanyId(widget.product.company_id);
    if (companyModel.name == "") {
      print("Company yok");
    } else {
      setState(() {
        companyModel = companyModel;
      });
    }
  }
}
