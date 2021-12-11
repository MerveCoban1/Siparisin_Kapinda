import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/utils/all_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:siparisin_kapinda/widgets/search/search_items.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirestoreService service = FirestoreService();
  TextEditingController editingController = TextEditingController();

  late var duplicateItems = <String>[];
  var items = <String>[];
  var showList = false;

  @override
  void initState() {
    showList = false;
    fetchProducts();
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  void fetchProducts() async {
    var incomingProductNames = await service.getAllProductNames();
    if (incomingProductNames.isEmpty) {
      print("Veri yok");
      duplicateItems.add("veri yok");
    } else {
      setState(() {
        duplicateItems = incomingProductNames;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Container(
                          width: 50,
                          height: 70,
                          color: Colors.white,
                          child: TextField(
                            onChanged: (value) {
                              showList = true;
                              filterSearchResults(value);
                            },
                            controller: editingController,
                            decoration: const InputDecoration(
                                labelText: "Ara",
                                hintText: "Canınız ne çekiyor?",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 240,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        if (showList == true)
                          Container(
                            child: Container(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('${items[index]}'),
                                  );
                                },
                              ),
                            ),
                          ),
                        Container(
                          width: 50,
                          height: 170,
                          color: Colors.grey[200],
                          child: AllCategories(),
                        ),
                        Container(
                          width: 50,
                          height: 270,
                          color: Colors.green,
                          child: SearchItems(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
