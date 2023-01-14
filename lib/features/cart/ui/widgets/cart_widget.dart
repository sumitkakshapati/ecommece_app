import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_card.dart';
import 'package:ecommerce_app/features/checkout/ui/screens/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) {
              return CartCard();
            },
            itemCount: 10,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: CustomRoundedButtom(
            title: "Checkout",
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: CheckoutPage(),
                  type: PageTransitionType.fade,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
