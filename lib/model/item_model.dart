class ItemModel {
  ItemModel({
    this.type,
    this.title,
    this.image,
    this.price,
    this.city,
    this.presenter,
    this.runtime,
    this.rate,
    this.url,
    this.id,
  });

  static List<ItemModel> fromListMap(List<dynamic> list) {
    List<ItemModel> itemsList = List<ItemModel>.from(list.map((i) => ItemModel.fromJson(i)));
    return itemsList;
  }

  ItemModel.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    image = json['image'];
    price = json['price']?.toDouble();
    city = json['city'];
    presenter = json['presenter'];
    runtime = json['runtime']?.toInt();
    rate = json['rate']?.toInt();
    url = json['url'];
    id = json['id']?.toInt();
  }

  String? type;
  String? title;
  String? image;
  double? price;
  String? city;
  String? presenter;
  int? runtime;
  int? rate;
  String? url;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['image'] = image;
    map['price'] = price;
    map['city'] = city;
    map['presenter'] = presenter;
    map['runtime'] = runtime;
    map['rate'] = rate;
    map['url'] = url;
    map['id'] = id;
    return map;
  }
}
