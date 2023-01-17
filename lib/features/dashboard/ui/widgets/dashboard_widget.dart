import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:ecommerce_app/features/cart/ui/screens/cart_page.dart';
import 'package:ecommerce_app/features/homepage/ui/screens/homepage_screens.dart';
import 'package:ecommerce_app/features/orders/ui/screens/order_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DashboardWidgets extends StatefulWidget {
  const DashboardWidgets({super.key});

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  int _selectedIndex = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
        title: Text(
          "E-Commerce",
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await RepositoryProvider.of<UserRepository>(context).logout();
              SnackbarUtils.showSnackBar(
                  context: context, message: "Logged out successfully");
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: LoginPage(), type: PageTransitionType.fade),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _controller.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        iconSize: 22,
        items: [
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Container(
              child: Text('Home'),
              padding: EdgeInsets.only(left: 8),
            ),
            activeColor: CustomTheme.primaryColor,
          ),
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            title: Container(
              child: Text('Cart'),
              padding: EdgeInsets.only(left: 8),
            ),
            activeColor: CustomTheme.lightBlueColor,
          ),
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.cube),
            title: Container(
              child: Text('Orders'),
              padding: EdgeInsets.only(left: 8),
            ),
            activeColor: CustomTheme.darkerBlueColor,
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: [
          HomepageScreens(),
          CartPage(),
          OrderScreens(),
        ],
      ),
    );
  }
}
