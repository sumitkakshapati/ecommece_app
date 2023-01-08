import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/homepage/ui/screens/homepage_screens.dart';
import 'package:flutter/material.dart';

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
        title: Text("E-Commerce"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomTheme.primaryColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: CustomTheme.gray,
        onTap: (value) {
          _controller.animateToPage(
            value,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
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
        ],
      ),
    );
  }
}
