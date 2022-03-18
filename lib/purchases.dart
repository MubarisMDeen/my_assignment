class Purchases{
  String itemName;
  int quantity;

  Purchases(this.itemName, this.quantity);
  Map toJson() => {
    'itemName': itemName,
    'quantity': quantity,
  };
}