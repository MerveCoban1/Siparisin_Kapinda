import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/components/OrderSection/Cart/screen.dart';
import 'package:siparisin_kapinda/components/OrderSection/Checkout/index.dart';
import 'package:siparisin_kapinda/models/UserSection/addresses_model.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/utils/base_app_bar.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  FirestoreService service = FirestoreService();
  var addresses = [];

  int selectedAddressID = 1;

  @override
  void initState() {
    fetchAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Adres",
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)]),
      body: Container(
        child: Column(
          children: [
            Column(
                children: addresses
                    .map((data) => RadioListTile<dynamic>(
                          title: Text("${data.title}"),
                          groupValue: selectedAddressID,
                          value: data.id,
                          onChanged: (val) {
                            setState(() {
                              selectedAddressID = data.id;
                            });
                          },
                        ))
                    .toList()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    "Ödeme",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/order/checkout');
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  fetchAddresses() async {
    //product doldurulacak firebase ile
    var res = await service.getAddresses(1);
    if (res.isEmpty) {
      print("Veri yok");
    } else {
      setState(() {
        addresses = res;
      });
    }
  }
}
