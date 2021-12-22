import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';

class ExtraCardWidget extends StatefulWidget {
  var productId;
  var productExtraKey;
  var productExtraValue;
  var selectedName;
  ExtraCardWidget(this.productId,this.productExtraKey, this.productExtraValue,this.selectedName);

  @override
  _ExtraCardWidgetState createState() => _ExtraCardWidgetState();
}

class _ExtraCardWidgetState extends State<ExtraCardWidget>{
  FirestoreService service = FirestoreService();
  var color=Colors.white.withOpacity(0.5);
  var extra;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(color == Colors.red.withOpacity(0.5)){
          setState(() {
            color=Colors.white.withOpacity(0.5);
            widget.selectedName.remove(widget.productExtraKey);
            //dbden silelim
            deleteDb(widget.productExtraKey);
          });
        }else{
          setState(() {
            color=Colors.red.withOpacity(0.5);
            widget.selectedName.add(widget.productExtraKey);
            //dbye ekleyelim
            addDb(widget.productExtraKey);
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: new EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Text(
          ""+widget.productExtraKey,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void addDb(var name) async{
    service.addExtras(widget.productId,name);
  }

  void deleteDb(name) async{
    service.deleteExtrasByName(widget.productId,name);
  }
}
