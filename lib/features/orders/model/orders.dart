import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:ecommerce_app/features/orders/enum/order_status.dart';

class Orders {
  final String id;
  final List<CartModel> cartItems;
  final String fullName;
  final String status;
  final num price;

  const Orders({
    required this.id,
    required this.cartItems,
    required this.fullName,
    required this.status,
    required this.price,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json["_id"],
      cartItems: List.from(json["orderItems"])
          .map((e) => CartModel.fromJson(e))
          .toList(),
      fullName: json["full_name"],
      status: json["status"],
      price: json["totalPrice"],
    );
  }

  OrderStatus get formatedStatus {
    return OrderStatus.fromString(status);
  }
}
