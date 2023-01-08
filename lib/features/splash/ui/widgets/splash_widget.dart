import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: LoginPage(),
                    type: PageTransitionType.fade,
                  ),
                  (route) => false,
                );
              },
              child: Image.asset(
                Assets.logo,
                height: 260,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
