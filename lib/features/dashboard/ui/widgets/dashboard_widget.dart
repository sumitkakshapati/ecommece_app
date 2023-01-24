import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/common/textfield/search_text_field.dart';
import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:ecommerce_app/features/cart/ui/screens/cart_page.dart';
import 'package:ecommerce_app/features/homepage/cubit/home_page_event.dart';
import 'package:ecommerce_app/features/homepage/cubit/homepage_cubit.dart';
import 'package:ecommerce_app/features/homepage/ui/screens/homepage_screens.dart';
import 'package:ecommerce_app/features/orders/ui/screens/order_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class DashboardWidgets extends StatefulWidget {
  const DashboardWidgets({super.key});

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  int _selectedIndex = 0;
  final TextEditingController _textController = TextEditingController();
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    context.read<HomepageCubit>().add(
          FetchAllHomepageDataEvent(query: _textController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
        centerTitle: true,
        title: Container(
          height: AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: SearchtextField(
                    controller: _textController,
                    onSearchPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<HomepageCubit>().add(
                            FetchAllHomepageDataEvent(
                                query: _textController.text),
                          );
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<HomepageCubit>().add(
                        FetchAllHomepageDataEvent(query: _textController.text),
                      );
                },
                icon: Icon(Icons.search),
              ),
            ],
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
          HomepageScreens(
            searchController: _textController,
          ),
          CartPage(),
          OrderScreens(),
        ],
      ),
    );
  }
}
