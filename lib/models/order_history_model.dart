class OrderHistoryListModel {
  var iconImageUrl;
  double total;
  var title;
  var adress;

  OrderHistoryListModel(this.iconImageUrl, this.total, this.title, this.adress);
}

class Order {
  var address_id;
  List<dynamic> items;
  var order_id;
  var user_id;

  Order(this.address_id, this.items, this.order_id, this.user_id);
}

class OrderItem {
  var item_id;
  var quantity;

  OrderItem.fromJson(Map<String, dynamic> json)
      : item_id = json['item_id'],
        quantity = json['quantity'];

  OrderItem(this.item_id, this.quantity);
}
