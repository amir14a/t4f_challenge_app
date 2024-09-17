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
    price = double.parse(json['price']);
    city = json['city'];
    presenter = json['presenter'];
    runtime = int.parse(json['runtime']);
    rate = int.parse(json['rate']);
    url = json['url'];
    id = int.parse(json['id']);
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

  List<(String, String?)> get details {
    return [
      ('ID', id.toString()),
      ('Type', type),
      ('Title', title),
      ('Price', '$price \$'),
      ('City', city),
      ('Presenter', presenter),
      ('Runtime', runtime.toString()),
      ('Rate', rate.toString()),
      ('URL', url),
    ];
  }
}
