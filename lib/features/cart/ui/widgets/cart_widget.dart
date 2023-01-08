import 'package:ecommerce_app/features/cart/ui/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        return CartCard();
      },
      itemCount: 10,
    );
  }
}
