import 'package:ecommerce_app/features/homepage/ui/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';

class HomepageScreens extends StatelessWidget {
  final TextEditingController searchController;
  const HomepageScreens({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return HomepageWidget(searchController: searchController);
  }
}
