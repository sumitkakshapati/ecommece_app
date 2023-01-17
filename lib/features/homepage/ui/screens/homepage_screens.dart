import 'package:ecommerce_app/features/homepage/cubit/homepage_cubit.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageScreens extends StatelessWidget {
  const HomepageScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(
        repository: RepositoryProvider.of<ProductRepository>(context),
      )..fetchData(),
      child: HomepageWidget(),
    );
  }
}
