class ItemDataModel {
  String name;
  int id;
  int price;
  int available;
  String vendor;
  String category;
  String imageurl;

  ItemDataModel(
      {this.name,
      this.id,
      this.price,
      this.available,
      this.vendor,
      this.category,
      this.imageurl});

  ItemDataModel.fromJson(map<String,dynamic> json){
    name = json['name'];
    id = json['id'];
    price = json['price'];
    available = json['available'];
    vendor = json['vendor'];
    category = json['category'];
    imageurl = json['imageurl'];
  }
}
