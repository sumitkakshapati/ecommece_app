import 'package:nepali_utils/nepali_utils.dart';

class Product {
  String id;
  String name;
  String description;
  String image;
  String brand;
  num price;
  List<String> catagories;
  bool isInCart;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.brand,
    required this.price,
    required this.catagories,
    required this.isInCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      brand: json['brand'],
      price: json['price'],
      catagories:
          List.from(json['catagories']).map((e) => e.toString()).toList(),
      isInCart: json["added_in_cart"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['catagories'] = this.catagories;
    return data;
  }

  String get formatedPrice {
    return "Rs. ${NepaliNumberFormat().format(price)}";
  }
}
