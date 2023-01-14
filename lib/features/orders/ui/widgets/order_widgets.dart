import 'package:ecommerce_app/features/orders/ui/widgets/order_card.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemBuilder: (context, index) {
          return OrderCard();
        },
        itemCount: 10,
      ),
    );
  }
}
