import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:flutter/material.dart';

class ProductCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: CustomTheme.horizontalPadding),
      margin: EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    Assets.productImge,
                    height: 220,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 6),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Iphone 14 Pro Max",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 20,
                              color: CustomTheme.yellow,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                "5/5",
                                style: TextStyle(
                                  color: CustomTheme.gray,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rs. 200,000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
