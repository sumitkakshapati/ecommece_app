// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/homepage/model/products.dart';

class CartModel {
  final String id;
  final int quantity;
  final Product product;

  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"],
      quantity: json["quantity"],
      product: Product.fromJson(json['product']),
    );
  }
}
