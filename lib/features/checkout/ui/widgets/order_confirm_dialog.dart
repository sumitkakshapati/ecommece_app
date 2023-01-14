import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderConfirmDialog extends StatelessWidget {
  const OrderConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Container(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Order Confirmed Successfully",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      content: Image.asset(
        Assets.orderConfirm,
        height: 200,
        width: 200,
      ),
      actions: [
        CustomRoundedButtom(
          title: "DONE",
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        )
      ],
    );
  }
}
