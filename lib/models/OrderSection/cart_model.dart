class CartModel {
  var item_id;
  var quantity;

  CartModel(
    this.item_id,
    this.quantity,
  );
  Map<String, dynamic> toJson() => {
        'item_id': item_id,
        'quantity': quantity,
      };
}
